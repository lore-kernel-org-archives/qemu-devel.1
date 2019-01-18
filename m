Received: from eggs.gnu.org ([209.51.188.92]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVM-0003qI-Qc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXVA-0007Bz-3P
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:22 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52991 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV7-00077S-F8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:15 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:42 +0100
Message-Id: <1547830785-7079-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 09/12] target/mips: Amend preprocessor
 constants for CP0 registers
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

Correct existing CP0-related preprocessor constants (replace
"CPO" with "CP0" (form letter "O" to digit "0", when needed).
Besides, add preprocessor constants for CP0 subregisters.
The names of the subregisters were chosen to be in sync with
the table of corresponding assembler mnemonics found in the
documentation for I6500 and I6400 (release 1.0).

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 178 +++++++++++++++++++++++++------
 target/mips/translate.c | 276 ++++++++++++++++++++++++------------------------
 2 files changed, 284 insertions(+), 170 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 48e86d1..a5381b7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -233,38 +233,152 @@ typedef struct mips_def_t mips_def_t;
  * 7   TagLo             TagHi                               KScratch<n>
  *
  */
-#define CPO_REGISTER_00     0
-#define CPO_REGISTER_01     1
-#define CPO_REGISTER_02     2
-#define CPO_REGISTER_03     3
-#define CPO_REGISTER_04     4
-#define CPO_REGISTER_05     5
-#define CPO_REGISTER_06     6
-#define CPO_REGISTER_07     7
-#define CPO_REGISTER_08     8
-#define CPO_REGISTER_09     9
-#define CPO_REGISTER_10    10
-#define CPO_REGISTER_11    11
-#define CPO_REGISTER_12    12
-#define CPO_REGISTER_13    13
-#define CPO_REGISTER_14    14
-#define CPO_REGISTER_15    15
-#define CPO_REGISTER_16    16
-#define CPO_REGISTER_17    17
-#define CPO_REGISTER_18    18
-#define CPO_REGISTER_19    19
-#define CPO_REGISTER_20    20
-#define CPO_REGISTER_21    21
-#define CPO_REGISTER_22    22
-#define CPO_REGISTER_23    23
-#define CPO_REGISTER_24    24
-#define CPO_REGISTER_25    25
-#define CPO_REGISTER_26    26
-#define CPO_REGISTER_27    27
-#define CPO_REGISTER_28    28
-#define CPO_REGISTER_29    29
-#define CPO_REGISTER_30    30
-#define CPO_REGISTER_31    31
+#define CP0_REGISTER_00     0
+#define CP0_REGISTER_01     1
+#define CP0_REGISTER_02     2
+#define CP0_REGISTER_03     3
+#define CP0_REGISTER_04     4
+#define CP0_REGISTER_05     5
+#define CP0_REGISTER_06     6
+#define CP0_REGISTER_07     7
+#define CP0_REGISTER_08     8
+#define CP0_REGISTER_09     9
+#define CP0_REGISTER_10    10
+#define CP0_REGISTER_11    11
+#define CP0_REGISTER_12    12
+#define CP0_REGISTER_13    13
+#define CP0_REGISTER_14    14
+#define CP0_REGISTER_15    15
+#define CP0_REGISTER_16    16
+#define CP0_REGISTER_17    17
+#define CP0_REGISTER_18    18
+#define CP0_REGISTER_19    19
+#define CP0_REGISTER_20    20
+#define CP0_REGISTER_21    21
+#define CP0_REGISTER_22    22
+#define CP0_REGISTER_23    23
+#define CP0_REGISTER_24    24
+#define CP0_REGISTER_25    25
+#define CP0_REGISTER_26    26
+#define CP0_REGISTER_27    27
+#define CP0_REGISTER_28    28
+#define CP0_REGISTER_29    29
+#define CP0_REGISTER_30    30
+#define CP0_REGISTER_31    31
+
+
+/* CP0 Register 00 */
+#define CP0_REG00__INDEX           0
+#define CP0_REG00__VPCONTROL       4
+/* CP0 Register 01 */
+/* CP0 Register 02 */
+#define CP0_REG02__ENTRYLO0        0
+/* CP0 Register 03 */
+#define CP0_REG03__ENTRYLO1        0
+#define CP0_REG03__GLOBALNUM       1
+/* CP0 Register 04 */
+#define CP0_REG04__CONTEXT         0
+#define CP0_REG04__USERLOCAL       2
+#define CP0_REG04__DBGCONTEXTID    4
+#define CP0_REG00__MMID            5
+/* CP0 Register 05 */
+#define CP0_REG05__PAGEMASK        0
+#define CP0_REG05__PAGEGRAIN       1
+/* CP0 Register 06 */
+#define CP0_REG06__WIRED           0
+/* CP0 Register 07 */
+#define CP0_REG07__HWRENA          0
+/* CP0 Register 08 */
+#define CP0_REG08__BADVADDR        0
+#define CP0_REG08__BADINSTR        1
+#define CP0_REG08__BADINSTRP       2
+/* CP0 Register 09 */
+#define CP0_REG09__COUNT           0
+#define CP0_REG09__SAARI           6
+#define CP0_REG09__SAAR            7
+/* CP0 Register 10 */
+#define CP0_REG10__ENTRYHI         0
+#define CP0_REG10__GUESTCTL1       4
+#define CP0_REG10__GUESTCTL2       5
+/* CP0 Register 11 */
+#define CP0_REG11__COMPARE         0
+#define CP0_REG11__GUESTCTL0EXT    4
+/* CP0 Register 12 */
+#define CP0_REG12__STATUS          0
+#define CP0_REG12__INTCTL          1
+#define CP0_REG12__SRSCTL          2
+#define CP0_REG12__GUESTCTL0       6
+#define CP0_REG12__GTOFFSET        7
+/* CP0 Register 13 */
+#define CP0_REG13__CAUSE           0
+/* CP0 Register 14 */
+#define CP0_REG14__EPC             0
+/* CP0 Register 15 */
+#define CP0_REG15__PRID            0
+#define CP0_REG15__EBASE           1
+#define CP0_REG15__CDMMBASE        2
+#define CP0_REG15__CMGCRBASE       3
+/* CP0 Register 16 */
+#define CP0_REG16__CONFIG          0
+#define CP0_REG16__CONFIG1         1
+#define CP0_REG16__CONFIG2         2
+#define CP0_REG16__CONFIG3         3
+#define CP0_REG16__CONFIG4         4
+#define CP0_REG16__CONFIG5         5
+#define CP0_REG00__CONFIG7         7
+/* CP0 Register 17 */
+#define CP0_REG17__LLADDR          0
+#define CP0_REG17__MAAR            1
+#define CP0_REG17__MAARI           2
+/* CP0 Register 18 */
+#define CP0_REG18__WATCHLO0        0
+#define CP0_REG18__WATCHLO1        1
+#define CP0_REG18__WATCHLO2        2
+#define CP0_REG18__WATCHLO3        3
+/* CP0 Register 19 */
+#define CP0_REG19__WATCHHI0        0
+#define CP0_REG19__WATCHHI1        1
+#define CP0_REG19__WATCHHI2        2
+#define CP0_REG19__WATCHHI3        3
+/* CP0 Register 20 */
+#define CP0_REG20__XCONTEXT        0
+/* CP0 Register 21 */
+/* CP0 Register 22 */
+/* CP0 Register 23 */
+#define CP0_REG23__DEBUG           0
+/* CP0 Register 24 */
+#define CP0_REG24__DEPC            0
+/* CP0 Register 25 */
+#define CP0_REG25__PERFCTL0        0
+#define CP0_REG25__PERFCNT0        1
+#define CP0_REG25__PERFCTL1        2
+#define CP0_REG25__PERFCNT1        3
+#define CP0_REG25__PERFCTL2        4
+#define CP0_REG25__PERFCNT2        5
+#define CP0_REG25__PERFCTL3        6
+#define CP0_REG25__PERFCNT3        7
+/* CP0 Register 26 */
+#define CP0_REG00__ERRCTL          0
+/* CP0 Register 27 */
+#define CP0_REG27__CACHERR         0
+/* CP0 Register 28 */
+#define CP0_REG28__ITAGLO          0
+#define CP0_REG28__IDATALO         1
+#define CP0_REG28__DTAGLO          2
+#define CP0_REG28__DDATALO         3
+/* CP0 Register 29 */
+#define CP0_REG29__IDATAHI         1
+#define CP0_REG29__DDATAHI         3
+/* CP0 Register 30 */
+#define CP0_REG30__ERROREPC        0
+/* CP0 Register 31 */
+#define CP0_REG31__DESAVE          0
+#define CP0_REG31__KSCRATCH1       2
+#define CP0_REG31__KSCRATCH2       3
+#define CP0_REG31__KSCRATCH3       4
+#define CP0_REG31__KSCRATCH4       5
+#define CP0_REG31__KSCRATCH5       6
+#define CP0_REG31__KSCRATCH6       7
 
 
 typedef struct TCState TCState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 00cbbf7..2259d44 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6571,7 +6571,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     const char *rn = "invalid";
 
     switch (reg) {
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6582,7 +6582,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6593,7 +6593,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 7:
             CP0_CHECK(ctx->saar);
@@ -6604,7 +6604,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
@@ -6620,7 +6620,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6650,7 +6650,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     uint64_t mask = ctx->PAMask >> 36;
 
     switch (reg) {
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6662,7 +6662,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
@@ -6674,7 +6674,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 7:
             CP0_CHECK(ctx->saar);
@@ -6684,7 +6684,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         default:
             goto cp0_unimplemented;
         }
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             /* LLAddr is read-only (the only exception is bit 0 if LLB is
@@ -6702,7 +6702,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -6742,7 +6742,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS32);
 
     switch (reg) {
-    case CPO_REGISTER_00:
+    case CP0_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -6772,7 +6772,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_01:
+    case CP0_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -6818,7 +6818,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             {
@@ -6876,7 +6876,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             {
@@ -6904,7 +6904,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_04:
+    case CP0_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -6926,7 +6926,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_05:
+    case CP0_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -6974,7 +6974,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_06:
+    case CP0_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -7014,7 +7014,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_07:
+    case CP0_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -7025,7 +7025,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_08:
+    case CP0_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -7052,7 +7052,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -7084,7 +7084,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_10:
+    case CP0_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -7095,7 +7095,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_11:
+    case CP0_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -7106,7 +7106,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_12:
+    case CP0_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -7131,7 +7131,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case CPO_REGISTER_13:
+    case CP0_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -7141,7 +7141,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case CPO_REGISTER_14:
+    case CP0_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7152,7 +7152,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_15:
+    case CP0_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -7175,7 +7175,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
        }
         break;
-    case CPO_REGISTER_16:
+    case CP0_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -7214,7 +7214,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mfc0_lladdr(arg, cpu_env);
@@ -7234,7 +7234,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_18:
+    case CP0_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7252,7 +7252,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_19:
+    case CP0_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -7270,7 +7270,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_20:
+    case CP0_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -7284,7 +7284,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_21:
+    case CP0_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -7296,11 +7296,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_22:
+    case CP0_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
         rn = "'Diagnostic"; /* implementation dependent */
         break;
-    case CPO_REGISTER_23:
+    case CP0_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
@@ -7326,7 +7326,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_24:
+    case CP0_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7338,7 +7338,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_25:
+    case CP0_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -7376,7 +7376,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_26:
+    case CP0_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -7386,7 +7386,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_27:
+    case CP0_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -7399,7 +7399,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -7424,7 +7424,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_29:
+    case CP0_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -7444,7 +7444,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_30:
+    case CP0_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -7455,7 +7455,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_31:
+    case CP0_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -7501,7 +7501,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case CPO_REGISTER_00:
+    case CP0_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -7531,7 +7531,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_01:
+    case CP0_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7578,7 +7578,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo0(cpu_env, arg);
@@ -7623,7 +7623,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entrylo1(cpu_env, arg);
@@ -7638,7 +7638,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_04:
+    case CP0_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -7658,7 +7658,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_05:
+    case CP0_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -7704,7 +7704,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_06:
+    case CP0_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -7744,7 +7744,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_07:
+    case CP0_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -7756,7 +7756,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_08:
+    case CP0_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7778,7 +7778,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -7798,7 +7798,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_10:
+    case CP0_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -7808,7 +7808,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_11:
+    case CP0_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -7819,7 +7819,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_12:
+    case CP0_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7854,7 +7854,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_13:
+    case CP0_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -7870,7 +7870,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_14:
+    case CP0_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -7880,7 +7880,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_15:
+    case CP0_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -7895,7 +7895,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_16:
+    case CP0_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -7944,7 +7944,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -7964,7 +7964,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_18:
+    case CP0_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -7982,7 +7982,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_19:
+    case CP0_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -8000,7 +8000,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_20:
+    case CP0_REGISTER_20:
         switch (sel) {
         case 0:
 #if defined(TARGET_MIPS64)
@@ -8013,7 +8013,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_21:
+    case CP0_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -8025,11 +8025,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_22:
+    case CP0_REGISTER_22:
         /* ignored */
         rn = "Diagnostic"; /* implementation dependent */
         break;
-    case CPO_REGISTER_23:
+    case CP0_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
@@ -8068,7 +8068,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_24:
+    case CP0_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8079,7 +8079,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_25:
+    case CP0_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -8117,7 +8117,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case CPO_REGISTER_26:
+    case CP0_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -8128,7 +8128,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_27:
+    case CP0_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -8141,7 +8141,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8161,7 +8161,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_29:
+    case CP0_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8182,7 +8182,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
        break;
-    case CPO_REGISTER_30:
+    case CP0_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8192,7 +8192,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_31:
+    case CP0_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8242,7 +8242,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         check_insn(ctx, ISA_MIPS64);
 
     switch (reg) {
-    case CPO_REGISTER_00:
+    case CP0_REGISTER_00:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Index));
@@ -8272,7 +8272,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_01:
+    case CP0_REGISTER_01:
         switch (sel) {
         case 0:
             CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
@@ -8318,7 +8318,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
@@ -8363,7 +8363,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo1));
@@ -8378,7 +8378,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_04:
+    case CP0_REGISTER_04:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
@@ -8398,7 +8398,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_05:
+    case CP0_REGISTER_05:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PageMask));
@@ -8443,7 +8443,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_06:
+    case CP0_REGISTER_06:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
@@ -8483,7 +8483,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_07:
+    case CP0_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -8494,7 +8494,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_08:
+    case CP0_REGISTER_08:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
@@ -8520,7 +8520,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 0:
             /* Mark as an IO operation because we read the time.  */
