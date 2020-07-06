Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A834C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CBB2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DogxOmM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CBB2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLxm-0002Xk-MN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsLxC-000288-5R; Mon, 06 Jul 2020 03:54:18 -0400
Received: from ozlabs.org ([203.11.71.1]:59531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsLx8-0000bf-Cl; Mon, 06 Jul 2020 03:54:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B0dB51dBJz9sSn; Mon,  6 Jul 2020 17:54:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594022045;
 bh=o0E0m4KhoJx8xJ6OOB8Azw4UzXHnZoSTfL0h8sn0atM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DogxOmM801y5fE+3/le9aUI4TSmetmp5CR68m1jJrke19CvLWF50ncuZwilCpe3fp
 lMgFZ2yjaFcw7hRiOwlyr+Ou4uR+DBEgdX5znmKB2qvHvrePFmE5v7CsCBK4qqvHnN
 0vIu+6AkFLRnoJDc3EM+Fyidmm4V6bXUPLuPqvkc=
Date: Mon, 6 Jul 2020 17:53:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v3] target/ppc: add vmsumudm vmsumcud instructions
Message-ID: <20200706075320.GA5996@umbus.fritz.box>
References: <20200623042501.47065-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20200623042501.47065-1-ljp@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 03:54:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 11:25:01PM -0500, Lijun Pan wrote:
> vmsumudm (Power ISA 3.0) - Vector Multiply-Sum Unsigned Doubleword Modulo
> VA-form.
> vmsumcud (Power ISA 3.1) - Vector Multiply-Sum & write Carry-out Unsigned
> Doubleword VA-form.

If this is only in ISA 3.1, shouldn't it be conditional on some
instruction flag for that?

SHould this maybe be integrated into your other series of ISA 3.1
instructions.

