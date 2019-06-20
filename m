Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B0C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5620C20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxY2-0004ou-J9
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:56:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdxLE-000200-C9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hdxBy-0004qz-Mc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:35:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45635 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hdxBy-0004qK-2I
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:33:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5044A1A44E8;
 Thu, 20 Jun 2019 15:33:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1B4861A476F;
 Thu, 20 Jun 2019 15:33:27 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 15:33:15 +0200
Message-Id: <1561037595-14413-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561037595-14413-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561037595-14413-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 4/4] target/mips: Fix if-else-switch-case
 arms checkpatch errors in translate.c
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove if-else-switch-case-arms-related checkpatch errors.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/mips/translate.c | 205 +++++++++++++++++++++++++++++++-----------=
------
 1 file changed, 133 insertions(+), 72 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 54e0160..e3a0f08 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2619,16 +2619,18 @@ static const char * const mxuregnames[] =3D {
 /* General purpose registers moves. */
 static inline void gen_load_gpr(TCGv t, int reg)
 {
-    if (reg =3D=3D 0)
+    if (reg =3D=3D 0) {
         tcg_gen_movi_tl(t, 0);
-    else
+    } else {
         tcg_gen_mov_tl(t, cpu_gpr[reg]);
+    }
 }
=20
 static inline void gen_store_gpr(TCGv t, int reg)
 {
-    if (reg !=3D 0)
+    if (reg !=3D 0) {
         tcg_gen_mov_tl(cpu_gpr[reg], t);
+    }
 }
=20
 /* Moves to/from shadow registers. */
@@ -2636,9 +2638,9 @@ static inline void gen_load_srsgpr(int from, int to=
)
 {
     TCGv t0 =3D tcg_temp_new();
=20
-    if (from =3D=3D 0)
+    if (from =3D=3D 0) {
         tcg_gen_movi_tl(t0, 0);
-    else {
+    } else {
         TCGv_i32 t2 =3D tcg_temp_new_i32();
         TCGv_ptr addr =3D tcg_temp_new_ptr();
=20
@@ -2841,10 +2843,11 @@ static void gen_store_fpr64(DisasContext *ctx, TC=
Gv_i64 t, int reg)
=20
 static inline int get_fp_bit(int cc)
 {
-    if (cc)
+    if (cc) {
         return 24 + cc;
-    else
+    } else {
         return 23;
+    }
 }
=20
 /* Addresses computation */
@@ -2908,14 +2911,16 @@ static inline void gen_move_high32(TCGv ret, TCGv=
_i64 arg)
=20
 static inline void check_cp0_enabled(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0))) {
         generate_exception_err(ctx, EXCP_CpU, 0);
+    }
 }
=20
 static inline void check_cp1_enabled(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_FPU)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_FPU))) {
         generate_exception_err(ctx, EXCP_CpU, 1);
+    }
 }
=20
 /* Verify that the processor is running with COP1X instructions enabled.
@@ -2924,8 +2929,9 @@ static inline void check_cp1_enabled(DisasContext *=
ctx)
=20
 static inline void check_cop1x(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
=20
 /* Verify that the processor is running with 64-bit floating-point
@@ -2933,8 +2939,9 @@ static inline void check_cop1x(DisasContext *ctx)
=20
 static inline void check_cp1_64bitmode(DisasContext *ctx)
 {
-    if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X)))
+    if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
=20
 /*
@@ -2950,8 +2957,9 @@ static inline void check_cp1_64bitmode(DisasContext=
 *ctx)
  */
 static inline void check_cp1_registers(DisasContext *ctx, int regs)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_F64) && (regs & 1)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_F64) && (regs & 1))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
=20
 /* Verify that the processor is running with DSP instructions enabled.
@@ -3040,8 +3048,9 @@ static inline void check_ps(DisasContext *ctx)
    instructions are not enabled. */
 static inline void check_mips_64(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_64)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_64))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
 #endif