@@ -8552,7 +8552,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_10:
+    case CP0_REGISTER_10:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryHi));
@@ -8562,7 +8562,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_11:
+    case CP0_REGISTER_11:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Compare));
@@ -8573,7 +8573,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_12:
+    case CP0_REGISTER_12:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
@@ -8598,7 +8598,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_13:
+    case CP0_REGISTER_13:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Cause));
@@ -8608,7 +8608,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_14:
+    case CP0_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -8618,7 +8618,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_15:
+    case CP0_REGISTER_15:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
@@ -8639,7 +8639,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_16:
+    case CP0_REGISTER_16:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
@@ -8678,7 +8678,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_dmfc0_lladdr(arg, cpu_env);
@@ -8698,7 +8698,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_18:
+    case CP0_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -8716,7 +8716,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_19:
+    case CP0_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -8734,7 +8734,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_20:
+    case CP0_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -8745,7 +8745,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_21:
+    case CP0_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -8757,11 +8757,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_22:
+    case CP0_REGISTER_22:
         tcg_gen_movi_tl(arg, 0); /* unimplemented */
         rn = "'Diagnostic"; /* implementation dependent */
         break;
-    case CPO_REGISTER_23:
+    case CP0_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
@@ -8787,7 +8787,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_24:
+    case CP0_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8798,7 +8798,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_25:
+    case CP0_REGISTER_25:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
@@ -8836,7 +8836,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_26:
+    case CP0_REGISTER_26:
         switch (sel) {
         case 0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_ErrCtl));
