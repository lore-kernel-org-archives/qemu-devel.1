Received: from eggs.gnu.org ([209.51.188.92]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVb-00040v-O6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVW-0007Zt-Kz
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:43 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52989 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXVM-00077G-Ly
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:33 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:36 +0100
Message-Id: <1547830785-7079-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 03/12] target/mips: Use preprocessor
 constants for 32 major CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Use preprocessor constants for 32 major CP0 registers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 272 ++++++++++++++++++++++++------------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 057aaf9..827d0f7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6570,7 +6570,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     const char *rn = "invalid";
 
     switch (reg) {
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6581,7 +6581,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6592,7 +6592,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
@@ -6608,7 +6608,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6638,7 +6638,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     uint64_t mask = ctx->PAMask >> 36;
 
     switch (reg) {
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6650,7 +6650,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6662,7 +6662,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             /* LLAddr is read-only (the only exception is bit 0 if LLB is
@@ -6680,7 +6680,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6720,7 +6720,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS32);
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -6750,7 +6750,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -6796,7 +6796,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             {
@@ -6854,7 +6854,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             {
@@ -6882,7 +6882,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -6904,7 +6904,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -6952,7 +6952,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -6992,7 +6992,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -7003,7 +7003,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -7030,7 +7030,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -7053,7 +7053,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -7064,7 +7064,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -7075,7 +7075,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -7100,7 +7100,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -7110,7 +7110,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7121,7 +7121,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -7144,7 +7144,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -7183,7 +7183,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mfc0_lladdr(arg, cpu_env);
@@ -7203,7 +7203,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7221,7 +7221,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -7239,7 +7239,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -7253,7 +7253,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -7265,11 +7265,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 22:
+    case CPO_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
         rn = "'Diagnostic"; /* implementation dependent */
         break;
-    case 23:
+    case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
@@ -7295,7 +7295,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7307,7 +7307,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -7345,7 +7345,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -7355,7 +7355,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -7368,7 +7368,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -7393,7 +7393,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -7413,7 +7413,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -7424,7 +7424,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7470,7 +7470,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -7500,7 +7500,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7547,7 +7547,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo0(cpu_env, arg);
@@ -7592,7 +7592,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo1(cpu_env, arg);
@@ -7607,7 +7607,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -7627,7 +7627,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -7673,7 +7673,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -7713,7 +7713,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -7725,7 +7725,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7747,7 +7747,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -7758,7 +7758,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -7768,7 +7768,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -7779,7 +7779,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7814,7 +7814,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7830,7 +7830,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7840,7 +7840,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7855,7 +7855,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -7904,7 +7904,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -7924,7 +7924,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7942,7 +7942,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -7960,7 +7960,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -7973,7 +7973,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -7985,11 +7985,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 22:
+    case CPO_REGISTER_22:
         /* ignored */
         rn = "Diagnostic"; /* implementation dependent */
         break;
-    case 23:
+    case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
@@ -8028,7 +8028,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8039,7 +8039,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -8077,7 +8077,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -8088,7 +8088,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -8101,7 +8101,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8121,7 +8121,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8142,7 +8142,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8152,7 +8152,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8202,7 +8202,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS64);
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -8232,7 +8232,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -8278,7 +8278,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
@@ -8323,7 +8323,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo1));
@@ -8338,7 +8338,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -8358,7 +8358,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -8403,7 +8403,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -8443,7 +8443,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -8454,7 +8454,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -8480,7 +8480,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -8503,7 +8503,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -8513,7 +8513,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -8524,7 +8524,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -8549,7 +8549,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -8559,7 +8559,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -8569,7 +8569,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -8590,7 +8590,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -8629,7 +8629,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_dmfc0_lladdr(arg, cpu_env);
@@ -8649,7 +8649,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -8667,7 +8667,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -8685,7 +8685,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -8696,7 +8696,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -8708,11 +8708,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 22:
+    case CPO_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
         rn = "'Diagnostic"; /* implementation dependent */
         break;
-    case 23:
+    case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
@@ -8738,7 +8738,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8749,7 +8749,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -8787,7 +8787,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -8797,7 +8797,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         /* ignored */
         case 0:
@@ -8811,7 +8811,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8831,7 +8831,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8851,7 +8851,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8861,7 +8861,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8906,7 +8906,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -8936,7 +8936,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -8981,7 +8981,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo0(cpu_env, arg);
@@ -9026,7 +9026,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo1(cpu_env, arg);
@@ -9041,7 +9041,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -9061,7 +9061,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -9106,7 +9106,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -9146,7 +9146,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -9158,7 +9158,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9180,7 +9180,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -9193,7 +9193,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -9203,7 +9203,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -9216,7 +9216,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9251,7 +9251,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9267,7 +9267,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -9277,7 +9277,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9292,7 +9292,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -9332,7 +9332,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -9352,7 +9352,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -9370,7 +9370,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -9388,7 +9388,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -9399,7 +9399,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -9411,11 +9411,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 22:
+    case CPO_REGISTER_22:
         /* ignored */
         rn = "Diagnostic"; /* implementation dependent */
         break;
-    case 23:
+    case CPO_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
@@ -9452,7 +9452,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -9463,7 +9463,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -9501,7 +9501,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -9512,7 +9512,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -9525,7 +9525,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -9545,7 +9545,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -9566,7 +9566,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -9576,7 +9576,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
-- 
2.7.4
