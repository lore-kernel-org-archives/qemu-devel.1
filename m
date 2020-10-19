Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E56C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F77223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHRQWghu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F77223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbcR-0005oa-JG
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbbT-0005DF-PC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbbR-0002Mw-Os
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603138675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnfWf9oWz8NkNRFHjIPgXM+LCAHv4aFjd1Ebo4fblWY=;
 b=KHRQWghuW+8d0FnR7PaTM/789sN0J31mVHCv+mNkHnQ0U+m6/+FnW9bq6Vc8QfeNH2tYR3
 IPVbccOqIZzHJcoX4q3pomfFnKGQ4JVxYTF4jNdxhHC0N62OVo8SZDRSdG+tBf+8MNgx1K
 VZ+p0clabrDcol/XbiiQzzG1Qdl00sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-zQpBWAbaN9WsqRejZERhig-1; Mon, 19 Oct 2020 16:17:52 -0400
X-MC-Unique: zQpBWAbaN9WsqRejZERhig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3181006708;
 Mon, 19 Oct 2020 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BEAC1A837;
 Mon, 19 Oct 2020 20:17:44 +0000 (UTC)
Date: Mon, 19 Oct 2020 16:17:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
Message-ID: <20201019201742.GA1617151@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-5-crosa@redhat.com>
 <4ba04f5d-eb4b-214d-3947-b84737748814@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4ba04f5d-eb4b-214d-3947-b84737748814@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 12:42:03PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/19/20 3:50 AM, Cleber Rosa wrote:
> > The QEMU project has two machines (aarch64 and s390) that can be used
>=20
> "s390x" =3D)
>

Sure!

Thanks!
- Cleber.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+N9GMACgkQZX6NM6Xy
CfMjyBAAtfKaojS8GBZcu+ZXUS7jZR5wrXZ3AeAPmLP7RD4ui7IdonRm5zuSmCVe
yFoSN/M+IGzF1Acwzc3V6Df5Arksa3GO6lQoTbfg1iNwGmPpP69qiFYqR0Ro/WzZ
GTUkS247rGuMWbXNaz/4U8zQFNxnZB+poXYmic8/pUlOZaJuFJAu2elCamNYKMDr
8LvUAgzsIMT1HUZKexmt48OuUyMy65jHOhwu65SbPIdUiARuW7Uv7x5CleZt7p8K
5+5IqDXMVhlzGYZvEFwx2kzL/KKgexiIFj86ncOXBtfp1Wa6/6/y4W8rJYqQC0rH
RKcrsU6A161qOSGTVoBTS5sTS2ySuD4agc7XuyTDWjguqgtaHCT8shknrJIYabng
zTOIdANhXqT6HQrMey/dOmkFLgWpldxuGC9gfkSCNAvn26rwBr+nKU3a7ryOKwZd
SYc2eha51bOD7ddA4DfgVuSEw+xY0EYGLs4jS4lqvsP9ym4rTH70gULJp3espCvZ
ewUswlVn/5aRcAKweh55jSeu3uHU2JweqFQI4CJUW+dqFcnxcItL8jJoWio+dzMx
ixOxcD+vnHXSIHVBrVIN4KC1b+y8BPBVSspx1FEdjHUtymCepZbVM2p7j1Rjczqh
TYlQP0hogV6qfap6JWxrzL83N8VgSQVNWOdVP0vVDpb1p/rrBWw=
=OZdD
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