=20
@@ -3126,13 +3135,12 @@ static inline void check_nms(DisasContext *ctx)
  */
 static inline void check_nms_dl_il_sl_tl_l2c(DisasContext *ctx)
 {
-    if (unlikely(ctx->CP0_Config5 & (1 << CP0C5_NMS)) &&
-        !(ctx->CP0_Config1 & (1 << CP0C1_DL)) &&
-        !(ctx->CP0_Config1 & (1 << CP0C1_IL)) &&
-        !(ctx->CP0_Config2 & (1 << CP0C2_SL)) &&
-        !(ctx->CP0_Config2 & (1 << CP0C2_TL)) &&
-        !(ctx->CP0_Config5 & (1 << CP0C5_L2C)))
-    {
+    if (unlikely((ctx->CP0_Config5 & (1 << CP0C5_NMS)) &&
+                 !(ctx->CP0_Config1 & (1 << CP0C1_DL)) &&
+                 !(ctx->CP0_Config1 & (1 << CP0C1_IL)) &&
+                 !(ctx->CP0_Config2 & (1 << CP0C2_SL)) &&
+                 !(ctx->CP0_Config2 & (1 << CP0C2_TL)) &&
+                 !(ctx->CP0_Config5 & (1 << CP0C5_L2C)))) {
         generate_exception_end(ctx, EXCP_RI);
     }
 }
@@ -3180,23 +3188,56 @@ static inline void gen_cmp ## type ## _ ## fmt(Di=
sasContext *ctx, int n,      \
     gen_ldcmp_fpr##bits (ctx, fp0, fs);                                 =
      \
     gen_ldcmp_fpr##bits (ctx, fp1, ft);                                 =
      \
     switch (n) {                                                        =
      \
-    case  0: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _f, fp0, fp1, cc=
);    break;\
-    case  1: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _un, fp0, fp1, c=
c);   break;\
-    case  2: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _eq, fp0, fp1, c=
c);   break;\
-    case  3: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ueq, fp0, fp1, =
cc);  break;\
-    case  4: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _olt, fp0, fp1, =
cc);  break;\
-    case  5: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ult, fp0, fp1, =
cc);  break;\
-    case  6: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ole, fp0, fp1, =
cc);  break;\
-    case  7: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ule, fp0, fp1, =
cc);  break;\
-    case  8: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _sf, fp0, fp1, c=
c);   break;\
-    case  9: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngle, fp0, fp1,=
 cc); break;\
-    case 10: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _seq, fp0, fp1, =
cc);  break;\
-    case 11: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngl, fp0, fp1, =
cc);  break;\
-    case 12: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _lt, fp0, fp1, c=
c);   break;\
-    case 13: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _nge, fp0, fp1, =
cc);  break;\
-    case 14: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _le, fp0, fp1, c=
c);   break;\
-    case 15: gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngt, fp0, fp1, =
cc);  break;\
-    default: abort();                                                   =
      \
+    case  0:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _f, fp0, fp1, cc);   =
      \
+    break;                                                              =
      \
+    case  1:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _un, fp0, fp1, cc);  =
      \
+    break;                                                              =
      \
+    case  2:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _eq, fp0, fp1, cc);  =
      \
+    break;                                                              =
      \
+    case  3:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ueq, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case  4:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _olt, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case  5:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ult, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case  6:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ole, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case  7:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ule, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case  8:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _sf, fp0, fp1, cc);  =
      \
+    break;                                                              =
      \
+    case  9:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngle, fp0, fp1, cc);=
      \
+    break;                                                              =
      \
+    case 10:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _seq, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case 11:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngl, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case 12:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _lt, fp0, fp1, cc);  =
      \
+    break;                                                              =
      \
+    case 13:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _nge, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    case 14:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _le, fp0, fp1, cc);  =
      \
+    break;                                                              =
      \
+    case 15:                                                            =
      \
+        gen_helper_0e2i(cmp ## type ## _ ## fmt ## _ngt, fp0, fp1, cc); =
      \
+    break;                                                              =
      \
+    default:                                                            =
      \
+        abort();                                                        =
      \
     }                                                                   =
      \
     tcg_temp_free_i##bits (fp0);                                        =
      \
     tcg_temp_free_i##bits (fp1);                                        =
      \
