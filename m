Received: from eggs.gnu.org ([208.118.235.92]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf5yI-0001aF-EU
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf5yF-0008BN-7J
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:50 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40691 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf5yE-00072d-Mx
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:47 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 17:34:07 +0100
Message-Id: <1546533252-26601-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/8] target/mips: Use preprocessor constants
 for 32 major CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Use preprocessor constants for 32 major CP0 registers.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 272 ++++++++++++++++++++++++------------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e9c23a5..6af292f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6476,7 +6476,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     const char *rn = "invalid";
 
     switch (reg) {
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6487,7 +6487,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6498,7 +6498,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
@@ -6514,7 +6514,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6544,7 +6544,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     uint64_t mask = ctx->PAMask >> 36;
 
     switch (reg) {
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6556,7 +6556,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6568,7 +6568,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             /* LLAddr is read-only (the only exception is bit 0 if LLB is
@@ -6586,7 +6586,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6626,7 +6626,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS32);
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -6656,7 +6656,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -6702,7 +6702,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             {
@@ -6760,7 +6760,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             {
@@ -6788,7 +6788,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -6810,7 +6810,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -6858,7 +6858,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -6898,7 +6898,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -6909,7 +6909,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -6936,7 +6936,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -6959,7 +6959,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -6970,7 +6970,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -6981,7 +6981,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -7006,7 +7006,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -7016,7 +7016,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7027,7 +7027,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -7050,7 +7050,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -7089,7 +7089,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mfc0_lladdr(arg, cpu_env);
@@ -7109,7 +7109,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7127,7 +7127,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -7145,7 +7145,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -7159,7 +7159,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -7171,11 +7171,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7201,7 +7201,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7213,7 +7213,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -7251,7 +7251,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -7261,7 +7261,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -7274,7 +7274,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -7299,7 +7299,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -7319,7 +7319,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -7330,7 +7330,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7376,7 +7376,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -7406,7 +7406,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7453,7 +7453,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo0(cpu_env, arg);
@@ -7498,7 +7498,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo1(cpu_env, arg);
@@ -7513,7 +7513,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -7533,7 +7533,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -7579,7 +7579,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -7619,7 +7619,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -7631,7 +7631,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7653,7 +7653,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -7664,7 +7664,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -7674,7 +7674,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -7685,7 +7685,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7720,7 +7720,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7736,7 +7736,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7746,7 +7746,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7761,7 +7761,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -7810,7 +7810,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -7830,7 +7830,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7848,7 +7848,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -7866,7 +7866,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -7879,7 +7879,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -7891,11 +7891,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7934,7 +7934,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7945,7 +7945,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -7983,7 +7983,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -7994,7 +7994,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -8007,7 +8007,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8027,7 +8027,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8048,7 +8048,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8058,7 +8058,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8108,7 +8108,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS64);
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -8138,7 +8138,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -8184,7 +8184,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
@@ -8229,7 +8229,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo1));
@@ -8244,7 +8244,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -8264,7 +8264,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -8309,7 +8309,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -8349,7 +8349,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -8360,7 +8360,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -8386,7 +8386,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -8409,7 +8409,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -8419,7 +8419,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -8430,7 +8430,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -8455,7 +8455,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -8465,7 +8465,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -8475,7 +8475,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -8496,7 +8496,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -8535,7 +8535,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_dmfc0_lladdr(arg, cpu_env);
@@ -8555,7 +8555,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -8573,7 +8573,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -8591,7 +8591,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -8602,7 +8602,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -8614,11 +8614,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -8644,7 +8644,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8655,7 +8655,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -8693,7 +8693,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -8703,7 +8703,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         /* ignored */
         case 0:
@@ -8717,7 +8717,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8737,7 +8737,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8757,7 +8757,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8767,7 +8767,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 31:
+    case CPO_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8812,7 +8812,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case 0:
+    case CPO_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -8842,7 +8842,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 1:
+    case CPO_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -8887,7 +8887,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 2:
+    case CPO_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo0(cpu_env, arg);
@@ -8932,7 +8932,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 3:
+    case CPO_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo1(cpu_env, arg);
@@ -8947,7 +8947,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 4:
+    case CPO_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -8967,7 +8967,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 5:
+    case CPO_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -9012,7 +9012,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 6:
+    case CPO_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -9052,7 +9052,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 7:
+    case CPO_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -9064,7 +9064,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 8:
+    case CPO_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9086,7 +9086,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 9:
+    case CPO_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -9099,7 +9099,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case 10:
+    case CPO_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -9109,7 +9109,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 11:
+    case CPO_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -9122,7 +9122,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case 12:
+    case CPO_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9157,7 +9157,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 13:
+    case CPO_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9173,7 +9173,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 14:
+    case CPO_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -9183,7 +9183,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 15:
+    case CPO_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9198,7 +9198,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 16:
+    case CPO_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -9238,7 +9238,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 17:
+    case CPO_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -9258,7 +9258,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 18:
+    case CPO_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -9276,7 +9276,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 19:
+    case CPO_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -9294,7 +9294,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 20:
+    case CPO_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -9305,7 +9305,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 21:
+    case CPO_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -9317,11 +9317,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9358,7 +9358,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 24:
+    case CPO_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -9369,7 +9369,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 25:
+    case CPO_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -9407,7 +9407,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 26:
+    case CPO_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -9418,7 +9418,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 27:
+    case CPO_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -9431,7 +9431,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 28:
+    case CPO_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -9451,7 +9451,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 29:
+    case CPO_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -9472,7 +9472,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case 30:
+    case CPO_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -9482,7 +9482,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
