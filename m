Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB142C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A770F2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PmuDRkim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A770F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juqq0-0001Ps-SX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 01:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqo0-0007uP-DQ; Mon, 13 Jul 2020 01:15:08 -0400
Received: from ozlabs.org ([203.11.71.1]:38161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqnw-0008R5-Bf; Mon, 13 Jul 2020 01:15:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B4sK85LKlz9sRk; Mon, 13 Jul 2020 15:14:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594617292;
 bh=3wG00xI84Xxi2+NCSOSzDgDU9eKCgITapq9C36/vh2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PmuDRkimQVyRYHZiZYbO0Uk9AyBpL24PT85aCgU/QD7dmi/eYdPqrBEhS3HF0gE1B
 v/qY7uvqPAWLD08tI+wImOGwzzBiHuMvZXgfTPlJ4IwJm6TeiWd7nD2rUnoTv61Ojg
 Dz3iuHpqXXaklc6bv42t2OuaTAEBzx0yrtX4rgIw=
Date: Mon, 13 Jul 2020 15:11:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 05/11] target/ppc: add vmulld instruction
Message-ID: <20200713051148.GL2666@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-6-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-6-ljp@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:40PM -0500, Lijun Pan wrote:
> vmulld: Vector Multiply Low Doubleword.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
> v4: add missing changes, and split to 5/11, 6/11, 7/11
> v3: use tcg_gen_gvec_mul()
> v2: fix coding style
>     use Power ISA 3.1 flag
>=20
>  target/ppc/translate/vmx-impl.inc.c | 1 +
>  target/ppc/translate/vmx-ops.inc.c  | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 6e79ffa650..8c89738552 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -807,6 +807,7 @@ GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
>  GEN_VXFORM(vmulosb, 4, 4);
>  GEN_VXFORM(vmulosh, 4, 5);
>  GEN_VXFORM(vmulosw, 4, 6);
> +GEN_VXFORM_V(vmulld, MO_64, tcg_gen_gvec_mul, 4, 7);
>  GEN_VXFORM(vmuleub, 4, 8);
>  GEN_VXFORM(vmuleuh, 4, 9);
>  GEN_VXFORM(vmuleuw, 4, 10);
> diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vm=
x-ops.inc.c
> index 84e05fb827..b49787ac97 100644
> --- a/target/ppc/translate/vmx-ops.inc.c
> +++ b/target/ppc/translate/vmx-ops.inc.c
> @@ -48,6 +48,9 @@ GEN_HANDLER_E(name, 0x04, opc2, opc3, inval, PPC_NONE, =
PPC2_ISA300)
>  GEN_HANDLER_E_2(name, 0x04, opc2, opc3, opc4, 0x00000000, PPC_NONE,     \
>                                                         PPC2_ISA300)
> =20
> +#define GEN_VXFORM_310(name, opc2, opc3)                                \
> +GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA310)
> +
>  #define GEN_VXFORM_DUAL(name0, name1, opc2, opc3, type0, type1) \
>  GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
> =20
> @@ -104,6 +107,7 @@ GEN_VXFORM_DUAL(vmulouw, vmuluwm, 4, 2, PPC_ALTIVEC, =
PPC_NONE),
>  GEN_VXFORM(vmulosb, 4, 4),
>  GEN_VXFORM(vmulosh, 4, 5),
>  GEN_VXFORM_207(vmulosw, 4, 6),
> +GEN_VXFORM_310(vmulld, 4, 7),
>  GEN_VXFORM(vmuleub, 4, 8),
>  GEN_VXFORM(vmuleuh, 4, 9),
>  GEN_VXFORM_207(vmuleuw, 4, 10),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8L7REACgkQbDjKyiDZ
s5IJWxAAkIw3Nz503N91QSgCe7X3GppYdwy+zvbQKnx0Yf1RBOZk+qhachQL8WhD
TZWEWbYOP19ph6KVdyPFkHbpTVyAJdAZuL4lDC4ougilolkSBrTO263E/ysTeh/G
VP+zGsR5mcd/MjHkOj027Cem72euD3XhNesD8p2wWaawfECIX0V/SSCT4PzwLaRY
rKOl7Whw3z189VdaarurLSGex5IzVAo0YIBxYA1ITziAvUTMPgDBUCxQB843rY4U
tJz/zLC1+65s5s7/BnDatEN+iid71xJFahh393d1RkSOE/+FDN6fRqhqZ7bnNkQ6
ql0AnyqhB4WB/jurFlGS5pU9C6j/4NxbkQpfZv3vmKFNaPFojwXATugGfCE62LaO
4jwnjJ0LUO4OJ+QRFeTBSqp4KX9Q1IR0im0VVPSl89KX7H0XdHlT6Cbn8SR8Okih
DKsZZY2YU/4HYrY17Z2jpXpD76Ijaox64PBclP36J4juLjG8tCwcm83+Kk43iBPc
OgvOBeFQuJBMk+ZUjLTnwZ5cVGCYqHyGndXrvbzXaxKPmJ6WRAqE/bPXavC3pZRh
hZtDoz9hz+uvFNua0KgUEk9iHLXnQA7zW8zU89xk0Wxkqy8Jx54wCda3cJoMBCKk
l2xWXxGJ3iQZnx1sNq++mfyw/ick3kXhxEfRZ5TZjlxeqhJ6LUk=
=XZuw
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--

