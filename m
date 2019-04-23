Received: from eggs.gnu.org ([209.51.188.92]:36494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdc-0001eN-CR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0005YT-Gn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45024 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItda-0005WV-4c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 13:29:42 +0200
Message-Id: <1556018982-3715-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 8/8] target/mips: Fix if-else arms checkpatch
 errors in translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove if-else-arms-related checkpatch errors.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 112 ++++++++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fb4ff0b..35007eb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2618,16 +2618,18 @@ static const char * const mxuregnames[] = {
 /* General purpose registers moves. */
 static inline void gen_load_gpr(TCGv t, int reg)
 {
-    if (reg == 0)
+    if (reg == 0) {
         tcg_gen_movi_tl(t, 0);
-    else
+    } else {
         tcg_gen_mov_tl(t, cpu_gpr[reg]);
+    }
 }
 
 static inline void gen_store_gpr(TCGv t, int reg)
 {
-    if (reg != 0)
+    if (reg != 0) {
         tcg_gen_mov_tl(cpu_gpr[reg], t);
+    }
 }
 
 /* Moves to/from shadow registers. */
@@ -2635,9 +2637,9 @@ static inline void gen_load_srsgpr(int from, int to)
 {
     TCGv t0 = tcg_temp_new();
 
-    if (from == 0)
+    if (from == 0) {
         tcg_gen_movi_tl(t0, 0);
-    else {
+    } else {
         TCGv_i32 t2 = tcg_temp_new_i32();
         TCGv_ptr addr = tcg_temp_new_ptr();
 
@@ -2840,10 +2842,11 @@ static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 
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
 
 /* Addresses computation */
@@ -2907,14 +2910,16 @@ static inline void gen_move_high32(TCGv ret, TCGv_i64 arg)
 
 static inline void check_cp0_enabled(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_CP0))) {
         generate_exception_err(ctx, EXCP_CpU, 0);
+    }
 }
 
 static inline void check_cp1_enabled(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_FPU)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_FPU))) {
         generate_exception_err(ctx, EXCP_CpU, 1);
+    }
 }
 
 /* Verify that the processor is running with COP1X instructions enabled.
@@ -2923,8 +2928,9 @@ static inline void check_cp1_enabled(DisasContext *ctx)
 
 static inline void check_cop1x(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
 
 /* Verify that the processor is running with 64-bit floating-point
@@ -2932,8 +2938,9 @@ static inline void check_cop1x(DisasContext *ctx)
 
 static inline void check_cp1_64bitmode(DisasContext *ctx)
 {
-    if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X)))
+    if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
 
 /*
@@ -2949,8 +2956,9 @@ static inline void check_cp1_64bitmode(DisasContext *ctx)
  */
 static inline void check_cp1_registers(DisasContext *ctx, int regs)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_F64) && (regs & 1)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_F64) && (regs & 1))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
 
 /* Verify that the processor is running with DSP instructions enabled.
@@ -3039,8 +3047,9 @@ static inline void check_ps(DisasContext *ctx)
    instructions are not enabled. */
 static inline void check_mips_64(DisasContext *ctx)
 {
-    if (unlikely(!(ctx->hflags & MIPS_HFLAG_64)))
+    if (unlikely(!(ctx->hflags & MIPS_HFLAG_64))) {
         generate_exception_end(ctx, EXCP_RI);
+    }
 }
 #endif
 
@@ -3130,8 +3139,7 @@ static inline void check_nms_dl_il_sl_tl_l2c(DisasContext *ctx)
         !(ctx->CP0_Config1 & (1 << CP0C1_IL)) &&
         !(ctx->CP0_Config2 & (1 << CP0C2_SL)) &&
         !(ctx->CP0_Config2 & (1 << CP0C2_TL)) &&
-        !(ctx->CP0_Config5 & (1 << CP0C5_L2C)))
-    {
+        !(ctx->CP0_Config5 & (1 << CP0C5_L2C))) {
         generate_exception_end(ctx, EXCP_RI);
     }
 }
@@ -3881,22 +3889,25 @@ static void gen_logic_imm(DisasContext *ctx, uint32_t opc,
     uimm = (uint16_t)imm;
     switch (opc) {
     case OPC_ANDI:
-        if (likely(rs != 0))
+        if (likely(rs != 0)) {
             tcg_gen_andi_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], 0);
+        }
         break;
     case OPC_ORI:
-        if (rs != 0)
+        if (rs != 0) {
             tcg_gen_ori_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], uimm);
+        }
         break;
     case OPC_XORI:
-        if (likely(rs != 0))
+        if (likely(rs != 0)) {
             tcg_gen_xori_tl(cpu_gpr[rt], cpu_gpr[rs], uimm);
-        else
+        } else {
             tcg_gen_movi_tl(cpu_gpr[rt], uimm);
+        }
         break;
     case OPC_LUI:
         if (rs != 0 && (ctx->insn_flags & ISA_MIPS32R6)) {
@@ -6059,8 +6070,9 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
     }
 
  out:
