Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC1C47247
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A717B206A5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o8gpuSal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A717B206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW9Gy-0000IR-P0
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 21:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jW9GK-00087E-Ou; Tue, 05 May 2020 21:54:16 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37659 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jW9GJ-0004nx-Ao; Tue, 05 May 2020 21:54:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49H04w5fc3z9sSt; Wed,  6 May 2020 11:54:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588730048;
 bh=2eUKPz5IP2fippP36oVghAp/DJOi5RVRyCG2hZ5Sblo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8gpuSal+gq3vZQLsBlVQ0zhjeDS83Mtsp/FRJ5nEihKZEEwVOJgb6J0aBCOTnhEc
 S9UrCHO5DZ3r3NI+s2I/69mFzyukIuR8GCuFr10fEwGEAKNkt9po7PGFBTR5/SMR8f
 Yyb/NjKk/ANVcWhyfxLKcd/Qn49MzbiT/T5/ADws=
Date: Wed, 6 May 2020 11:36:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/1] target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9
Message-ID: <20200506013643.GF218517@umbus.fritz.box>
References: <20200505183818.32688-1-dbuono@linux.vnet.ibm.com>
 <20200505183818.32688-2-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <20200505183818.32688-2-dbuono@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 02:38:17PM -0400, Daniele Buono wrote:
> Starting with Clang v9, -Wtype-limits is implemented and triggers a
> few "result of comparison is always true" errors when compiling PPC32
> targets.
>=20
> The comparisons seem to be necessary only on PPC64, since the
> else branch in PPC32 only has a "g_assert_not_reached();" in all cases.
>=20
> This patch restructures the code so that the actual if/else is done on a
> local flag variable, that is set accordingly for PPC64, and always
> true for PPC32.
>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>

That's a bit nicer, thanks.  Applied to ppc-for-5.1 in place of the
earlier version.

> ---
>  target/ppc/translate.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 807d14faaa..338529879f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1882,6 +1882,7 @@ static void gen_rlwimi(DisasContext *ctx)
>          tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
>      } else {
>          target_ulong mask;
> +        bool mask_in_32b =3D true;
>          TCGv t1;
> =20
>  #if defined(TARGET_PPC64)
> @@ -1890,8 +1891,13 @@ static void gen_rlwimi(DisasContext *ctx)
>  #endif
>          mask =3D MASK(mb, me);
> =20
> +#if defined(TARGET_PPC64)
> +        if (mask > 0xffffffffu) {
> +            mask_in_32b =3D false;
> +        }
> +#endif
>          t1 =3D tcg_temp_new();
> -        if (mask <=3D 0xffffffffu) {
> +        if (mask_in_32b) {
>              TCGv_i32 t0 =3D tcg_temp_new_i32();
>              tcg_gen_trunc_tl_i32(t0, t_rs);
>              tcg_gen_rotli_i32(t0, t0, sh);
> @@ -1933,12 +1939,18 @@ static void gen_rlwinm(DisasContext *ctx)
>          tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
>      } else {
>          target_ulong mask;
> +        bool mask_in_32b =3D true;
>  #if defined(TARGET_PPC64)
>          mb +=3D 32;
>          me +=3D 32;
>  #endif
>          mask =3D MASK(mb, me);
> -        if (mask <=3D 0xffffffffu) {
> +#if defined(TARGET_PPC64)
> +        if (mask > 0xffffffffu) {
> +            mask_in_32b =3D false;
> +        }
> +#endif
> +        if (mask_in_32b) {
>              if (sh =3D=3D 0) {
>                  tcg_gen_andi_tl(t_ra, t_rs, mask);
>              } else {
> @@ -1973,6 +1985,7 @@ static void gen_rlwnm(DisasContext *ctx)
>      uint32_t mb =3D MB(ctx->opcode);
>      uint32_t me =3D ME(ctx->opcode);
>      target_ulong mask;
> +    bool mask_in_32b =3D true;
> =20
>  #if defined(TARGET_PPC64)
>      mb +=3D 32;
> @@ -1980,7 +1993,12 @@ static void gen_rlwnm(DisasContext *ctx)
>  #endif
>      mask =3D MASK(mb, me);
> =20
> -    if (mask <=3D 0xffffffffu) {
> +#if defined(TARGET_PPC64)
> +    if (mask > 0xffffffffu) {
> +        mask_in_32b =3D false;
> +    }
> +#endif
> +    if (mask_in_32b) {
>          TCGv_i32 t0 =3D tcg_temp_new_i32();
>          TCGv_i32 t1 =3D tcg_temp_new_i32();
>          tcg_gen_trunc_tl_i32(t0, t_rb);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6yFKkACgkQbDjKyiDZ
s5K1wQ//fh0KkTctegx6M75cWKf+gnI95/tcehIoNxxtdfXqYWl+4Ihc10qP75Lg
kvji7V6OzM3CGm6WWJ2LzxjnEF8AhfdDpVQJQOzeFvBpdJW7dDWxvTDmPitr6R2K
a0vV4ngPfE5amCdXNUjyT/y0XkIiBDMpeuQRDIGFNH65c9R7tYZZnxj0+yleyczm
0gmACx7u1E4MTASPt1y+6udnx0i9L6DOmzDAO2x79f2EupOYA7f4dWL4BDpK36LT
PtqMNrY1FI+cVK6QFxjXS0wSJrfQbgSVz31P2lUZ8kXKORa0SR8JlFyqWaHKH6ap
i0fQx409iwBrspptQaY8OlrCVDRUa6vo/9Uxn+EMjxH3ft5eeJEzfA57Yl0Y+CuA
19afOOlXrUUreOErfjOsouYb50XCHxGn+YNNxoWcJXdshad+2IqbdUIgsbdy+F7M
+Mta7rU8E3RBNC0s9IVdM06fqqZgyhGWXww7L3Z+wB/qF/eCAUAqdt7Akeaj80cN
PXZJ61koA113flnW+hh+wTwBGmeEl02u322rogzjES2I4A/LKkwYZj0a+cZ1wkd6
iMHSk+TmyGAbRbZkkSthelvOIoEOVbYZJ6xv+G8LkK/Km0B1EWhIN8KNse1X3tkf
DiRrryGCaKL98b5UtagiKIOVfryjY76BC4cVl/tv2Zb5owIbPCk=
=dra/
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

