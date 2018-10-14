Received: from eggs.gnu.org ([2001:4830:134:3::10]:47717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoav-0004s0-9h
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoar-0000Rw-De
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:10:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBoan-0000No-Jw
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:10:34 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so6874371ywa.5
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 15:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-20-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 15 Oct 2018 00:10:18 +0200
Message-ID: <CAAdtpL5t0vuC1YcQbp5mKN9n0=1zhhPfSYWFxb=xLxD97X5mnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 19/28] target/mips: Improve DSP
 R2/R3-related naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Oct 12, 2018 at 7:07 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Do following replacements:
>
> ASE_DSPR2 -> ASE_DSP_R2
> ASE_DSPR3 -> ASE_DSP_R3
> check_dspr2() -> check_dsp_r2()
> check_dspr3() -> check_dsp_r3()
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/mips/internal.h           |   4 +-
>  target/mips/mips-defs.h          |   4 +-
>  target/mips/translate.c          | 180 +++++++++++++++++++--------------=
------
>  target/mips/translate_init.inc.c |   8 +-
>  4 files changed, 98 insertions(+), 98 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index e367d7e..6cf00d8 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -358,12 +358,12 @@ static inline void compute_hflags(CPUMIPSState *env=
)
>          (env->CP0_Config5 & (1 << CP0C5_SBRI))) {
>          env->hflags |=3D MIPS_HFLAG_SBRI;
>      }
> -    if (env->insn_flags & ASE_DSPR3) {
> +    if (env->insn_flags & ASE_DSP_R3) {
>          if (env->CP0_Status & (1 << CP0St_MX)) {
>              env->hflags |=3D MIPS_HFLAG_DSP | MIPS_HFLAG_DSPR2 |
>                             MIPS_HFLAG_DSPR3;
>          }
> -    } else if (env->insn_flags & ASE_DSPR2) {
> +    } else if (env->insn_flags & ASE_DSP_R2) {
>          /* Enables access MIPS DSP resources, now our cpu is DSP ASER2,
>             so enable to access DSPR2 resources. */
>          if (env->CP0_Status & (1 << CP0St_MX)) {
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index b27b7ae..5b985b8 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -46,8 +46,8 @@
>  #define   ASE_MIPS3D    0x00020000
>  #define   ASE_MDMX      0x00040000
>  #define   ASE_DSP       0x00080000
> -#define   ASE_DSPR2     0x00100000
> -#define   ASE_DSPR3     0x02000000
> +#define   ASE_DSP_R2    0x00100000
> +#define   ASE_DSP_R3    0x02000000
>  #define   ASE_MT        0x00200000
>  #define   ASE_SMARTMIPS 0x00400000
>  #define   ASE_MICROMIPS 0x00800000
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index c3ad65c..1d31051 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1858,7 +1858,7 @@ static inline void check_dsp(DisasContext *ctx)
>      }
>  }
>
> -static inline void check_dspr2(DisasContext *ctx)
> +static inline void check_dsp_r2(DisasContext *ctx)
>  {
>      if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR2))) {
>          if (ctx->insn_flags & ASE_DSP) {
> @@ -1869,7 +1869,7 @@ static inline void check_dspr2(DisasContext *ctx)
>      }
>  }
>
> -static inline void check_dspr3(DisasContext *ctx)
> +static inline void check_dsp_r3(DisasContext *ctx)
>  {
>      if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSPR3))) {
>          if (ctx->insn_flags & ASE_DSP) {
> @@ -17642,7 +17642,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>      case NM_POOL32AXF_2_0_7:
>          switch (extract32(ctx->opcode, 9, 3)) {
>          case NM_DPA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpa_w_ph(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPAQ_S_W_PH:
> @@ -17650,7 +17650,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>              gen_helper_dpaq_s_w_ph(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPS_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dps_w_ph(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPSQ_S_W_PH:
> @@ -17665,7 +17665,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>      case NM_POOL32AXF_2_8_15:
>          switch (extract32(ctx->opcode, 9, 3)) {
>          case NM_DPAX_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpax_w_ph(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPAQ_SA_L_W:
> @@ -17673,7 +17673,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>              gen_helper_dpaq_sa_l_w(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPSX_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsx_w_ph(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPSQ_SA_L_W:
> @@ -17692,7 +17692,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>              gen_helper_dpau_h_qbl(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPAQX_S_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpaqx_s_w_ph(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPSU_H_QBL:
> @@ -17700,11 +17700,11 @@ static void gen_pool32axf_2_multiply(DisasConte=
xt *ctx, uint32_t opc,
>              gen_helper_dpsu_h_qbl(t0, v0, v1, cpu_env);
>              break;
>          case NM_DPSQX_S_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsqx_s_w_ph(t0, v0, v1, cpu_env);
>              break;
>          case NM_MULSA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_mulsa_w_ph(t0, v0, v1, cpu_env);
>              break;
>          default:
> @@ -17719,7 +17719,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>              gen_helper_dpau_h_qbr(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPAQX_SA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpaqx_sa_w_ph(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPSU_H_QBR:
> @@ -17727,7 +17727,7 @@ static void gen_pool32axf_2_multiply(DisasContext=
 *ctx, uint32_t opc,
>              gen_helper_dpsu_h_qbr(t0, v1, v0, cpu_env);
>              break;
>          case NM_DPSQX_SA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsqx_sa_w_ph(t0, v1, v0, cpu_env);
>              break;
>          case NM_MULSAQ_S_W_PH:
> @@ -17769,7 +17769,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasCo=
ntext *ctx, uint32_t opc,
>              gen_pool32axf_2_multiply(ctx, opc, v0_t, v1_t, rd);
>              break;
>          case NM_BALIGN:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              if (rt !=3D 0) {
>                  gen_load_gpr(t0, rs);
>                  rd &=3D 3;
> @@ -17999,7 +17999,7 @@ static void gen_pool32axf_4_nanomips_insn(DisasCo=
ntext *ctx, uint32_t opc,
>
>      switch (opc) {
>      case NM_ABSQ_S_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_absq_s_qb(v0_t, v0_t, cpu_env);
>          gen_store_gpr(v0_t, ret);
>          break;
> @@ -18138,7 +18138,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasCo=
ntext *ctx, uint32_t opc,
>
>      switch (opc) {
>      case NM_SHRA_R_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          tcg_gen_movi_tl(t0, rd >> 2);
>          switch (extract32(ctx->opcode, 12, 1)) {
>          case 0:
> @@ -18154,7 +18154,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasCo=
ntext *ctx, uint32_t opc,
>          }
>          break;
>      case NM_SHRL_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          tcg_gen_movi_tl(t0, rd >> 1);
>          gen_helper_shrl_ph(t0, t0, rs_t);
>          gen_store_gpr(t0, rt);
> @@ -19079,19 +19079,19 @@ static void gen_pool32a5_nanomips_insn(DisasCon=
text *ctx, int opc,
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_CMPGDU_EQ_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
>          tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_CMPGDU_LT_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
>          tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_CMPGDU_LE_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
>          tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
>          gen_store_gpr(v1_t, ret);
> @@ -19147,7 +19147,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_ADDQH_R_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* ADDQH_PH */
> @@ -19162,7 +19162,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_ADDQH_R_W:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* ADDQH_W */
> @@ -19192,7 +19192,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_ADDU_S_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* ADDU_PH */
> @@ -19207,7 +19207,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_ADDUH_R_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* ADDUH_QB */
> @@ -19237,7 +19237,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_SHRAV_R_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* SHRAV_QB */
> @@ -19267,7 +19267,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_SUBQH_R_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* SUBQH_PH */
> @@ -19282,7 +19282,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_SUBQH_R_W:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* SUBQH_W */
> @@ -19312,7 +19312,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_SUBU_S_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* SUBU_PH */
> @@ -19327,7 +19327,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_SUBUH_R_QB:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* SUBUH_QB */
> @@ -19357,7 +19357,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_PRECR_SRA_R_PH_W:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* PRECR_SRA_PH_W */
> @@ -19397,22 +19397,22 @@ static void gen_pool32a5_nanomips_insn(DisasCon=
text *ctx, int opc,
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_MULQ_S_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_mulq_s_ph(v1_t, v1_t, v2_t, cpu_env);
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_MULQ_RS_W:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_mulq_rs_w(v1_t, v1_t, v2_t, cpu_env);
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_MULQ_S_W:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_mulq_s_w(v1_t, v1_t, v2_t, cpu_env);
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_APPEND:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_load_gpr(t0, rs);
>          if (rd !=3D 0) {
>              tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd=
);
> @@ -19430,7 +19430,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_SHRLV_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_shrl_ph(v1_t, v1_t, v2_t);
>          gen_store_gpr(v1_t, ret);
>          break;
> @@ -19472,7 +19472,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          gen_store_gpr(v1_t, ret);
>          break;
>      case NM_MUL_S_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (extract32(ctx->opcode, 10, 1)) {
>          case 0:
>              /* MUL_PH */
> @@ -19487,7 +19487,7 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int opc,
>          }
>          break;
>      case NM_PRECR_QB_PH:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          gen_helper_precr_qb_ph(v1_t, v1_t, v2_t);
>          gen_store_gpr(v1_t, ret);
>          break;
> @@ -20296,7 +20296,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState=
 *env, DisasContext *ctx)
>                      gen_compute_branch_cp1_nm(ctx, OPC_BC1NEZ, rt, s);
>                      break;
>                  case NM_BPOSGE32C:
> -                    check_dspr3(ctx);
> +                    check_dsp_r3(ctx);
>                      {
>                          int32_t imm =3D extract32(ctx->opcode, 1, 13) |
>                                        extract32(ctx->opcode, 0, 1) << 13=
;
> @@ -20805,7 +20805,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>      switch (op1) {
>      /* OPC_MULT_G_2E is equal OPC_ADDUH_QB_DSP */
>      case OPC_MULT_G_2E:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (op2) {
>          case OPC_ADDUH_QB:
>              gen_helper_adduh_qb(cpu_gpr[ret], v1_t, v2_t);
> @@ -20848,7 +20848,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>      case OPC_ABSQ_S_PH_DSP:
>          switch (op2) {
>          case OPC_ABSQ_S_QB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_absq_s_qb(cpu_gpr[ret], v2_t, cpu_env);
>              break;
>          case OPC_ABSQ_S_PH:
> @@ -20927,11 +20927,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx=
, uint32_t op1, uint32_t op2,
>              gen_helper_addu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDU_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_addu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDU_S_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_addu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBQ_PH:
> @@ -20955,11 +20955,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx=
, uint32_t op1, uint32_t op2,
>              gen_helper_subu_s_qb(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBU_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subu_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBU_S_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subu_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDSC:
> @@ -20983,7 +20983,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>      case OPC_CMPU_EQ_QB_DSP:
>          switch (op2) {
>          case OPC_PRECR_QB_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_precr_qb_ph(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_PRECRQ_QB_PH:
> @@ -20991,7 +20991,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>              gen_helper_precrq_qb_ph(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_PRECR_SRA_PH_W:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              {
>                  TCGv_i32 sa_t =3D tcg_const_i32(v2);
>                  gen_helper_precr_sra_ph_w(cpu_gpr[ret], sa_t, v1_t,
> @@ -21000,7 +21000,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>                  break;
>              }
>          case OPC_PRECR_SRA_R_PH_W:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              {
>                  TCGv_i32 sa_t =3D tcg_const_i32(v2);
>                  gen_helper_precr_sra_r_ph_w(cpu_gpr[ret], sa_t, v1_t,
> @@ -21082,7 +21082,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>              gen_helper_preceu_qh_obra(cpu_gpr[ret], v2_t);
>              break;
>          case OPC_ABSQ_S_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_absq_s_ob(cpu_gpr[ret], v2_t, cpu_env);
>              break;
>          case OPC_ABSQ_S_PW:
> @@ -21126,19 +21126,19 @@ static void gen_mipsdsp_arith(DisasContext *ctx=
, uint32_t op1, uint32_t op2,
>              gen_helper_subu_s_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBU_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subu_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBU_S_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subu_s_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_SUBUH_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subuh_ob(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_SUBUH_R_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_subuh_r_ob(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_ADDQ_PW:
> @@ -21166,19 +21166,19 @@ static void gen_mipsdsp_arith(DisasContext *ctx=
, uint32_t op1, uint32_t op2,
>              gen_helper_addu_s_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDU_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_addu_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDU_S_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_addu_s_qh(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_ADDUH_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_adduh_ob(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_ADDUH_R_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_adduh_r_ob(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          }
> @@ -21186,11 +21186,11 @@ static void gen_mipsdsp_arith(DisasContext *ctx=
, uint32_t op1, uint32_t op2,
>      case OPC_CMPU_EQ_OB_DSP:
>          switch (op2) {
>          case OPC_PRECR_OB_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_precr_ob_qh(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_PRECR_SRA_QH_PW:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              {
>                  TCGv_i32 ret_t =3D tcg_const_i32(ret);
>                  gen_helper_precr_sra_qh_pw(v2_t, v1_t, v2_t, ret_t);
> @@ -21198,7 +21198,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, =
uint32_t op1, uint32_t op2,
>                  break;
>              }
>          case OPC_PRECR_SRA_R_QH_PW:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              {
>                  TCGv_i32 sa_v =3D tcg_const_i32(ret);
>                  gen_helper_precr_sra_r_qh_pw(v2_t, v1_t, v2_t, sa_v);
> @@ -21301,27 +21301,27 @@ static void gen_mipsdsp_shift(DisasContext *ctx=
, uint32_t opc,
>                  gen_helper_shrl_qb(cpu_gpr[ret], v1_t, v2_t);
>                  break;
>              case OPC_SHRL_PH:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shrl_ph(cpu_gpr[ret], t0, v2_t);
>                  break;
>              case OPC_SHRLV_PH:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shrl_ph(cpu_gpr[ret], v1_t, v2_t);
>                  break;
>              case OPC_SHRA_QB:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shra_qb(cpu_gpr[ret], t0, v2_t);
>                  break;
>              case OPC_SHRA_R_QB:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shra_r_qb(cpu_gpr[ret], t0, v2_t);
>                  break;
>              case OPC_SHRAV_QB:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shra_qb(cpu_gpr[ret], v1_t, v2_t);
>                  break;
>              case OPC_SHRAV_R_QB:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_shra_r_qb(cpu_gpr[ret], v1_t, v2_t);
>                  break;
>              case OPC_SHRA_PH:
> @@ -21400,19 +21400,19 @@ static void gen_mipsdsp_shift(DisasContext *ctx=
, uint32_t opc,
>              gen_helper_shll_s_qh(cpu_gpr[ret], v2_t, v1_t, cpu_env);
>              break;
>          case OPC_SHRA_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shra_ob(cpu_gpr[ret], v2_t, t0);
>              break;
>          case OPC_SHRAV_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shra_ob(cpu_gpr[ret], v2_t, v1_t);
>              break;
>          case OPC_SHRA_R_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shra_r_ob(cpu_gpr[ret], v2_t, t0);
>              break;
>          case OPC_SHRAV_R_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shra_r_ob(cpu_gpr[ret], v2_t, v1_t);
>              break;
>          case OPC_SHRA_PW:
> @@ -21456,11 +21456,11 @@ static void gen_mipsdsp_shift(DisasContext *ctx=
, uint32_t opc,
>              gen_helper_shrl_ob(cpu_gpr[ret], v2_t, v1_t);
>              break;
>          case OPC_SHRL_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shrl_qh(cpu_gpr[ret], v2_t, t0);
>              break;
>          case OPC_SHRLV_QH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_shrl_qh(cpu_gpr[ret], v2_t, v1_t);
>              break;
>          default:            /* Invalid */
> @@ -21501,7 +21501,7 @@ static void gen_mipsdsp_multiply(DisasContext *ct=
x, uint32_t op1, uint32_t op2,
>      /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
>       * the same mask and op1. */
>      case OPC_MULT_G_2E:
> -        check_dspr2(ctx);
> +        check_dsp_r2(ctx);
>          switch (op2) {
>          case  OPC_MUL_PH:
>              gen_helper_mul_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
> @@ -21536,11 +21536,11 @@ static void gen_mipsdsp_multiply(DisasContext *=
ctx, uint32_t op1, uint32_t op2,
>              gen_helper_dpsu_h_qbr(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpa_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPAX_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpax_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPAQ_S_W_PH:
> @@ -21548,19 +21548,19 @@ static void gen_mipsdsp_multiply(DisasContext *=
ctx, uint32_t op1, uint32_t op2,
>              gen_helper_dpaq_s_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPAQX_S_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpaqx_s_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPAQX_SA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpaqx_sa_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPS_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dps_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPSX_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsx_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPSQ_S_W_PH:
> @@ -21568,11 +21568,11 @@ static void gen_mipsdsp_multiply(DisasContext *=
ctx, uint32_t op1, uint32_t op2,
>              gen_helper_dpsq_s_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPSQX_S_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsqx_s_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_DPSQX_SA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_dpsqx_sa_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_MULSAQ_S_W_PH:
> @@ -21604,7 +21604,7 @@ static void gen_mipsdsp_multiply(DisasContext *ct=
x, uint32_t op1, uint32_t op2,
>              gen_helper_maq_sa_w_phr(t0, v1_t, v2_t, cpu_env);
>              break;
>          case OPC_MULSA_W_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_mulsa_w_ph(t0, v1_t, v2_t, cpu_env);
>              break;
>          }
> @@ -21633,7 +21633,7 @@ static void gen_mipsdsp_multiply(DisasContext *ct=
x, uint32_t op1, uint32_t op2,
>                  gen_helper_dmsubu(v1_t, v2_t, t0, cpu_env);
>                  break;
>              case OPC_DPA_W_QH:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_dpa_w_qh(v1_t, v2_t, t0, cpu_env);
>                  break;
>              case OPC_DPAQ_S_W_QH:
> @@ -21653,7 +21653,7 @@ static void gen_mipsdsp_multiply(DisasContext *ct=
x, uint32_t op1, uint32_t op2,
>                  gen_helper_dpau_h_obr(v1_t, v2_t, t0, cpu_env);
>                  break;
>              case OPC_DPS_W_QH:
> -                check_dspr2(ctx);
> +                check_dsp_r2(ctx);
>                  gen_helper_dps_w_qh(v1_t, v2_t, t0, cpu_env);
>                  break;
>              case OPC_DPSQ_S_W_QH:
> @@ -21747,7 +21747,7 @@ static void gen_mipsdsp_multiply(DisasContext *ct=
x, uint32_t op1, uint32_t op2,
>              gen_helper_muleq_s_w_phr(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_MULQ_S_PH:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_mulq_s_ph(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          }
> @@ -21971,7 +21971,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext=
 *ctx,
>              gen_helper_cmpgu_le_qb(cpu_gpr[ret], v1_t, v2_t);
>              break;
>          case OPC_CMPGDU_EQ_QB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgu_eq_qb(t1, v1_t, v2_t);
>              tcg_gen_mov_tl(cpu_gpr[ret], t1);
>              tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
> @@ -21979,7 +21979,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext=
 *ctx,
>              tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
>              break;
>          case OPC_CMPGDU_LT_QB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgu_lt_qb(t1, v1_t, v2_t);
>              tcg_gen_mov_tl(cpu_gpr[ret], t1);
>              tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
> @@ -21987,7 +21987,7 @@ static void gen_mipsdsp_add_cmp_pick(DisasContext=
 *ctx,
>              tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);
>              break;
>          case OPC_CMPGDU_LE_QB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgu_le_qb(t1, v1_t, v2_t);
>              tcg_gen_mov_tl(cpu_gpr[ret], t1);
>              tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
> @@ -22048,15 +22048,15 @@ static void gen_mipsdsp_add_cmp_pick(DisasConte=
xt *ctx,
>              gen_helper_cmp_le_qh(v1_t, v2_t, cpu_env);
>              break;
>          case OPC_CMPGDU_EQ_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgdu_eq_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_CMPGDU_LT_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgdu_lt_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_CMPGDU_LE_OB:
> -            check_dspr2(ctx);
> +            check_dsp_r2(ctx);
>              gen_helper_cmpgdu_le_ob(cpu_gpr[ret], v1_t, v2_t, cpu_env);
>              break;
>          case OPC_CMPGU_EQ_OB:
> @@ -22114,7 +22114,7 @@ static void gen_mipsdsp_append(CPUMIPSState *env,=
 DisasContext *ctx,
>  {
>      TCGv t0;
>
> -    check_dspr2(ctx);
> +    check_dsp_r2(ctx);
>
>      if (rt =3D=3D 0) {
>          /* Treat as NOP. */
> @@ -22999,7 +22999,7 @@ static void decode_opc_special3_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
>      case OPC_MULTU_G_2E:
>          /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
>           * the same mask and op1. */
> -        if ((ctx->insn_flags & ASE_DSPR2) && (op1 =3D=3D OPC_MULT_G_2E))=
 {
> +        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 =3D=3D OPC_MULT_G_2E)=
) {
>              op2 =3D MASK_ADDUH_QB(ctx->opcode);
>              switch (op2) {
>              case OPC_ADDUH_QB:
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
> index d7cd4ee..acab097 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -320,7 +320,7 @@ const mips_def_t mips_defs[] =3D
>          .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
>          .SEGBITS =3D 32,
>          .PABITS =3D 32,
> -        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSPR2,
> +        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_DSP_R2=
,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>      {
> @@ -485,7 +485,7 @@ const mips_def_t mips_defs[] =3D
>          .CP1_fcr31 =3D (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
>          .SEGBITS =3D 32,
>          .PABITS =3D 32,
> -        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_DSPR3=
 |
> +        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP | ASE_DSP_R2 | ASE_DSP_=
R3 |
>                        ASE_MT,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
> @@ -762,7 +762,7 @@ const mips_def_t mips_defs[] =3D
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>      {
> -        /* A generic CPU providing MIPS64 ASE DSP 2 features.
> +        /* A generic CPU providing MIPS64 DSP R2 ASE features.
>             FIXME: Eventually this should be replaced by a real CPU model=
. */
>          .name =3D "mips64dspr2",
>          .CP0_PRid =3D 0x00010000,
> @@ -787,7 +787,7 @@ const mips_def_t mips_defs[] =3D
>          .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
>          .SEGBITS =3D 42,
>          .PABITS =3D 36,
> -        .insn_flags =3D CPU_MIPS64R2 | ASE_DSP | ASE_DSPR2,
> +        .insn_flags =3D CPU_MIPS64R2 | ASE_DSP | ASE_DSP_R2,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>
> --
> 2.7.4
>
>
