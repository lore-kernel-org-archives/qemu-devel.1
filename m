Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC31C4332D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 08:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9D2206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BI1ljb8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9D2206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFwJy-0001e3-UZ
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 04:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jFwJA-0000uc-Ii
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 04:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jFwJ9-0006ak-37
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 04:50:12 -0400
Received: from ozlabs.org ([203.11.71.1]:35043)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jFwJ6-0006XB-6R; Sun, 22 Mar 2020 04:50:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48lWRb3TMdz9sPR; Sun, 22 Mar 2020 19:50:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584867003;
 bh=2y/HzrokipazfD/bHXe9liTQjcDQwirCaigMtKSAj+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BI1ljb8ZvYWhiC5blzOgyz/YbZMG+PJSYIk/VKBgvV0Gl/3SVtxGxgSA8rJV7go3o
 X1u9Y8R6nH0VFsVqFFVKditAopMwnjzKICcfkq83pAZggjZF5kDYSSiVzh6hZJXtFs
 0pZ0HJ2iBp9bUZUVKQV8Hdqyur9/jvB4Uknp20LA=
Date: Sun, 22 Mar 2020 19:46:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ppc/ppc405_boards: Remove unnecessary NULL check
Message-ID: <20200322084608.GI781112@umbus.fritz.box>
References: <20200320155740.5342-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20200320155740.5342-1-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 04:57:40PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This code is inside the "if (dinfo)" condition, so testing
> again here whether it is NULL is unnecessary.
>=20
> Fixes: dd59bcae7 (Don't size flash memory to match backing image)
> Reported-by: Coverity (CID 1421917)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Applied to ppc-for-5.1.

> ---
>  hw/ppc/ppc405_boards.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index e6bffb9e1a..6198ec1035 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -191,7 +191,7 @@ static void ref405ep_init(MachineState *machine)
>          bios_size =3D 8 * MiB;
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                "ef405ep.bios", bios_size,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> @@ -459,7 +459,7 @@ static void taihu_405ep_init(MachineState *machine)
>          bios_size =3D 2 * MiB;
>          pflash_cfi02_register(0xFFE00000,
>                                "taihu_405ep.bios", bios_size,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> @@ -494,7 +494,7 @@ static void taihu_405ep_init(MachineState *machine)
>      if (dinfo) {
>          bios_size =3D 32 * MiB;
>          pflash_cfi02_register(0xfc000000, "taihu_405ep.flash", bios_size,
> -                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              blk_by_legacy_dinfo(dinfo),
>                                64 * KiB, 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl53Jc0ACgkQbDjKyiDZ
s5I47g/+OBaZMNt8//hA9xNBehjOda4KnnfY62FA7zCxOy12LJiyAQ4EEeEFSwgX
fEKACCibetla400+VYQnmOFe2xIQPX46LfezTalJ4TY2PAIpFU/XMbfhrcj3P5Dh
IYYOAOCprXvLSL8K+AsNTaLWR+uBordi/+vgIUBlZ9pHIS7um+5ogg+utSApqdDJ
y3CjsGGC4gYc5bPgJVevdvM7gQQNWV/OkRKOXfIj6Lpi4BqJgvnBDV92BxaC/GIM
2PEG+ePAuAasebkUzSCEyR/3nbwnslTP2foYKVvNwzd+QKHMxZPIPsPigCmyLKpU
0wWcVjfTZZzNTjwFhMrmIRsNVN557AC8C/EGeaJrtRK2pJgh7FpqG/wIPUASCPGY
nmCECddxnvKZqsPalW32/ESWiorofmttH9k0Ar2JdZ6meRReM4IW7/F/yqz34IQN
+9vaVphVsK61GZcrRikEbE+O0dTp7GCMC8i4AGa6FXVxhGxE1C7JSGqAEMKKMkzV
qmo+j0WIqIAq12Wdapra18YdgdLFcoYYJZHKVHA/ay/NSzPu++mmID7Ucb54uKHo
5ixHXZpncRPMgu5oyTrU3YinF2Jyi9X7OflZOcrJEGRl1mV21N89SomPaLrdwObU
98U7a86Wmju/SXg3eom08+MErh+1u3Ai6aZd19vPSesTGkndYsc=
=6j5G
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--

