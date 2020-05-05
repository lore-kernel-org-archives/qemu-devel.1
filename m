Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD73DC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818C6206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mXITcgy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C6206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVpt5-0005gg-K5
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 01:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVpsJ-0004sZ-QL; Tue, 05 May 2020 01:12:11 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVpsI-00006h-R4; Tue, 05 May 2020 01:12:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49GSWr02MZz9sSx; Tue,  5 May 2020 15:12:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588655528;
 bh=bpcu/UaBP1874YDfTbIxYWP+lSYcLfSpI9NDgPFkrfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mXITcgy4FUHshwRAP6eIOjJ0nsoRhUsdHu3vXsqmahKic3VUtjoxKs+gymoOtwmUs
 7XWfT3vCQ1DZUzj4uefQ8VehByEnFSXVVaD5r7vASp55BJ4kUdl60WieqyLs/1nDoO
 mRwyFVHQ4fBqcym8CvgSySilCTL6TOGxsA/ud91Q=
Date: Tue, 5 May 2020 15:08:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9
Message-ID: <20200505050815.GC218517@umbus.fritz.box>
References: <20200501190913.25008-1-dbuono@linux.vnet.ibm.com>
 <20200501190913.25008-2-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20200501190913.25008-2-dbuono@linux.vnet.ibm.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, dbuono@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 03:09:13PM -0400, Daniele Buono wrote:
> Starting with Clang v9, -Wtype-limits is implemented and triggers a
> few "result of comparison is always true" errors when compiling PPC32
> targets.
>=20
> The comparisons seem to be necessary only on PPC64, since the
> else branch in PPC32 only has a "g_assert_not_reached();" in all cases.
>=20
> This patch restructures the code so that PPC32 does not execute the
> check, while PPC64 works like before
>=20
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>

Urgh.  #ifdefs intertangled with if statements gets pretty ugly.  But,
then, it's already pretty ugly, so, applied.

