Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF8C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A7823A65
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ2/rcgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A7823A65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKVSJ-0002g5-5a
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKVQZ-0001nW-Vz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKVQX-0003Op-M6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600731656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/1CE6Jp7dmfXWiJXTyRS8oaIsifLmDiUhEHldIj9DI=;
 b=WQ2/rcgAKisEwa1Rtj0YYAYjp9NzTUjzH3qVrNsGdHtxfrYRMw6zEdup+XYeJsTcNDomct
 bM5+HBCvHyuQAqt8tw8RqunKt8vNTz+hKnposA+MgDC7GvEBj4pgRoJP3fE5I6txeAp1Mh
 qFmOIVA3khZy7l1E+7QnpiLrjQ6ICu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-bZmzQx3HMy6Gm1hVGkotzw-1; Mon, 21 Sep 2020 19:40:52 -0400
X-MC-Unique: bZmzQx3HMy6Gm1hVGkotzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 398E1909CA2;
 Mon, 21 Sep 2020 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77A1E78808;
 Mon, 21 Sep 2020 23:40:50 +0000 (UTC)
Date: Mon, 21 Sep 2020 19:40:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/6] travis.yml: Drop the superfluous Python 3.6 build
Message-ID: <20200921234048.GD15763@localhost.localdomain>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-7-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918103430.297167-7-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 12:34:30PM +0200, Thomas Huth wrote:
> Python 3.6 is already the default Python in the jobs that are based
> on Ubuntu Bionic, so it does not make much sense to test this again
> separately.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 8 --------
>  1 file changed, 8 deletions(-)
>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9pOgAACgkQZX6NM6Xy
CfN2Pg/+JU3CyCKGWlOvJrB4KDvYf1BZYfnycKqA/WQIr9lkepWGqM50hmDe5S9a
CwVqtRFhfPLGI78Z0jMXOfE5VHFFbSX0SlH6CvzmVbMYYBmlT7i61poYzwQAOOwl
CdKKjdq1nkt+bXfhQzu2khMsr3BqBoTw/SH+WRliQi2Lwg7s64Lrtq3X2i8hJUNW
CTJDAHLBVCgh4gCO1is7QzGHariuRkOqJONTJf+fxFJ02sb1FfVDUZtZx3WgH5kN
qd8jbPx1sbY9W6gAzPF7c3h0BG/v6ETvAv41QLjjsWFetEPbm+PqPBAJ3Ghwc2Y8
+fV1VcbM1VMHquMClaJrbblJG3G31nmbc/7Hf2xxrfPnDKqWIg8EGbufKK86+Sqi
xCRsfaHPrrolEnhC4CiUuCaxPfb+XejSwjnoMrjC2kdQXNz+uU/ifWaEyd5E6kpT
GCVYKiJ47ffcmCqT0nz3I23hvrKrFmGG9GZGlURlq0e44Uev2xHgg5L61TvWCely
XXUHBpi2qzckDviQIUac6gFjaQ1fQX4K/xj0FFH2Lri9OnJVLaNH5VSItJ9gpq8K
kt8XCJ36F2mCJq4FIizvV/Ya3OlbyHpCxyQsdCTygfPUUInyHVo+kYAIFc3jZh9t
pq4kAL2zuJRgpx3qScrSbbbsCZQ1Wu1XCHz8TIyEZw/K6ZlnEG4=
=6xYV
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--


