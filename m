Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D81C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506B321924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CXBzsN1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506B321924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqIr-0001wz-AC
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGz-0000T8-Hn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGw-0000m5-Ti
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:37 -0400
Received: from ozlabs.org ([203.11.71.1]:46637)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iAqGv-0000ie-Pf; Thu, 19 Sep 2019 02:50:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YnXz3sYdz9sNw; Thu, 19 Sep 2019 16:50:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568875827;
 bh=E2wrbo8bYX8+mIM3gK/lzT+Ncx57wXWAM7/UhhltWnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CXBzsN1n1sUnSpknTt/xSIKq59hisvlaWs1O1KP9+sHxrPBOqNTg4FyWiCU8eo0Hr
 5fO8GFjZrrLfQcf6h+sUTAiv/rW3B6/sGL8yFUp4Buy/MoMNjaPIAiMl+BMuJx6UGj
 cZ1feOjuRHhLbtw6kQgxCDuO9d2NilwhaoHHLo7I=
Date: Thu, 19 Sep 2019 16:30:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190919063000.GE22790@umbus.fritz.box>
References: <1568817169-1721-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <1568817169-1721-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc: Use FPSCR defines instead of constants
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


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:32:49AM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> There are FPSCR-related defines in target/ppc/cpu.h which can be used in
> place of constants and explicit shifts which arguably improve the code a
> bit in places.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
> I confirmed that the generated assembly is identical before and after
> the patch.
>=20
>  target/ppc/dfp_helper.c |   8 ++--
>  target/ppc/fpu_helper.c | 122 ++++++++++++++++++++++++------------------=
------
>  2 files changed, 65 insertions(+), 65 deletions(-)
>=20
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index da8e08a..7533991 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -220,8 +220,8 @@ static void dfp_set_FPRF_from_FRT_with_context(struct=
 PPC_DFP *dfp,
>      default:
>          assert(0); /* should never get here */
>      }
> -    dfp->env->fpscr &=3D ~(0x1F << 12);
> -    dfp->env->fpscr |=3D (fprf << 12);
> +    dfp->env->fpscr &=3D ~FP_FPRF;
> +    dfp->env->fpscr |=3D (fprf << FPSCR_FPRF);
>  }
> =20
>  static void dfp_set_FPRF_from_FRT(struct PPC_DFP *dfp)
> @@ -369,8 +369,8 @@ static void dfp_set_CRBF_from_T(struct PPC_DFP *dfp)
> =20
>  static void dfp_set_FPCC_from_CRBF(struct PPC_DFP *dfp)
>  {
> -    dfp->env->fpscr &=3D ~(0xF << 12);
> -    dfp->env->fpscr |=3D (dfp->crbf << 12);
> +    dfp->env->fpscr &=3D ~FP_FPCC;
> +    dfp->env->fpscr |=3D (dfp->crbf << FPSCR_FPCC);
>  }
> =20
>  static inline void dfp_makeQNaN(decNumber *dn)
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 4b1a2e6..dc38324 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -180,7 +180,7 @@ static void set_fprf_from_class(CPUPPCState *env, int=
 class)
