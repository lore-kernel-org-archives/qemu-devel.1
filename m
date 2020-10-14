Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E0E214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We2xYKeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E0E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmTL-0000Ag-GH
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSmJc-0007Lo-Mx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSmJb-0001U9-4z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602703198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVFo9UOm/mmyPh322yQgMOIvggL7TqxnrYUCdvaEA18=;
 b=We2xYKeCjOHS5/8zs/N5oj+xw8wdBNqflqQmCoH+KYkD/wNdfJYiqi4JfhQYH3YIA/V9pQ
 ZWh/VZ25A3JwK376Ardw184UlFUtIxCoBghX3+jTyfk/WyHfizO9uprAVRQcZwVjQ6bAbe
 Nupi3Y5GPzSCgI7Q6u+hgW9IYkf0Qmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Zmzl4LbYN1KH8BecWNkpUg-1; Wed, 14 Oct 2020 15:19:55 -0400
X-MC-Unique: Zmzl4LbYN1KH8BecWNkpUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00E6E6A29F;
 Wed, 14 Oct 2020 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 316335D9CD;
 Wed, 14 Oct 2020 19:19:49 +0000 (UTC)
Date: Wed, 14 Oct 2020 15:19:47 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201014191947.GB1196177@localhost.localdomain>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-3-crosa@redhat.com>
 <20201014173009.GU115189@redhat.com>
 <20201014185952.GA1196177@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201014185952.GA1196177@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 02:59:58PM -0400, Cleber Rosa wrote:
> On Wed, Oct 14, 2020 at 06:30:09PM +0100, Daniel P. Berrang=E9 wrote:
> >=20
> > This needs updating to add meson, and with Paolo's series today you
> > might as well go ahead and add ninja-build immediately too
> >

I replied too quickly, but allow me to get this right: meson is *not*
included in the dockerfiles (and other similar configurations), and
all setups I found rely on the submodule.  Are suggesting to add meson
and diverge from the dockerfiles?

> > https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg04025.html
> >

^ I'll add meson according to this, of course.

Thanks,
- Cleber.

> > Same for all the other distro package lists.
> >=20
> >

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+HT1EACgkQZX6NM6Xy
CfOaBxAAlFw6H7F4/plIV2py1zbIjKlpl/GTcagJkxcwbnJdTrAOYZk80I/wGcHY
2GWxSx4BSTyk2cRK2aMnxFxRN1yjq8MW5jjaE9OrSSHGK0axkETrbQe574qYKsT/
Oc0jUyAnDx39mErMGF68wrAEVhlYn6L+7IJYmZUcmg0O7gOWgP/cQrnBT9ilzEvw
gzbZD4h1HviP5Kf3i6xNe9IpmsVGJREU5lZQFFovULQ+Xl0soBSBvwiPTI9csOac
BeYYdVmreavUf334y+dytkcpsbW9B+s6olrUFbYr5mP+svdpO2lwM2MgLyYhjcbB
qoFHdPAXFr4toZRWq8fYmPJjEBcfOmCQDkLkgubZ334eJyGuRAEW94SGG9xklqsV
DRqdxfl5DQKjY2EzGbNbGkr7DNmSi7SdYqm757lQ3/aMSYUdaVay10EukGqcTxuW
hzHaBzG3Hzeg5yc9dOQMU4a0xoX2IG/1ouLYWCCuby4wVWwDvqbilPkzwCPU/V81
U4aUeKCjoGyN3pBNzKzw/7F/yZi5M2wbWuikIRgcwJzp9U8lqRsqPrFD/s9EMkQF
AVmKoaiv5H49zBozFwtH+ZkqGDNbI9mk59NZc7pF7hA1TDBAWPUvyWQCdAg1fy8G
0b70sxTHsUKhHvb9dCQ/3ztRk5xcmCZ+OKAHn9ri22bL0SjbxdE=
=aHf4
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--