-    if (insn_bytes == 2)
+    if (insn_bytes == 2) {
         ctx->hflags |= MIPS_HFLAG_B16;
+    }
     tcg_temp_free(t0);
     tcg_temp_free(t1);
 }
@@ -6707,8 +6719,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
 
-    if (sel != 0)
+    if (sel != 0) {
         check_insn(ctx, ISA_MIPS32);
+    }
 
     switch (reg) {
     case CP0_REGISTER_00:
@@ -7463,8 +7476,9 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
 
-    if (sel != 0)
+    if (sel != 0) {
         check_insn(ctx, ISA_MIPS32);
+    }
 
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -8209,8 +8223,9 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
 
-    if (sel != 0)
+    if (sel != 0) {
         check_insn(ctx, ISA_MIPS64);
+    }
 
     switch (reg) {
     case CP0_REGISTER_00:
@@ -8919,8 +8934,9 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
 
-    if (sel != 0)
+    if (sel != 0) {
         check_insn(ctx, ISA_MIPS64);
+    }
 
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -10161,8 +10177,9 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         break;
     case OPC_TLBWI:
         opn = "tlbwi";
-        if (!env->tlb->helper_tlbwi)
+        if (!env->tlb->helper_tlbwi) {
             goto die;
+        }
         gen_helper_tlbwi(cpu_env);
         break;
     case OPC_TLBINV:
@@ -10185,20 +10202,23 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         break;
     case OPC_TLBWR:
         opn = "tlbwr";
-        if (!env->tlb->helper_tlbwr)
+        if (!env->tlb->helper_tlbwr) {
             goto die;
+        }
         gen_helper_tlbwr(cpu_env);
         break;
     case OPC_TLBP:
         opn = "tlbp";
-        if (!env->tlb->helper_tlbp)
+        if (!env->tlb->helper_tlbp) {
             goto die;
+        }
         gen_helper_tlbp(cpu_env);
         break;
     case OPC_TLBR:
         opn = "tlbr";
-        if (!env->tlb->helper_tlbr)
+        if (!env->tlb->helper_tlbr) {
             goto die;
+        }
         gen_helper_tlbr(cpu_env);
         break;
     case OPC_ERET: /* OPC_ERETNC */
@@ -10272,8 +10292,9 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         goto out;
     }
 
-    if (cc != 0)
+    if (cc != 0) {
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
+    }
 
     btarget = ctx->base.pc_next + 4 + offset;
 
@@ -10727,10 +10748,11 @@ static void gen_movci(DisasContext *ctx, int rd, int rs, int cc, int tf)
         return;
     }
 
-    if (tf)
+    if (tf) {
         cond = TCG_COND_EQ;
-    else
+    } else {
         cond = TCG_COND_NE;
+    }
 
     l1 = gen_new_label();
     t0 = tcg_temp_new_i32();
@@ -10752,10 +10774,11 @@ static inline void gen_movcf_s(DisasContext *ctx, int fs, int fd, int cc,
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGLabel *l1 = gen_new_label();
 
-    if (tf)
+    if (tf) {
         cond = TCG_COND_EQ;
-    else
+    } else {
         cond = TCG_COND_NE;
+    }
 
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -10773,10 +10796,11 @@ static inline void gen_movcf_d(DisasContext *ctx, int fs, int fd, int cc,
     TCGv_i64 fp0;
     TCGLabel *l1 = gen_new_label();
 
-    if (tf)
+    if (tf) {
         cond = TCG_COND_EQ;
-    else
+    } else {
         cond = TCG_COND_NE;
+    }
 
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -10796,10 +10820,11 @@ static inline void gen_movcf_ps(DisasContext *ctx, int fs, int fd,
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
 
-    if (tf)
+    if (tf) {
         cond = TCG_COND_EQ;
-    else
+    } else {
         cond = TCG_COND_NE;
+    }
 
     tcg_gen_andi_i32(t0, fpu_fcr31, 1 << get_fp_bit(cc));
     tcg_gen_brcondi_i32(cond, t0, 0, l1);
@@ -12095,8 +12120,9 @@ static void gen_farith(DisasContext *ctx, enum fopcode op1,
             TCGLabel *l1 = gen_new_label();
             TCGv_i64 fp0;
 
-            if (ft != 0)
+            if (ft != 0) {
                 tcg_gen_brcondi_tl(TCG_COND_NE, cpu_gpr[ft], 0, l1);
+            }
             fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
             gen_store_fpr64(ctx, fp0, fd);
@@ -29837,11 +29863,13 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                 env->active_tc.PC, env->active_tc.HI[0], env->active_tc.LO[0],
                 env->hflags, env->btarget, env->bcond);
     for (i = 0; i < 32; i++) {
-        if ((i & 3) == 0)
+        if ((i & 3) == 0) {
             cpu_fprintf(f, "GPR%02d:", i);
+        }
         cpu_fprintf(f, " %s " TARGET_FMT_lx, regnames[i], env->active_tc.gpr[i]);
-        if ((i & 3) == 3)
+        if ((i & 3) == 3) {
             cpu_fprintf(f, "\n");
+        }
     }
 
     cpu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x" TARGET_FMT_lx "\n",
-- 
2.7.4