@@ -8846,7 +8846,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_27:
+    case CP0_REGISTER_27:
         switch (sel) {
         /* ignored */
         case 0:
@@ -8860,7 +8860,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -8880,7 +8880,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_29:
+    case CP0_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -8900,7 +8900,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_30:
+    case CP0_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -8910,7 +8910,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_31:
+    case CP0_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -8955,7 +8955,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     }
 
     switch (reg) {
-    case CPO_REGISTER_00:
+    case CP0_REGISTER_00:
         switch (sel) {
         case 0:
             gen_helper_mtc0_index(cpu_env, arg);
@@ -8985,7 +8985,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_01:
+    case CP0_REGISTER_01:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9030,7 +9030,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_02:
+    case CP0_REGISTER_02:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo0(cpu_env, arg);
@@ -9075,7 +9075,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_03:
+    case CP0_REGISTER_03:
         switch (sel) {
         case 0:
             gen_helper_dmtc0_entrylo1(cpu_env, arg);
@@ -9090,7 +9090,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_04:
+    case CP0_REGISTER_04:
         switch (sel) {
         case 0:
             gen_helper_mtc0_context(cpu_env, arg);
@@ -9110,7 +9110,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_05:
+    case CP0_REGISTER_05:
         switch (sel) {
         case 0:
             gen_helper_mtc0_pagemask(cpu_env, arg);
@@ -9155,7 +9155,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_06:
+    case CP0_REGISTER_06:
         switch (sel) {
         case 0:
             gen_helper_mtc0_wired(cpu_env, arg);
@@ -9195,7 +9195,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_07:
+    case CP0_REGISTER_07:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS32R2);
@@ -9207,7 +9207,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_08:
+    case CP0_REGISTER_08:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9229,7 +9229,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_09:
+    case CP0_REGISTER_09:
         switch (sel) {
         case 0:
             gen_helper_mtc0_count(cpu_env, arg);
@@ -9251,7 +9251,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case CPO_REGISTER_10:
+    case CP0_REGISTER_10:
         switch (sel) {
         case 0:
             gen_helper_mtc0_entryhi(cpu_env, arg);
@@ -9261,7 +9261,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_11:
+    case CP0_REGISTER_11:
         switch (sel) {
         case 0:
             gen_helper_mtc0_compare(cpu_env, arg);
@@ -9274,7 +9274,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         /* Stop translation as we may have switched the execution mode */
         ctx->base.is_jmp = DISAS_STOP;
         break;
-    case CPO_REGISTER_12:
+    case CP0_REGISTER_12:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9309,7 +9309,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_13:
+    case CP0_REGISTER_13:
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
@@ -9325,7 +9325,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_14:
+    case CP0_REGISTER_14:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EPC));
@@ -9335,7 +9335,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_15:
+    case CP0_REGISTER_15:
         switch (sel) {
         case 0:
             /* ignored */
@@ -9350,7 +9350,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_16:
+    case CP0_REGISTER_16:
         switch (sel) {
         case 0:
             gen_helper_mtc0_config0(cpu_env, arg);
@@ -9390,7 +9390,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_17:
+    case CP0_REGISTER_17:
         switch (sel) {
         case 0:
             gen_helper_mtc0_lladdr(cpu_env, arg);
@@ -9410,7 +9410,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_18:
+    case CP0_REGISTER_18:
         switch (sel) {
         case 0:
         case 1:
@@ -9428,7 +9428,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_19:
+    case CP0_REGISTER_19:
         switch (sel) {
         case 0:
         case 1:
@@ -9446,7 +9446,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_20:
+    case CP0_REGISTER_20:
         switch (sel) {
         case 0:
             check_insn(ctx, ISA_MIPS3);
@@ -9457,7 +9457,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_21:
+    case CP0_REGISTER_21:
        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
@@ -9469,11 +9469,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_22:
+    case CP0_REGISTER_22:
         /* ignored */
         rn = "Diagnostic"; /* implementation dependent */
         break;
-    case CPO_REGISTER_23:
+    case CP0_REGISTER_23:
         switch (sel) {
         case 0:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
@@ -9510,7 +9510,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_24:
+    case CP0_REGISTER_24:
         switch (sel) {
         case 0:
             /* EJTAG support */
@@ -9521,7 +9521,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_25:
+    case CP0_REGISTER_25:
         switch (sel) {
         case 0:
             gen_helper_mtc0_performance0(cpu_env, arg);
@@ -9559,7 +9559,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_26:
+    case CP0_REGISTER_26:
         switch (sel) {
         case 0:
             gen_helper_mtc0_errctl(cpu_env, arg);
@@ -9570,7 +9570,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_27:
+    case CP0_REGISTER_27:
         switch (sel) {
         case 0:
         case 1:
@@ -9583,7 +9583,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_28:
+    case CP0_REGISTER_28:
         switch (sel) {
         case 0:
         case 2:
@@ -9603,7 +9603,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_29:
+    case CP0_REGISTER_29:
         switch (sel) {
         case 0:
         case 2:
@@ -9624,7 +9624,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_30:
+    case CP0_REGISTER_30:
         switch (sel) {
         case 0:
             tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_ErrorEPC));
@@ -9634,7 +9634,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CPO_REGISTER_31:
+    case CP0_REGISTER_31:
         switch (sel) {
         case 0:
             /* EJTAG support */
-- 
2.7.4