> ---
>  target/ppc/translate.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 807d14faaa..9400fa2c7c 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1882,6 +1882,7 @@ static void gen_rlwimi(DisasContext *ctx)
>          tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
>      } else {
>          target_ulong mask;
> +        TCGv_i32 t0;
>          TCGv t1;
> =20
>  #if defined(TARGET_PPC64)
> @@ -1891,20 +1892,20 @@ static void gen_rlwimi(DisasContext *ctx)
>          mask =3D MASK(mb, me);
> =20
>          t1 =3D tcg_temp_new();
> +#if defined(TARGET_PPC64)
>          if (mask <=3D 0xffffffffu) {
> -            TCGv_i32 t0 =3D tcg_temp_new_i32();
> +#endif
> +            t0 =3D tcg_temp_new_i32();
>              tcg_gen_trunc_tl_i32(t0, t_rs);
>              tcg_gen_rotli_i32(t0, t0, sh);
>              tcg_gen_extu_i32_tl(t1, t0);
>              tcg_temp_free_i32(t0);
> -        } else {
>  #if defined(TARGET_PPC64)
> +        } else {
>              tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
>              tcg_gen_rotli_i64(t1, t1, sh);
> -#else
> -            g_assert_not_reached();
> -#endif
>          }
> +#endif
> =20
>          tcg_gen_andi_tl(t1, t1, mask);
>          tcg_gen_andi_tl(t_ra, t_ra, ~mask);
> @@ -1938,7 +1939,9 @@ static void gen_rlwinm(DisasContext *ctx)
>          me +=3D 32;
>  #endif
>          mask =3D MASK(mb, me);
> +#if defined(TARGET_PPC64)
>          if (mask <=3D 0xffffffffu) {
> +#endif
>              if (sh =3D=3D 0) {
>                  tcg_gen_andi_tl(t_ra, t_rs, mask);
>              } else {
> @@ -1949,15 +1952,13 @@ static void gen_rlwinm(DisasContext *ctx)
>                  tcg_gen_extu_i32_tl(t_ra, t0);
>                  tcg_temp_free_i32(t0);
>              }
> -        } else {
>  #if defined(TARGET_PPC64)
> +        } else {
>              tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
>              tcg_gen_rotli_i64(t_ra, t_ra, sh);
>              tcg_gen_andi_i64(t_ra, t_ra, mask);
> -#else
> -            g_assert_not_reached();
> -#endif
>          }
> +#endif
>      }
>      if (unlikely(Rc(ctx->opcode) !=3D 0)) {
>          gen_set_Rc0(ctx, t_ra);
> @@ -1972,6 +1973,9 @@ static void gen_rlwnm(DisasContext *ctx)
>      TCGv t_rb =3D cpu_gpr[rB(ctx->opcode)];
>      uint32_t mb =3D MB(ctx->opcode);
>      uint32_t me =3D ME(ctx->opcode);
> +    TCGv_i32 t0;
> +    TCGv_i32 t1;
> +
>      target_ulong mask;
> =20
>  #if defined(TARGET_PPC64)
> @@ -1980,9 +1984,11 @@ static void gen_rlwnm(DisasContext *ctx)
>  #endif
>      mask =3D MASK(mb, me);
> =20
> +#if defined(TARGET_PPC64)
>      if (mask <=3D 0xffffffffu) {
> -        TCGv_i32 t0 =3D tcg_temp_new_i32();
> -        TCGv_i32 t1 =3D tcg_temp_new_i32();
> +#endif
> +        t0 =3D tcg_temp_new_i32();
> +        t1 =3D tcg_temp_new_i32();
>          tcg_gen_trunc_tl_i32(t0, t_rb);
>          tcg_gen_trunc_tl_i32(t1, t_rs);
>          tcg_gen_andi_i32(t0, t0, 0x1f);
> @@ -1990,17 +1996,15 @@ static void gen_rlwnm(DisasContext *ctx)
>          tcg_gen_extu_i32_tl(t_ra, t1);
>          tcg_temp_free_i32(t0);
>          tcg_temp_free_i32(t1);
> -    } else {
>  #if defined(TARGET_PPC64)
> +    } else {
>          TCGv_i64 t0 =3D tcg_temp_new_i64();
>          tcg_gen_andi_i64(t0, t_rb, 0x1f);
>          tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
>          tcg_gen_rotl_i64(t_ra, t_ra, t0);
>          tcg_temp_free_i64(t0);
> -#else
> -        g_assert_not_reached();
> -#endif
>      }
> +#endif
> =20
>      tcg_gen_andi_tl(t_ra, t_ra, mask);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6w9L8ACgkQbDjKyiDZ
s5I3GBAA23e87S796Ftqo/WG9QDDarmMvwHeqCWNHkM0ld7OLBMo9eF7cYb9A3FQ
a0hSf8LhCfXOAD3dJAdsSD/dKk38yK7glWwy8mHBQnZs8Cj8O2eMF8tTW/LdJaXg
g54fXkHiRfkSp3iD1tbAz8X22apikOyR0wHvTmWCaOUki4jp1RGig79svLJXINfC
cUgOruMm3OqFHTItrYpJTvT0mnOdhFa2yJqBmGdoM5YsrZITQSXlZ6MiAUzu5yz2
S02vOdpM4yVb+OkfgVDTeaLaCVBbr1X4q9jt8vbsfqvBVI0hD9+Vz2KyI4+Xa86q
kzwp+sXt3E0KK11EuRrlmndapijHlJf+wiL6XcrGRPnIHacvjfHuhB1Z5RwOjsXL
rhDoNW7pF0GYhT3Gu85mQeTNPacNi/XD5UVsFUZmPSWFPg9pXpRIRuX20sdid16E
/mUfzUJclLVVzmpGd/iHi7KJljp5HIjb7nPgcQ4OW/aF6KYwFig92BPWRjEd6BPK
vQLzv58uAuenWY5CQZ56PGO2C/mM/IfTTmIbpyKUPugeyM2Ti9aPVclT5Quh2xyf
M8ogXqbTgibVDECisxg41NvxPcBDG0DzC7AKyFdMIGkNP2x2hWNISV00lnfEWlc+
hePc8QV3FdExsdoGfD92khRyTBEx465pzJhuDHxagXGClRSVj18=
=SSMv
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