>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v3: implement vmsumudm/vmsumcud through int128 functions,
>     suggested by Richard Henderson.
>=20
>  disas/ppc.c                         |  2 ++
>  target/ppc/helper.h                 |  4 ++-
>  target/ppc/int_helper.c             | 49 ++++++++++++++++++++++++++++-
>  target/ppc/translate.c              |  1 -
>  target/ppc/translate/vmx-impl.inc.c | 39 ++++++++++++-----------
>  target/ppc/translate/vmx-ops.inc.c  |  2 ++
>  6 files changed, 76 insertions(+), 21 deletions(-)
>=20
> diff --git a/disas/ppc.c b/disas/ppc.c
> index 63e97cfe1d..bd76fae4c4 100644
> --- a/disas/ppc.c
> +++ b/disas/ppc.c
> @@ -2261,7 +2261,9 @@ const struct powerpc_opcode powerpc_opcodes[] =3D {
>  { "vmsumshs",  VXA(4,  41), VXA_MASK,	PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumubm",  VXA(4,  36), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
>  { "vmsumuhm",  VXA(4,  38), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumudm",  VXA(4,  35), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC=
 } },
>  { "vmsumuhs",  VXA(4,  39), VXA_MASK,   PPCVEC,		{ VD, VA, VB, VC } },
> +{ "vmsumcud",  VXA(4,  23), VXA_MASK,   PPCVEC,         { VD, VA, VB, VC=
 } },
>  { "vmulesb",   VX(4,  776), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmulesh",   VX(4,  840), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
>  { "vmuleub",   VX(4,  520), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 2dfa1c6942..d540e8f30b 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -263,10 +263,12 @@ DEF_HELPER_3(vpkpx, void, avr, avr, avr)
>  DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
> +DEF_HELPER_5(vmsumudm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
> -DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
> +DEF_HELPER_5(vmsumcud, void, env, avr, avr, avr, avr)
> +DEF_HELPER_5(vmladduhm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
>  DEF_HELPER_3(lvebx, void, env, avr, tl)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index be53cd6f68..37ea343cb3 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -926,7 +926,8 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
>      }
>  }
> =20
> -void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_=
t *c)
> +void helper_vmladduhm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
> +                      ppc_avr_t *b, ppc_avr_t *c)
>  {
>      int i;
> =20
> @@ -1064,6 +1065,52 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *a,
>      }
>  }
> =20
> +void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
> +{
> +    Int128 sum;
> +    uint64_t lo, hi;
> +
> +    sum =3D int128_make128(c->VsrD(1), c->VsrD(0));
> +
> +    mulu64(&lo, &hi, a->VsrD(0), b->VsrD(0));
> +    sum =3D int128_add(sum, int128_make128(lo, hi));
> +
> +    mulu64(&lo, &hi, a->VsrD(1), b->VsrD(1));
> +    sum =3D int128_add(sum, int128_make128(lo, hi));
> +
> +    r->VsrD(0) =3D int128_gethi(sum);
> +    r->VsrD(1) =3D int128_getlo(sum);
> +}
> +
> +void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
> +                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
> +{
> +    Int128 sum;
> +    uint64_t p1lo, p1hi, p2lo, p2hi;
> +
> +    mulu64(&p1lo, &p1hi, a->VsrD(0), b->VsrD(0));
> +    mulu64(&p2lo, &p2hi, a->VsrD(1), b->VsrD(1));
> +
> +    /* Sum lowest 64-bit elements.  */
> +    sum =3D int128_make128(c->VsrD(1), 0);
> +    sum =3D int128_add(sum, int128_make128(p1lo, 0));
> +    sum =3D int128_add(sum, int128_make128(p2lo, 0));
> +
> +    /*
> +     * Discard low 64-bits, leaving the carry into bit 64.
> +     * Then sum the higher 64-bit elements.
> +     */
> +    sum =3D int128_rshift(sum, 64);
> +    sum =3D int128_add(sum, int128_make128(c->VsrD(0), 0));
> +    sum =3D int128_add(sum, int128_make128(p1hi, 0));
> +    sum =3D int128_add(sum, int128_make128(p2hi, 0));
> +
> +    /* The result is only the carry into bits 64 & 65. */
> +    r->VsrD(1) =3D int128_gethi(sum);
> +    r->VsrD(0) =3D 0;
> +}
> +
>  #define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>      {                                                                   \
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4ce3d664b5..35ff1aa77e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7281,7 +7281,6 @@ GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC=
_ALTIVEC),
>  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
>  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
>  GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
> -GEN_HANDLER(vmladduhm, 0x04, 0x11, 0xFF, 0x00000000, PPC_ALTIVEC),
>  #if defined(TARGET_PPC64)
>  GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
>                PPC2_ISA300),
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 403ed3a01c..520b49a773 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -1248,6 +1248,25 @@ static void gen_vsldoi(DisasContext *ctx)
>      tcg_temp_free_i32(sh);
>  }
> =20
> +#define GEN_VAFORM(name, opc2)                                          \
> +static void glue(gen_, name)(DisasContext *ctx)                         \
> +{                                                                       \
> +    TCGv_ptr ra, rb, rc, rd;                                            \
> +    if (unlikely(!ctx->altivec_enabled)) {                              \
> +        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
> +        return;                                                         \
> +    }                                                                   \
> +    ra =3D gen_avr_ptr(rA(ctx->opcode));                                =
  \
> +    rb =3D gen_avr_ptr(rB(ctx->opcode));                                =
  \
> +    rc =3D gen_avr_ptr(rC(ctx->opcode));                                =
  \
> +    rd =3D gen_avr_ptr(rD(ctx->opcode));                                =
  \
> +    gen_helper_##name(cpu_env, rd, ra, rb, rc);                         \
> +    tcg_temp_free_ptr(ra);                                              \
> +    tcg_temp_free_ptr(rb);                                              \
> +    tcg_temp_free_ptr(rc);                                              \
> +    tcg_temp_free_ptr(rd);                                              \
> +}
> +
>  #define GEN_VAFORM_PAIRED(name0, name1, opc2)                           \
>  static void glue(gen_, name0##_##name1)(DisasContext *ctx)              \
>      {                                                                   \
> @@ -1272,24 +1291,8 @@ static void glue(gen_, name0##_##name1)(DisasConte=
xt *ctx)              \
>      }
> =20
>  GEN_VAFORM_PAIRED(vmhaddshs, vmhraddshs, 16)
> -
> -static void gen_vmladduhm(DisasContext *ctx)
> -{
> -    TCGv_ptr ra, rb, rc, rd;
> -    if (unlikely(!ctx->altivec_enabled)) {
> -        gen_exception(ctx, POWERPC_EXCP_VPU);
> -        return;
> -    }
> -    ra =3D gen_avr_ptr(rA(ctx->opcode));
> -    rb =3D gen_avr_ptr(rB(ctx->opcode));
> -    rc =3D gen_avr_ptr(rC(ctx->opcode));
> -    rd =3D gen_avr_ptr(rD(ctx->opcode));
> -    gen_helper_vmladduhm(rd, ra, rb, rc);
> -    tcg_temp_free_ptr(ra);
> -    tcg_temp_free_ptr(rb);
> -    tcg_temp_free_ptr(rc);
> -    tcg_temp_free_ptr(rd);
> -}
> +GEN_VAFORM(vmsumcud, 11)
> +GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17)
> =20
>  static void gen_vpermr(DisasContext *ctx)
>  {
> diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vm=
x-ops.inc.c
> index 84e05fb827..aee23e31c6 100644
> --- a/target/ppc/translate/vmx-ops.inc.c
> +++ b/target/ppc/translate/vmx-ops.inc.c
> @@ -276,6 +276,8 @@ GEN_VAFORM_PAIRED(vmsumuhm, vmsumuhs, 19),
>  GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20),
>  GEN_VAFORM_PAIRED(vsel, vperm, 21),
>  GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23),
> +GEN_HANDLER(vmsumcud, 0x4, 11, 0xFF, 0x00000000, PPC_ALTIVEC),
> +GEN_VAFORM_PAIRED(vmladduhm, vmsumudm, 17),
> =20
>  GEN_VXFORM_DUAL(vclzb, vpopcntb, 1, 28, PPC_NONE, PPC2_ALTIVEC_207),
>  GEN_VXFORM_DUAL(vclzh, vpopcnth, 1, 29, PPC_NONE, PPC2_ALTIVEC_207),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8C2G0ACgkQbDjKyiDZ
s5KJAg//RqchsaL3KvZV8akLG1G5YaDeNCNBHpMSVlv5t71gfhoj+/MPR5Tabcco
YCLp+S5Ulk+ESjZk5VvgZJ1zf0q4h93VcOovVwU7LXwM8+tpVGLZVCa36hrgorei
nh7YHacMCfVH8uGiCixjkrhElvFPi1Oiv7wFyHRijlXc87lmra0+itmEQ1A3DvLV
EhjGZRS8usUq9XVyXO4+bDhJTVhVyBfeKRnvVdw27UXtijt+zEOT4iS5Ud9tSIqr
KqIj9NYOrjrHF56wcgtB9nObbih/7EAv/x+IACkYkRpYEP/xI9Pz0m37qNdXtLwe
2/IJG0Ou2Gjnq1DWe9tSTjCVAUBa0NRC5znbQalMsjvZeyOFcFGOAwQZXeqgIqFA
V/RhK1VyBJJhGvIZs7wLJxhtF5biu8C0JXdNSIBGqwFz2ckzqKP3d6t4AiPnDnfR
Auul/AV39oBusXJrQzjKy0k0OLx1CMLuu4LTmC1yEMkYR20VKQZD5DGqvpTap9x+
TaiaLH3vZce3wBuZVBNFsEherGJ19ZgWcd8+QeHsSTIY44AVwApgQm3n98tb0REV
kzzaL9rv+QKl3JPvXeEVjc8JJB5jKg1ff/NK/IBA7jRUaEmJD7Pou3HPgxVKe6Qg
dCQ+Sj04hVICCZQKASXuEhQj2iD4bDOgPjTSEVBWAVzSb/ANZHU=
=e9Tt
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

