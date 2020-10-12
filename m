Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D74C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 01:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F7B2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 01:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWKnvrRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F7B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRmSS-0001h4-19
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 21:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRmRt-0001Hw-7M
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 21:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRmRq-0006vY-Ay
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 21:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602465379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4APQvjMvE4UF7mowk3Gca6QSvfVQU6g6n3ktK5byVGk=;
 b=CWKnvrRRvVuCtUDme18cosyRxIYrfbIlN7uCWuDL9M/eHaQ1VrTYjepqKjP/uYzTE1xLDZ
 Xk5whtiOcbxvCb9NCQ7f9LyFk5NF5KqSdhzBNktC4BPnIFNRy0T48vkdL4aGkg2OdqLrsz
 lXOJxirQUYH/UMj0hLGI1m9Z3nU/3AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-tAOA1LFuNYyMA71RTGdiYg-1; Sun, 11 Oct 2020 21:16:15 -0400
X-MC-Unique: tAOA1LFuNYyMA71RTGdiYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2EC802B48;
 Mon, 12 Oct 2020 01:16:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 161985DA33;
 Mon, 12 Oct 2020 01:16:09 +0000 (UTC)
Date: Sun, 11 Oct 2020 21:16:08 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/3] Acceptance tests: bump pycdlib version for easier
 installation
Message-ID: <20201012011608.GA887538@localhost.localdomain>
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-2-crosa@redhat.com>
 <90377288-f072-daee-c638-373382ff5efb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <90377288-f072-daee-c638-373382ff5efb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 21:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Bug 1897783 <1897783@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2020 at 09:36:17AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/9/20 10:55 PM, Cleber Rosa wrote:
> > On with certain versions of "pip", package installations will attempt
> > to create wheels.  And, on environments without a "complete" Python
> > installation (as described in the acceptance tests requirements docs),
> > that will fail.
> >=20
> > pycdlib, starting with version 1.11.0, is now being made available
> > as wheels, so its instalation on those constrained environments is
> > now possible.
> >=20
> > Cc: Bug 1897783 <1897783@bugs.launchpad.net>
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
>=20
> This BZ is different. The correct URL is:
> https://bugs.launchpad.net/qemu/+bug/1897783
>

Good catch, thanks!

- Cleber.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+DrlYACgkQZX6NM6Xy
CfNIsw//VI+Eq/dt7r8WetnFgHSH/lxFqoG4whhhvIe1woGw80+0f7QIe4ZGQwYr
ITFSobk8Qt/1V6KiACGARWYkrOqm9RSNSTfzqyAnNcaOaQdFWgdX7mHFMYtePQho
aH+Tgk0fsJ/04zLPLvAMyPr5YpwbRaOhJgxB/ZLp8ea1tU4uJdO68zqVMh7QMLsi
fdjVcOQ4uMkefRojhQhD/N81Z71LG9/hXAVoYMuNSu5xJW/XtiK5vKQCQENyZeon
zK4EkJgXC5+qm0CRSRKVSJEzx4dH94IwsRpmyO/7Izu28m/95EJieEZrXzFJCkMU
V3rl/TWGvTvthrF9nk3cCYPRISjUAjr6IwFduChclIvYz2SQRSnV/TzIB4wvmDPE
AJYLWt/2Bi/y0VN3IG20cTaSYayh3WINlQgsGQfGiq9bh5ff0pfGfKH/ixJlJv/O
1RH09ClU3ixTozGF+bR43+5DyBsG7US569BdH1hQdPlKuXIvklLDyNe542eM9i9M
NCRZE4HXqGxc51Xc0sK3BD85hEn0M1Ty6AdkjQonQMzAQZPlam3DEhZbWMxoNx/J
H/KPlbS3y0sue87xfov5gvG+D9S23dFiGygAnG7q6iI3IAS1gI3FVfWxkFCQ5Kg0
TFHqXAcqu18Sc1fceUg/9jX8lTQ+KOsoFLo0LuP0pv9cAdDpwmU=
=RTgs
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


