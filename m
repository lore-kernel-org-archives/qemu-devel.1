Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EEFC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F5821924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eKV7g9FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F5821924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqIp-0001th-0N
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGy-0000SW-Tk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGw-0000ly-Sn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iAqGv-0000id-WB; Thu, 19 Sep 2019 02:50:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YnXz2s6Tz9sN1; Thu, 19 Sep 2019 16:50:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568875827;
 bh=GJsiqyoqUtbGSB3n50A0E121onT4qQT7wmlXKyrx/a0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eKV7g9FJ2533yt/9JY2bJYUIbL7RAkf6Qm+szznYovXrCGMiP+L914E0n03jd1nIg
 PEtvok4uifCpAI/TW6l/irUZFq/QjRfArKUdxHKjOZFhERI3ErItlro6rUoKJeNwsl
 H7Enn/FTeEpRzKVfHurV2YckRczrgORrL70ldVAc=
Date: Thu, 19 Sep 2019 16:29:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190919062904.GC22790@umbus.fritz.box>
References: <1568817081-1345-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <1568817081-1345-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 1/2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:31:21AM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffscrn' and 'mffscrni' instructions.
>=20
> 'mffscrn' and 'mffscrni' are similar to 'mffsl', except they do not return
> the status bits (FI, FR, FPRF) and they also set the rounding mode in the
> FPSCR.
>=20
> On CPUs without support for 'mffscrn'/'mffscrni' (below ISA 3.0), the
> instructions will execute identically to 'mffs'.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
> v3:
> - Fix v2 change which cleared inadvertently clearned DRN.
> - Remove FP_MODE, use FP_DRN and FP_RN explicitly instead.
> - I did not remove the FPSCR_DRN[012] or FP_DRN[012] defines, as it's
>   clearer to me that it's a 3-bit field, but am happy to respin if that
>   is preferred.
> v2:
> - Add DRN to returned FPSCR value.
> - Add DRN defines to target/ppc/cpu.h.
>=20
>  target/ppc/cpu.h                   |  9 ++++-
>  target/ppc/dfp_helper.c            |  2 +-
>  target/ppc/internal.h              |  3 ++
>  target/ppc/translate/fp-impl.inc.c | 69 ++++++++++++++++++++++++++++++++=
+++++-
>  target/ppc/translate/fp-ops.inc.c  |  4 +++
>  5 files changed, 84 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index eaee1a5..a23c645 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -559,6 +559,9 @@ enum {
> =20
>  /***********************************************************************=
******/
>  /* Floating point status and control register                           =
     */
> +#define FPSCR_DRN2   34 /* Decimal Floating-Point rounding control      =
     */
> +#define FPSCR_DRN1   33 /* Decimal Floating-Point rounding control      =
     */
> +#define FPSCR_DRN0   32 /* Decimal Floating-Point rounding control      =
     */
>  #define FPSCR_FX     31 /* Floating-point exception summary             =
     */
>  #define FPSCR_FEX    30 /* Floating-point enabled exception summary     =
     */
>  #define FPSCR_VX     29 /* Floating-point invalid operation exception su=
mm.  */
> @@ -592,6 +595,7 @@ enum {
>  #define FPSCR_NI     2  /* Floating-point non-IEEE mode                 =
     */
>  #define FPSCR_RN1    1
>  #define FPSCR_RN0    0  /* Floating-point rounding control              =
     */
> +#define fpscr_drn    (((env->fpscr) & FP_DRN) >> FPSCR_DRN0)
>  #define fpscr_fex    (((env->fpscr) >> FPSCR_FEX)    & 0x1)
>  #define fpscr_vx     (((env->fpscr) >> FPSCR_VX)     & 0x1)
>  #define fpscr_ox     (((env->fpscr) >> FPSCR_OX)     & 0x1)
> @@ -627,6 +631,10 @@ enum {
>  #define fpscr_eex (((env->fpscr) >> FPSCR_XX) & ((env->fpscr) >> FPSCR_X=
E) &  \
>                     0x1F)
> =20
> +#define FP_DRN2         (1ull << FPSCR_DRN2)
> +#define FP_DRN1         (1ull << FPSCR_DRN1)
> +#define FP_DRN0         (1ull << FPSCR_DRN0)
> +#define FP_DRN          (FP_DRN2 | FP_DRN1 | FP_DRN0)
>  #define FP_FX           (1ull << FPSCR_FX)
>  #define FP_FEX          (1ull << FPSCR_FEX)
>  #define FP_VX           (1ull << FPSCR_VX)
> @@ -662,7 +670,6 @@ enum {
>  #define FP_RN0          (1ull << FPSCR_RN0)
>  #define FP_RN           (FP_RN1 | FP_RN0)
> =20
> -#define FP_MODE         FP_RN
>  #define FP_ENABLES      (FP_VE | FP_OE | FP_UE | FP_ZE | FP_XE)
>  #define FP_STATUS       (FP_FR | FP_FI | FP_FPRF)
> =20
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index f102177..da8e08a 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -48,7 +48,7 @@ static void dfp_prepare_rounding_mode(decContext *conte=
xt, uint64_t fpscr)
>  {
>      enum rounding rnd;
> =20
> -    switch ((fpscr >> 32) & 0x7) {
> +    switch ((fpscr & FP_DRN) >> FPSCR_DRN0) {
>      case 0:
>          rnd =3D DEC_ROUND_HALF_EVEN;
>          break;
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index d3d327e..15d655b 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -157,6 +157,9 @@ EXTRACT_HELPER(FPL, 25, 1);
>  EXTRACT_HELPER(FPFLM, 17, 8);
>  EXTRACT_HELPER(FPW, 16, 1);
> =20
> +/* mffscrni */
> +EXTRACT_HELPER(RM, 11, 2);
> +
>  /* addpcis */
>  EXTRACT_HELPER_SPLIT_3(DX, 10, 6, 6, 5, 16, 1, 1, 0, 0)
>  #if defined(TARGET_PPC64)
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 7cd9d8d..75f9523 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -634,11 +634,78 @@ static void gen_mffsl(DisasContext *ctx)
>      gen_reset_fpstatus();
>      tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>      /* Mask everything except mode, status, and enables.  */
> -    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_STATUS | FP_ENABLES);
> +    tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
>      set_fpr(rD(ctx->opcode), t0);
>      tcg_temp_free_i64(t0);
>  }
> =20
> +static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i32 mask =3D tcg_const_i32(0x0001);
> +
> +    gen_reset_fpstatus();
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
> +    set_fpr(rD(ctx->opcode), t0);
> +
> +    /* Mask FPSCR value to clear RN.  */
> +    tcg_gen_andi_i64(t0, t0, ~FP_RN);
> +
> +    /* Merge RN into FPSCR value.  */
> +    tcg_gen_or_i64(t0, t0, t1);
> +
> +    gen_helper_store_fpscr(cpu_env, t0, mask);
> +
> +    tcg_temp_free_i32(mask);
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* mffscrn */
> +static void gen_mffscrn(DisasContext *ctx)
> +{
> +    TCGv_i64 t1;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +
> +    t1 =3D tcg_temp_new_i64();
> +    get_fpr(t1, rB(ctx->opcode));
> +    /* Mask FRB to get just RN.  */
> +    tcg_gen_andi_i64(t1, t1, FP_RN);
> +
> +    gen_helper_mffscrn(ctx, t1);
> +
> +    tcg_temp_free_i64(t1);
> +}
> +
> +/* mffscrni */
> +static void gen_mffscrni(DisasContext *ctx)
> +{
> +    TCGv_i64 t1;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +
> +    t1 =3D tcg_const_i64((uint64_t)RM(ctx->opcode));
> +
> +    gen_helper_mffscrn(ctx, t1);
> +
> +    tcg_temp_free_i64(t1);
> +}
> +
>  /* mtfsb0 */
>  static void gen_mtfsb0(DisasContext *ctx)
>  {
> diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-=
ops.inc.c
> index 88ebc25..f2bcf0e 100644
> --- a/target/ppc/translate/fp-ops.inc.c
> +++ b/target/ppc/translate/fp-ops.inc.c
> @@ -107,6 +107,10 @@ GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC=
_FLOAT),
>  GEN_HANDLER_E_2(mffs, 0x3F, 0x07, 0x12, 0x00, 0x00000000, PPC_FLOAT, PPC=
_NONE),
>  GEN_HANDLER_E_2(mffsl, 0x3F, 0x07, 0x12, 0x18, 0x00000000, PPC_FLOAT,
>      PPC2_ISA300),
> +GEN_HANDLER_E_2(mffscrn, 0x3F, 0x07, 0x12, 0x16, 0x00000000, PPC_FLOAT,
> +    PPC_NONE),
> +GEN_HANDLER_E_2(mffscrni, 0x3F, 0x07, 0x12, 0x17, 0x00000000, PPC_FLOAT,
> +    PPC_NONE),
>  GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
>  GEN_HANDLER(mtfsb1, 0x3F, 0x06, 0x01, 0x001FF800, PPC_FLOAT),
>  GEN_HANDLER(mtfsf, 0x3F, 0x07, 0x16, 0x00000000, PPC_FLOAT),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2DICoACgkQbDjKyiDZ
s5L3JA/8DVJB0KYzhG75tnj7HOzk67Z/idyVMY0HGcornKmytIiPZPoF5rr2szYW
RTFOyjyqnlhf6+KkB/fdRfBXwaxyCbdW5BFl2xgwF5XXx8Gds6n4UCw3LV6nWKq5
TFar9oQ+jVDSaXoZjBQoSBMU9idG0EfRWrsPRxxCqPVfRy/NB5c8ymycFhVUi2b6
72ac6p4FcRitxKyhU0QKvK83DxrEF2KrAwp6LUYXCbicS5pOKw+nZYQkn31TqEAH
D4HnRLvBkew+dd24xNGVLL3e3zYQ4G8uncwF5Yu+AAgw0foCcyFXiCFX6zdoS4+G
htoroeT18oS89NVmgK4gCrqgpBOf+o2xg/3FCHWz9oACcZ4Sg2qdidLDS8FCFsNN
ESXQbjB/H7Glcfi/U2YCUTh4yPsLoG25VESP9WPy6hzoAwM6d+3FCPfpBlMrcP8Z
IXVvauZmApvMeUQ/KHFk6dXJ7ryLfU49JquTR6U+8RDUJkHG63pCdM4goUo04BVq
skJIEy5EALYxSKXW4A2ASidplPxDtFzQS4fVfxFVOX+x/r9BgoMvIMLdoTaDSLMn
k0/2ZdZJgBLnaPM9vlPSs0TBcdSBqQumWnywebvlH1hErPx0iebr4G1EmpI+Slza
mfdPdixSK6+JRzloWmi3vbnWPvamPSGdkvd3/VrlS1jK9leiVGA=
=TeOQ
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