@@ -3882,22 +3923,25 @@ static void gen_logic_imm(DisasContext *ctx, uint=
32_t opc,
     uimm =3D (uint16_t)imm;
     switch (opc) {
     case OPC_ANDI:
-        if (likely(rs !=3D 0))
+        if (likely(rs !=3D 0)) {
             tcg_gen_andi_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], 0);
+        }
         break;
     case OPC_ORI:
-        if (rs !=3D 0)
+        if (rs !=3D 0) {
             tcg_gen_ori_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], uimm);
+        }
         break;
     case OPC_XORI:
-        if (likely(rs !=3D 0))
+        if (likely(rs !=3D 0)) {
             tcg_gen_xori_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], uimm);
+        }
         break;
     case OPC_LUI:
         if (rs !=3D 0 && (ctx->insn_flags & ISA_MIPS32R6)) {
@@ -6060,8 +6104,9 @@ static void gen_compute_branch (DisasContext *ctx, =
uint32_t opc,
     }
=20
  out:
-    if (insn_bytes =3D=3D 2)
+    if (insn_bytes =3D=3D 2) {
         ctx->hflags |=3D MIPS_HFLAG_B16;
+    }
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
@@ -6708,8 +6753,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
 {
     const char *register_name =3D "invalid";
=20
-    if (sel !=3D 0)
+    if (sel !=3D 0) {
         check_insn(ctx, ISA_MIPS32);
+    }
=20
     switch (reg) {
     case CP0_REGISTER_00:
@@ -7464,8 +7510,9 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
 {
     const char *register_name =3D "invalid";
=20
-    if (sel !=3D 0)
+    if (sel !=3D 0) {
         check_insn(ctx, ISA_MIPS32);
+    }
=20
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -8210,8 +8257,9 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
 {
     const char *register_name =3D "invalid";
=20
-    if (sel !=3D 0)
+    if (sel !=3D 0) {
         check_insn(ctx, ISA_MIPS64);
+    }
=20
     switch (reg) {
     case CP0_REGISTER_00:
@@ -8920,8 +8968,9 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
 {
     const char *register_name =3D "invalid";
=20
-    if (sel !=3D 0)
+    if (sel !=3D 0) {
         check_insn(ctx, ISA_MIPS64);
+    }
=20
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -9658,12 +9707,12 @@ static void gen_mftr(CPUMIPSState *env, DisasCont=
ext *ctx, int rt, int rd,
=20
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) =3D=3D 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=3D
-         (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE))))
+         (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
         tcg_gen_movi_tl(t0, -1);
-    else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
-             (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC)))
+    } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
+               (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         tcg_gen_movi_tl(t0, -1);
-    else if (u =3D=3D 0) {
+    } else if (u =3D=3D 0) {
         switch (rt) {
         case 1:
             switch (sel) {
@@ -9883,12 +9932,12 @@ static void gen_mttr(CPUMIPSState *env, DisasCont=
ext *ctx, int rd, int rt,
     gen_load_gpr(t0, rt);
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) =3D=3D 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=3D
-         (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE))))
+         (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
         /* NOP */ ;
-    else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
-             (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC)))
+    } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
+             (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
         /* NOP */ ;
-    else if (u =3D=3D 0) {
+    } else if (u =3D=3D 0) {
         switch (rd) {
         case 1:
             switch (sel) {
@@ -10162,8 +10211,9 @@ static void gen_cp0(CPUMIPSState *env, DisasConte=
xt *ctx, uint32_t opc,
         break;
     case OPC_TLBWI:
         opn =3D "tlbwi";
-        if (!env->tlb->helper_tlbwi)
+        if (!env->tlb->helper_tlbwi) {
             goto die;
+        }
         gen_helper_tlbwi(cpu_env);
         break;
     case OPC_TLBINV:
@@ -10186,20 +10236,23 @@ static void gen_cp0(CPUMIPSState *env, DisasCon=
text *ctx, uint32_t opc,
         break;
     case OPC_TLBWR:
         opn =3D "tlbwr";
-        if (!env->tlb->helper_tlbwr)
+        if (!env->tlb->helper_tlbwr) {
             goto die;
+        }
         gen_helper_tlbwr(cpu_env);
         break;
     case OPC_TLBP:
         opn =3D "tlbp";
-        if (!env->tlb->helper_tlbp)
+        if (!env->tlb->helper_tlbp) {
             goto die;
+        }
         gen_helper_tlbp(cpu_env);
         break;
     case OPC_TLBR:
         opn =3D "tlbr";
-        if (!env->tlb->helper_tlbr)
+        if (!env->tlb->helper_tlbr) {
             goto die;
+        }
         gen_helper_tlbr(cpu_env);
         break;
     case OPC_ERET: /* OPC_ERETNC */
@@ -10273,8 +10326,9 @@ static void gen_compute_branch1(DisasContext *ctx=
, uint32_t op,
         goto out;
     }
=20
-    if (cc !=3D 0)
+    if (cc !=3D 0) {
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
+    }
=20
     btarget =3D ctx->base.pc_next + 4 + offset;
=20
@@ -10728,10 +10782,11 @@ static void gen_movci(DisasContext *ctx, int rd=
, int rs, int cc, int tf)
         return;
     }
=20
-    if (tf)
+    if (tf) {
         cond =3D TCG_COND_EQ;
-    else
+    } else {
         cond =3D TCG_COND_NE;
+    }
=20
     l1 =3D gen_new_label();
     t0 =3D tcg_temp_new_i32();
@@ -10753,10 +10808,11 @@ static inline void gen_movcf_s(DisasContext *ct=
x, int fs, int fd, int cc,
     TCGv_i32 t0 =3D tcg_temp_new_i32();
     TCGLabel *l1 =3D gen_new_label();
=20
-    if (tf)
+    if (tf) {
         cond =3D TCG_COND_EQ;
-    else
+    } else {
         cond =3D TCG_COND_NE;
+    }
=20
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -10774,10 +10830,11 @@ static inline void gen_movcf_d(DisasContext *ct=
x, int fs, int fd, int cc,
     TCGv_i64 fp0;
     TCGLabel *l1 =3D gen_new_label();
=20
-    if (tf)
+    if (tf) {
         cond =3D TCG_COND_EQ;
-    else
+    } else {
         cond =3D TCG_COND_NE;
+    }
=20
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -10797,10 +10854,11 @@ static inline void gen_movcf_ps(DisasContext *c=
tx, int fs, int fd,
     TCGLabel *l1 =3D gen_new_label();
     TCGLabel *l2 =3D gen_new_label();
=20
-    if (tf)
+    if (tf) {
         cond =3D TCG_COND_EQ;
-    else
+    } else {
         cond =3D TCG_COND_NE;
+    }
=20
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -12096,8 +12154,9 @@ static void gen_farith(DisasContext *ctx, enum fo=
pcode op1,
             TCGLabel *l1 =3D gen_new_label();
             TCGv_i64 fp0;
=20
-            if (ft !=3D 0)
+            if (ft !=3D 0) {
                 tcg_gen_brcondi_tl(TCG_COND_NE, cpu_gpr[ft], 0, l1);
+            }
             fp0 =3D tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
             gen_store_fpr64(ctx, fp0, fd);
@@ -29991,12 +30050,14 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f,=
 int flags)
                  env->active_tc.PC, env->active_tc.HI[0], env->active_tc=
.LO[0],
                  env->hflags, env->btarget, env->bcond);
     for (i =3D 0; i < 32; i++) {
-        if ((i & 3) =3D=3D 0)
+        if ((i & 3) =3D=3D 0) {
             qemu_fprintf(f, "GPR%02d:", i);
+        }
         qemu_fprintf(f, " %s " TARGET_FMT_lx,
                      regnames[i], env->active_tc.gpr[i]);
-        if ((i & 3) =3D=3D 3)
+        if ((i & 3) =3D=3D 3) {
             qemu_fprintf(f, "\n");
+        }
     }
=20
     qemu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x" TARGET=
_FMT_lx "\n",
--=20
2.7.4