>      };
>      bool isneg =3D class & is_neg;
> =20
> -    env->fpscr &=3D ~(0x1F << FPSCR_FPRF);
> +    env->fpscr &=3D ~FP_FPRF;
>      env->fpscr |=3D fprf[ctz32(class)][isneg] << FPSCR_FPRF;
>  }
> =20
> @@ -199,12 +199,12 @@ COMPUTE_FPRF(float128)
>  static void finish_invalid_op_excp(CPUPPCState *env, int op, uintptr_t r=
etaddr)
>  {
>      /* Update the floating-point invalid operation summary */
> -    env->fpscr |=3D 1 << FPSCR_VX;
> +    env->fpscr |=3D FP_VX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      if (fpscr_ve !=3D 0) {
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          if (fp_exceptions_enabled(env)) {
>              raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
>                                     POWERPC_EXCP_FP | op, retaddr);
> @@ -215,11 +215,11 @@ static void finish_invalid_op_excp(CPUPPCState *env=
, int op, uintptr_t retaddr)
>  static void finish_invalid_op_arith(CPUPPCState *env, int op,
>                                      bool set_fpcc, uintptr_t retaddr)
>  {
> -    env->fpscr &=3D ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
> +    env->fpscr &=3D ~(FP_FR | FP_FI);
>      if (fpscr_ve =3D=3D 0) {
>          if (set_fpcc) {
> -            env->fpscr &=3D ~(0xF << FPSCR_FPCC);
> -            env->fpscr |=3D 0x11 << FPSCR_FPCC;
> +            env->fpscr &=3D ~FP_FPCC;
> +            env->fpscr |=3D (FP_C | FP_FU);
>          }
>      }
>      finish_invalid_op_excp(env, op, retaddr);
> @@ -228,7 +228,7 @@ static void finish_invalid_op_arith(CPUPPCState *env,=
 int op,
>  /* Signalling NaN */
>  static void float_invalid_op_vxsnan(CPUPPCState *env, uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXSNAN;
> +    env->fpscr |=3D FP_VXSNAN;
>      finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, retaddr);
>  }
> =20
> @@ -236,7 +236,7 @@ static void float_invalid_op_vxsnan(CPUPPCState *env,=
 uintptr_t retaddr)
>  static void float_invalid_op_vxisi(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXISI;
> +    env->fpscr |=3D FP_VXISI;
>      finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXISI, set_fpcc, retadd=
r);
>  }
> =20
> @@ -244,7 +244,7 @@ static void float_invalid_op_vxisi(CPUPPCState *env, =
bool set_fpcc,
>  static void float_invalid_op_vxidi(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXIDI;
> +    env->fpscr |=3D FP_VXIDI;
>      finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIDI, set_fpcc, retadd=
r);
>  }
> =20
> @@ -252,7 +252,7 @@ static void float_invalid_op_vxidi(CPUPPCState *env, =
bool set_fpcc,
>  static void float_invalid_op_vxzdz(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXZDZ;
> +    env->fpscr |=3D FP_VXZDZ;
>      finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXZDZ, set_fpcc, retadd=
r);
>  }
> =20
> @@ -260,7 +260,7 @@ static void float_invalid_op_vxzdz(CPUPPCState *env, =
bool set_fpcc,
>  static void float_invalid_op_vximz(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXIMZ;
> +    env->fpscr |=3D FP_VXIMZ;
>      finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXIMZ, set_fpcc, retadd=
r);
>  }
> =20
> @@ -268,7 +268,7 @@ static void float_invalid_op_vximz(CPUPPCState *env, =
bool set_fpcc,
>  static void float_invalid_op_vxsqrt(CPUPPCState *env, bool set_fpcc,
>                                      uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXSQRT;
> +    env->fpscr |=3D FP_VXSQRT;
>      finish_invalid_op_arith(env, POWERPC_EXCP_FP_VXSQRT, set_fpcc, retad=
dr);
>  }
> =20
> @@ -276,13 +276,13 @@ static void float_invalid_op_vxsqrt(CPUPPCState *en=
v, bool set_fpcc,
>  static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
>                                    uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXVC;
> +    env->fpscr |=3D FP_VXVC;
>      if (set_fpcc) {
> -        env->fpscr &=3D ~(0xF << FPSCR_FPCC);
> -        env->fpscr |=3D 0x11 << FPSCR_FPCC;
> +        env->fpscr &=3D ~FP_FPCC;
> +        env->fpscr |=3D (FP_C | FP_FU);
>      }
>      /* Update the floating-point invalid operation summary */
> -    env->fpscr |=3D 1 << FPSCR_VX;
> +    env->fpscr |=3D FP_VX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      /* We must update the target FPR before raising the exception */
> @@ -292,7 +292,7 @@ static void float_invalid_op_vxvc(CPUPPCState *env, b=
ool set_fpcc,
>          cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>          env->error_code =3D POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          /* Exception is differed */
>      }
>  }
> @@ -301,12 +301,12 @@ static void float_invalid_op_vxvc(CPUPPCState *env,=
 bool set_fpcc,
>  static void float_invalid_op_vxcvi(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_VXCVI;
> -    env->fpscr &=3D ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
> +    env->fpscr |=3D FP_VXCVI;
> +    env->fpscr &=3D ~(FP_FR | FP_FI);
>      if (fpscr_ve =3D=3D 0) {
>          if (set_fpcc) {
> -            env->fpscr &=3D ~(0xF << FPSCR_FPCC);
> -            env->fpscr |=3D 0x11 << FPSCR_FPCC;
> +            env->fpscr &=3D ~FP_FPCC;
> +            env->fpscr |=3D (FP_C | FP_FU);
>          }
>      }
>      finish_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, retaddr);
> @@ -314,13 +314,13 @@ static void float_invalid_op_vxcvi(CPUPPCState *env=
, bool set_fpcc,
> =20
>  static inline void float_zero_divide_excp(CPUPPCState *env, uintptr_t ra=
ddr)
>  {
> -    env->fpscr |=3D 1 << FPSCR_ZX;
> -    env->fpscr &=3D ~((1 << FPSCR_FR) | (1 << FPSCR_FI));
> +    env->fpscr |=3D FP_ZX;
> +    env->fpscr &=3D ~(FP_FR | FP_FI);
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      if (fpscr_ze !=3D 0) {
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          if (fp_exceptions_enabled(env)) {
>              raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
>                                     POWERPC_EXCP_FP | POWERPC_EXCP_FP_ZX,
> @@ -333,19 +333,19 @@ static inline void float_overflow_excp(CPUPPCState =
*env)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> -    env->fpscr |=3D 1 << FPSCR_OX;
> +    env->fpscr |=3D FP_OX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      if (fpscr_oe !=3D 0) {
>          /* XXX: should adjust the result */
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          /* We must update the target FPR before raising the exception */
>          cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>          env->error_code =3D POWERPC_EXCP_FP | POWERPC_EXCP_FP_OX;
>      } else {
> -        env->fpscr |=3D 1 << FPSCR_XX;
> -        env->fpscr |=3D 1 << FPSCR_FI;
> +        env->fpscr |=3D FP_XX;
> +        env->fpscr |=3D FP_FI;
>      }
>  }
> =20
> @@ -353,13 +353,13 @@ static inline void float_underflow_excp(CPUPPCState=
 *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> -    env->fpscr |=3D 1 << FPSCR_UX;
> +    env->fpscr |=3D FP_UX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      if (fpscr_ue !=3D 0) {
>          /* XXX: should adjust the result */
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          /* We must update the target FPR before raising the exception */
>          cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>          env->error_code =3D POWERPC_EXCP_FP | POWERPC_EXCP_FP_UX;
> @@ -370,13 +370,13 @@ static inline void float_inexact_excp(CPUPPCState *=
env)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> -    env->fpscr |=3D 1 << FPSCR_FI;
> -    env->fpscr |=3D 1 << FPSCR_XX;
> +    env->fpscr |=3D FP_FI;
> +    env->fpscr |=3D FP_XX;
>      /* Update the floating-point exception summary */
>      env->fpscr |=3D FP_FX;
>      if (fpscr_xe !=3D 0) {
>          /* Update the floating-point enabled exception summary */
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          /* We must update the target FPR before raising the exception */
>          cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>          env->error_code =3D POWERPC_EXCP_FP | POWERPC_EXCP_FP_XX;
> @@ -433,7 +433,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t b=
it)
>          case FPSCR_VXCVI:
>              if (!fpscr_ix) {
>                  /* Set VX bit to zero */
> -                env->fpscr &=3D ~(1 << FPSCR_VX);
> +                env->fpscr &=3D ~FP_VX;
>              }
>              break;
>          case FPSCR_OX:
> @@ -447,7 +447,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t b=
it)
>          case FPSCR_XE:
>              if (!fpscr_eex) {
>                  /* Set the FEX bit */
> -                env->fpscr &=3D ~(1 << FPSCR_FEX);
> +                env->fpscr &=3D ~FP_FEX;
>              }
>              break;
>          default:
> @@ -504,7 +504,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t b=
it)
>          case FPSCR_VXSOFT:
>          case FPSCR_VXSQRT:
>          case FPSCR_VXCVI:
> -            env->fpscr |=3D 1 << FPSCR_VX;
> +            env->fpscr |=3D FP_VX;
>              env->fpscr |=3D FP_FX;
>              if (fpscr_ve !=3D 0) {
>                  goto raise_ve;
> @@ -580,7 +580,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t b=
it)
>              break;
>          raise_excp:
>              /* Update the floating-point enabled exception summary */
> -            env->fpscr |=3D 1 << FPSCR_FEX;
> +            env->fpscr |=3D FP_FEX;
>              /* We have to update Rc1 before raising the exception */
>              cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>              break;
> @@ -596,8 +596,8 @@ void helper_store_fpscr(CPUPPCState *env, uint64_t ar=
g, uint32_t mask)
> =20
>      prev =3D env->fpscr;
>      new =3D (target_ulong)arg;
> -    new &=3D ~0x60000000LL;
> -    new |=3D prev & 0x60000000LL;
> +    new &=3D ~(FP_FEX | FP_VX);
> +    new |=3D prev & (FP_FEX | FP_VX);
>      for (i =3D 0; i < sizeof(target_ulong) * 2; i++) {
>          if (mask & (1 << i)) {
>              env->fpscr &=3D ~(0xFLL << (4 * i));
> @@ -606,17 +606,17 @@ void helper_store_fpscr(CPUPPCState *env, uint64_t =
arg, uint32_t mask)
>      }
>      /* Update VX and FEX */
>      if (fpscr_ix !=3D 0) {
> -        env->fpscr |=3D 1 << FPSCR_VX;
> +        env->fpscr |=3D FP_VX;
>      } else {
> -        env->fpscr &=3D ~(1 << FPSCR_VX);
> +        env->fpscr &=3D ~FP_VX;
>      }
>      if ((fpscr_ex & fpscr_eex) !=3D 0) {
> -        env->fpscr |=3D 1 << FPSCR_FEX;
> +        env->fpscr |=3D FP_FEX;
>          cs->exception_index =3D POWERPC_EXCP_PROGRAM;
>          /* XXX: we should compute it properly */
>          env->error_code =3D POWERPC_EXCP_FP;
>      } else {
> -        env->fpscr &=3D ~(1 << FPSCR_FEX);
> +        env->fpscr &=3D ~FP_FEX;
>      }
>      fpscr_set_rounding_mode(env);
>  }
> @@ -639,7 +639,7 @@ static void do_float_check_status(CPUPPCState *env, u=
intptr_t raddr)
>      if (status & float_flag_inexact) {
>          float_inexact_excp(env);
>      } else {
> -        env->fpscr &=3D ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
> +        env->fpscr &=3D ~FP_FI; /* clear the FPSCR[FI] bit */
>      }
> =20
>      if (cs->exception_index =3D=3D POWERPC_EXCP_PROGRAM &&
> @@ -1138,8 +1138,8 @@ void helper_fcmpu(CPUPPCState *env, uint64_t arg1, =
uint64_t arg2,
>          ret =3D 0x02UL;
>      }
> =20
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);
> -    env->fpscr |=3D ret << FPSCR_FPRF;
> +    env->fpscr &=3D ~FP_FPCC;
> +    env->fpscr |=3D ret << FPSCR_FPCC;
>      env->crf[crfD] =3D ret;
>      if (unlikely(ret =3D=3D 0x01UL
>                   && (float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
> @@ -1169,9 +1169,9 @@ void helper_fcmpo(CPUPPCState *env, uint64_t arg1, =
uint64_t arg2,
>          ret =3D 0x02UL;
>      }
> =20
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);
> -    env->fpscr |=3D ret << FPSCR_FPRF;
> -    env->crf[crfD] =3D ret;
> +    env->fpscr &=3D ~FP_FPCC;
> +    env->fpscr |=3D ret << FPSCR_FPCC;
> +    env->crf[crfD] =3D (uint32_t) ret;
>      if (unlikely(ret =3D=3D 0x01UL)) {
>          float_invalid_op_vxvc(env, 1, GETPC());
>          if (float64_is_signaling_nan(farg1.d, &env->fp_status) ||
> @@ -2431,8 +2431,8 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t o=
pcode,
>          }
>      }
> =20
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);
> -    env->fpscr |=3D cc << FPSCR_FPRF;
> +    env->fpscr &=3D ~FP_FPCC;
> +    env->fpscr |=3D cc << FPSCR_FPCC;
>      env->crf[BF(opcode)] =3D cc;
> =20
>      do_float_check_status(env, GETPC());
> @@ -2460,8 +2460,8 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t o=
pcode,
>          }
>      }
> =20
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);
> -    env->fpscr |=3D cc << FPSCR_FPRF;
> +    env->fpscr &=3D ~FP_FPCC;
> +    env->fpscr |=3D cc << FPSCR_FPCC;
>      env->crf[BF(opcode)] =3D cc;
> =20
>      do_float_check_status(env, GETPC());
> @@ -2505,8 +2505,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,=
                      \
>          cc |=3D CRF_EQ;                                                 =
   \
>      }                                                                   =
 \
>                                                                          =
 \
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);                              =
   \
> -    env->fpscr |=3D cc << FPSCR_FPRF;                                   =
   \
> +    env->fpscr &=3D ~FP_FPCC;                                           =
   \
> +    env->fpscr |=3D cc << FPSCR_FPCC;                                   =
   \
>      env->crf[BF(opcode)] =3D cc;                                        =
   \
>                                                                          =
 \
>      do_float_check_status(env, GETPC());                                =
 \
> @@ -2553,8 +2553,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,=
                     \
>          cc |=3D CRF_EQ;                                                 =
  \
>      }                                                                   \
>                                                                          \
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);                              =
  \
> -    env->fpscr |=3D cc << FPSCR_FPRF;                                   =
  \
> +    env->fpscr &=3D ~FP_FPCC;                                           =
  \
> +    env->fpscr |=3D cc << FPSCR_FPCC;                                   =
  \
>      env->crf[BF(opcode)] =3D cc;                                        =
  \
>                                                                          \
>      do_float_check_status(env, GETPC());                                \
> @@ -3242,8 +3242,8 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
         \
>                                                              \
>          if (scrf) {                                         \
>              cc =3D sign << CRF_LT_BIT | match << CRF_EQ_BIT;  \
> -            env->fpscr &=3D ~(0x0F << FPSCR_FPRF);            \
> -            env->fpscr |=3D cc << FPSCR_FPRF;                 \
> +            env->fpscr &=3D ~FP_FPCC;                         \
> +            env->fpscr |=3D cc << FPSCR_FPCC;                 \
>              env->crf[BF(opcode)] =3D cc;                      \
>          } else {                                            \
>              t.tfld =3D match ? fld_max : 0;                   \
> @@ -3286,8 +3286,8 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t op=
code, ppc_vsr_t *xb)
>                               &env->fp_status), &env->fp_status);
> =20
>      cc =3D sign << CRF_LT_BIT | match << CRF_EQ_BIT | not_sp << CRF_SO_B=
IT;
> -    env->fpscr &=3D ~(0x0F << FPSCR_FPRF);
> -    env->fpscr |=3D cc << FPSCR_FPRF;
> +    env->fpscr &=3D ~FP_FPCC;
> +    env->fpscr |=3D cc << FPSCR_FPCC;
>      env->crf[BF(opcode)] =3D cc;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2DIGcACgkQbDjKyiDZ
s5IcZBAAkQJ0WFOSLk724axVnqfdvHvjZaR8wx2vvfYVjyJ9Nf0qsP1h0hmoQPlS
p/o2J3OBrwtHo7fkwuFulcYtoGaSzICzLtSsxsdzWatGC/GjCpMQugWzI7XjGjVQ
tmS6vHkqY7XX744LUOZksExVVkgc9uQPnADWTYQ+BbF6thBCRhYr3AJMiOnnpEVH
jGzg2O3oZO9D1R4YJoLz0/mozDz4/zGH6pq2REbFXjmBR2YihnUIcTSESbb0CRk5
mI0OquYNo2b9H7Jw6a9QEHQ7+kiSU8z3YppZByApCr8SdosE8/feRLB26RadKvNy
aGT+IDQyzIhqeP8iS19UKFbVcgQC6KJFiX/ACC8dEkJgPj1oMxrSvwQysCDChlWa
wcpyujkujs6dK5ADsTdKBNw9DPjCVvvxgYx9O1HJwuOCHtTvtq6g7DmCzM+p+OMi
zLs9oHwwmJX1mRPA1UNrvvslSLLWcljs8Y6i0n+ZpAB16qzMQtaOwKCKs7eszlvi
q7/0uWL38DoSjWfTzzIj/G0cUvVQ2q/BFx9d4Y45FWwaIAvIBHUQEmi2JWd9iifw
rmdIrlUpDJ0eBm2ZvxANb4vxtJWRQ2foTaDQXzzZx55itaXBoBzf2mXA16iLoKEW
/MPplv8XKPzAg9rMJgON5HsxIpdWJmqLo/AkmRaF1mgzAf7Pw04=
=TObZ
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--

