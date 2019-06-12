Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFDC31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631352080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 02:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cjNIpq4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631352080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasc7-00087W-Mu
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 22:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hasTQ-0002J1-Id
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hasTM-0006rM-UB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:54:46 -0400
Received: from ozlabs.org ([203.11.71.1]:52771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hasTI-0006oj-U4; Tue, 11 Jun 2019 21:54:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NqgJ5XnDz9s3l; Wed, 12 Jun 2019 11:54:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560304476;
 bh=se8nKaw6f9VyUJ420KfXo6mgAKCnv46+brq6aleVmTc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cjNIpq4R7gZQd3e0zgRtBhLFpEvrttSDdgFEn575TZCimvBeh66HJc5Lq24lDFhV+
 HRsSWVEdsls7FmuKsa9YPbiLwUjiI9H0DyBcvDE9uDHSIfgsVMBDJSG32zNEJJiDMw
 fel0FLuacDWk1DMSgHq/F9Q+r79tiRldSVWouisA=
Date: Wed, 12 Jun 2019 11:52:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190612015224.GG3998@umbus.fritz.box>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 04/15] target/ppc: introduce separate
 VSX_CMP macro for xvcmp* instructions
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2019 at 12:08:52PM +0100, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new VSX_CMP macro which performs the decode based upon xT, xA
> and xB at translation time.
>=20
> Subsequent commits will make the same changes for other instructions howe=
ver
> the xvcmp* instructions are different in that they return a set of flags =
to be
> optionally written back to the crf[6] register. Move this logic from the
> helper function to the generator function, along with the
> float_status update.

What's the advantage of this.  Since we still have a helper, don't we
suffer the cost of the helper call *plus* the now-generated
instructions?

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 15 +++++-------
>  target/ppc/helper.h                 | 20 +++++++++------
>  target/ppc/translate/vsx-impl.inc.c | 49 +++++++++++++++++++++++++++++++=
------
>  3 files changed, 59 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 5edf913a89..4b9b695333 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -2746,12 +2746,11 @@ VSX_MAX_MINJ(xsminjdp, 0);
>   *   exp   - expected result of comparison
>   */
>  #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                     =
  \
> -void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
  \
> +uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                   =
  \
> +                     ppc_vsr_t *xa, ppc_vsr_t *xb)                      =
  \
>  {                                                                       =
  \
> -    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
    \
> -    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
    \
> -    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
    \
>      ppc_vsr_t t =3D *xt;                                                =
    \
> +    uint32_t crf6 =3D 0;                                                =
    \
>      int i;                                                              =
  \
>      int all_true =3D 1;                                                 =
    \
>      int all_false =3D 1;                                                =
    \
> @@ -2780,11 +2779,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                       \
>      }                                                                   =
  \
>                                                                          =
  \
>      *xt =3D t;                                                          =
    \
> -    if ((opcode >> (31 - 21)) & 1) {                                    =
  \
> -        env->crf[6] =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);   =
    \
> -    }                                                                   =
  \
> -    do_float_check_status(env, GETPC());                                =
  \
> - }
> +    crf6 =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);              =
    \
> +    return crf6;                                                        =
  \
> +}
> =20
>  VSX_CMP(xvcmpeqdp, 2, float64, VsrD(i), eq, 0, 1)
>  VSX_CMP(xvcmpgedp, 2, float64, VsrD(i), le, 1, 1)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 02b67a333e..8666415169 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -108,6 +108,10 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, =
i64)
>  #define dh_ctype_avr ppc_avr_t *
>  #define dh_is_signed_avr dh_is_signed_ptr
> =20
> +#define dh_alias_vsr ptr
> +#define dh_ctype_vsr ppc_vsr_t *
> +#define dh_is_signed_vsr dh_is_signed_ptr
> +
>  DEF_HELPER_3(vavgub, void, avr, avr, avr)
>  DEF_HELPER_3(vavguh, void, avr, avr, avr)
>  DEF_HELPER_3(vavguw, void, avr, avr, avr)
> @@ -468,10 +472,10 @@ DEF_HELPER_2(xvnmsubadp, void, env, i32)
>  DEF_HELPER_2(xvnmsubmdp, void, env, i32)
>  DEF_HELPER_2(xvmaxdp, void, env, i32)
>  DEF_HELPER_2(xvmindp, void, env, i32)
> -DEF_HELPER_2(xvcmpeqdp, void, env, i32)
> -DEF_HELPER_2(xvcmpgedp, void, env, i32)
> -DEF_HELPER_2(xvcmpgtdp, void, env, i32)
> -DEF_HELPER_2(xvcmpnedp, void, env, i32)
> +DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpnedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
>  DEF_HELPER_2(xvcvdpsp, void, env, i32)
>  DEF_HELPER_2(xvcvdpsxds, void, env, i32)
>  DEF_HELPER_2(xvcvdpsxws, void, env, i32)
> @@ -506,10 +510,10 @@ DEF_HELPER_2(xvnmsubasp, void, env, i32)
>  DEF_HELPER_2(xvnmsubmsp, void, env, i32)
>  DEF_HELPER_2(xvmaxsp, void, env, i32)
>  DEF_HELPER_2(xvminsp, void, env, i32)
> -DEF_HELPER_2(xvcmpeqsp, void, env, i32)
> -DEF_HELPER_2(xvcmpgesp, void, env, i32)
> -DEF_HELPER_2(xvcmpgtsp, void, env, i32)
> -DEF_HELPER_2(xvcmpnesp, void, env, i32)
> +DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
> +DEF_HELPER_FLAGS_4(xvcmpnesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
>  DEF_HELPER_2(xvcvspdp, void, env, i32)
>  DEF_HELPER_2(xvcvsphp, void, env, i32)
>  DEF_HELPER_2(xvcvhpsp, void, env, i32)
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 199d22da97..fb52a5bbf7 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -20,6 +20,13 @@ static inline void set_cpu_vsrl(int n, TCGv_i64 src)
>      tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, false));
>  }
> =20
> +static inline TCGv_ptr gen_vsr_ptr(int reg)
> +{
> +    TCGv_ptr r =3D tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(r, cpu_env, vsr_full_offset(reg));
> +    return r;
> +}
> +
>  #define VSX_LOAD_SCALAR(name, operation)                      \
>  static void gen_##name(DisasContext *ctx)                     \
>  {                                                             \
> @@ -957,6 +964,40 @@ VSX_VECTOR_MOVE(xvnabssp, OP_NABS, SGN_MASK_SP)
>  VSX_VECTOR_MOVE(xvnegsp, OP_NEG, SGN_MASK_SP)
>  VSX_VECTOR_MOVE(xvcpsgnsp, OP_CPSGN, SGN_MASK_SP)
> =20
> +#define VSX_CMP(name, op1, op2, inval, type)                            =
      \
> +static void gen_##name(DisasContext *ctx)                               =
      \
> +{                                                                       =
      \
> +    TCGv_i32 ignored;                                                   =
      \
> +    TCGv_ptr xt, xa, xb;                                                =
      \
> +    if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                          =
      \
> +        return;                                                         =
      \
> +    }                                                                   =
      \
> +    xt =3D gen_vsr_ptr(xT(ctx->opcode));                                =
        \
> +    xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
> +    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
> +    if ((ctx->opcode >> (31 - 21)) & 1) {                               =
      \
> +        gen_helper_##name(cpu_crf[6], cpu_env, xt, xa, xb);             =
      \
> +    } else {                                                            =
      \
> +        ignored =3D tcg_temp_new_i32();                                 =
        \
> +        gen_helper_##name(ignored, cpu_env, xt, xa, xb);                =
      \
> +        tcg_temp_free_i32(ignored);                                     =
      \
> +    }                                                                   =
      \
> +    gen_helper_float_check_status(cpu_env);                             =
      \
> +    tcg_temp_free_ptr(xt);                                              =
      \
> +    tcg_temp_free_ptr(xa);                                              =
      \
> +    tcg_temp_free_ptr(xb);                                              =
      \
> +}
> +
> +VSX_CMP(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
> +VSX_CMP(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
> +VSX_CMP(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
> +VSX_CMP(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
> +VSX_CMP(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
> +VSX_CMP(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
> +VSX_CMP(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
> +VSX_CMP(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
> +
>  #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                   =
      \
>  static void gen_##name(DisasContext *ctx)                               =
      \
>  {                                                                       =
      \
> @@ -1096,10 +1137,6 @@ GEN_VSX_HELPER_2(xvnmsubadp, 0x04, 0x1E, 0, PPC2_V=
SX)
>  GEN_VSX_HELPER_2(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpgtdp, 0x0C, 0x0D, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpgedp, 0x0C, 0x0E, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpnedp, 0x0C, 0x0F, 0, PPC2_ISA300)
>  GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
> @@ -1134,10 +1171,6 @@ GEN_VSX_HELPER_2(xvnmsubasp, 0x04, 0x1A, 0, PPC2_V=
SX)
>  GEN_VSX_HELPER_2(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpgtsp, 0x0C, 0x09, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpgesp, 0x0C, 0x0A, 0, PPC2_VSX)
> -GEN_VSX_HELPER_2(xvcmpnesp, 0x0C, 0x0B, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
>  GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
>  GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AWtYACgkQbDjKyiDZ
s5LcXw//bFMQND5h7NvQakPUDl55JhrQnqHQI3gkS9GVIrHhmLP2Kuqnzzacr4d9
QtGPGHQjZ33X8eA0DFJHXde6Bzmd5/VuJFjfbREGkc+5QsJNZbX/ij3BG0ZPWrs/
hqx+IEzdukFT6e2z2wrkaaD85wGBUVAj7L2fQYpbLPSVR5LGJKSdlq+dLd0hGRje
HZhKKcuiJlHBSIyAgaLg+ZHknak3jHxUF67KI5HRaNn3LOoY6mBdPxEvchiKw3st
BeexNFcfn8O+AJtsOQYjfPIDAdu4IAtolAzolNI/M7sJvdUT2OYVuShs7gGPM3t+
IlrGxmkgAgNNNR8qh0/iLsRCL1HkX1tqvTCaI280l1hcAN/o17a0v5JUblOCW4+a
oNIYeYks63SlriyHDtM67azUQ4mwDc3cSskWY4F6HJLqKLlbX0AzZIQqLsyf2dOb
Dv5NJUhgKhjC6072B23ON6IfK46XeTPKle2yx9/8IyZhBkIM6cv8TWMykmB9ZujD
LYwJ6BFxsiB8sDjJZqu60VlqUnGf7GtxQUkjTEd85ZTPeihhytLjcKeipPlpxNqt
q+FeV9MIaOuETBvAqeZyAt8mIDTnMTpLlleANFN1jXKK3ZwqAyn8j7k17EmNe7i8
D0AQJr8tq0PlYERMyoyA5qpEJ2xB4D0Sci4CKaoBN/8bJ7jeX4Y=
=GKEJ
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--

