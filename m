Received: from eggs.gnu.org ([209.51.188.92]:45510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV7-0003YD-9L
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV5-00076v-BV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:13 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52889 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV3-0006pE-6X
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:34 +0100
Message-Id: <1547830785-7079-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 01/12] target/mips: Move comment containing
 summary of CP0 registers
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

Move comment containing summary of CP0 registers. Checkpatch
script reported some tabs in the resutling diff, so convert
these tabs to spaces too.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h | 165 +++++++++++++++++++++++++++---------------------------
 1 file changed, 84 insertions(+), 81 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 03c03fd..6c2a7e4 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -123,87 +123,6 @@ typedef struct mips_def_t mips_def_t;
 #define MIPS_KSCRATCH_NUM 6
 #define MIPS_MAAR_MAX 16 /* Must be an even number. */
 
-typedef struct TCState TCState;
-struct TCState {
-    target_ulong gpr[32];
-    target_ulong PC;
-    target_ulong HI[MIPS_DSP_ACC];
-    target_ulong LO[MIPS_DSP_ACC];
-    target_ulong ACX[MIPS_DSP_ACC];
-    target_ulong DSPControl;
-    int32_t CP0_TCStatus;
-#define CP0TCSt_TCU3	31
-#define CP0TCSt_TCU2	30
-#define CP0TCSt_TCU1	29
-#define CP0TCSt_TCU0	28
-#define CP0TCSt_TMX	27
-#define CP0TCSt_RNST	23
-#define CP0TCSt_TDS	21
-#define CP0TCSt_DT	20
-#define CP0TCSt_DA	15
-#define CP0TCSt_A	13
-#define CP0TCSt_TKSU	11
-#define CP0TCSt_IXMT	10
-#define CP0TCSt_TASID	0
-    int32_t CP0_TCBind;
-#define CP0TCBd_CurTC	21
-#define CP0TCBd_TBE	17
-#define CP0TCBd_CurVPE	0
-    target_ulong CP0_TCHalt;
-    target_ulong CP0_TCContext;
-    target_ulong CP0_TCSchedule;
-    target_ulong CP0_TCScheFBack;
-    int32_t CP0_Debug_tcstatus;
-    target_ulong CP0_UserLocal;
-
-    int32_t msacsr;
-
-#define MSACSR_FS       24
-#define MSACSR_FS_MASK  (1 << MSACSR_FS)
-#define MSACSR_NX       18
-#define MSACSR_NX_MASK  (1 << MSACSR_NX)
-#define MSACSR_CEF      2
-#define MSACSR_CEF_MASK (0xffff << MSACSR_CEF)
-#define MSACSR_RM       0
-#define MSACSR_RM_MASK  (0x3 << MSACSR_RM)
-#define MSACSR_MASK     (MSACSR_RM_MASK | MSACSR_CEF_MASK | MSACSR_NX_MASK | \
-        MSACSR_FS_MASK)
-
-    float_status msa_fp_status;
-
-#define NUMBER_OF_MXU_REGISTERS 16
-    target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
-    target_ulong mxu_cr;
-#define MXU_CR_LC       31
-#define MXU_CR_RC       30
-#define MXU_CR_BIAS     2
-#define MXU_CR_RD_EN    1
-#define MXU_CR_MXU_EN   0
-
-};
-
-typedef struct CPUMIPSState CPUMIPSState;
-struct CPUMIPSState {
-    TCState active_tc;
-    CPUMIPSFPUContext active_fpu;
-
-    uint32_t current_tc;
-    uint32_t current_fpu;
-
-    uint32_t SEGBITS;
-    uint32_t PABITS;
-#if defined(TARGET_MIPS64)
-# define PABITS_BASE 36
-#else
-# define PABITS_BASE 32
-#endif
-    target_ulong SEGMask;
-    uint64_t PAMask;
-#define PAMASK_BASE ((1ULL << PABITS_BASE) - 1)
-
-    int32_t msair;
-#define MSAIR_ProcID    8
-#define MSAIR_Rev       0
 
 /*
  *     Summary of CP0 registers
@@ -314,6 +233,90 @@ struct CPUMIPSState {
  * 7   TagLo             TagHi                               KScratch<n>
  *
  */
+
+
+typedef struct TCState TCState;
+struct TCState {
+    target_ulong gpr[32];
+    target_ulong PC;
+    target_ulong HI[MIPS_DSP_ACC];
+    target_ulong LO[MIPS_DSP_ACC];
+    target_ulong ACX[MIPS_DSP_ACC];
+    target_ulong DSPControl;
+    int32_t CP0_TCStatus;
+#define CP0TCSt_TCU3    31
+#define CP0TCSt_TCU2    30
+#define CP0TCSt_TCU1    29
+#define CP0TCSt_TCU0    28
+#define CP0TCSt_TMX     27
+#define CP0TCSt_RNST    23
+#define CP0TCSt_TDS     21
+#define CP0TCSt_DT      20
+#define CP0TCSt_DA      15
+#define CP0TCSt_A       13
+#define CP0TCSt_TKSU    11
+#define CP0TCSt_IXMT    10
+#define CP0TCSt_TASID   0
+    int32_t CP0_TCBind;
+#define CP0TCBd_CurTC   21
+#define CP0TCBd_TBE     17
+#define CP0TCBd_CurVPE  0
+    target_ulong CP0_TCHalt;
+    target_ulong CP0_TCContext;
+    target_ulong CP0_TCSchedule;
+    target_ulong CP0_TCScheFBack;
+    int32_t CP0_Debug_tcstatus;
+    target_ulong CP0_UserLocal;
+
+    int32_t msacsr;
+
+#define MSACSR_FS       24
+#define MSACSR_FS_MASK  (1 << MSACSR_FS)
+#define MSACSR_NX       18
+#define MSACSR_NX_MASK  (1 << MSACSR_NX)
+#define MSACSR_CEF      2
+#define MSACSR_CEF_MASK (0xffff << MSACSR_CEF)
+#define MSACSR_RM       0
+#define MSACSR_RM_MASK  (0x3 << MSACSR_RM)
+#define MSACSR_MASK     (MSACSR_RM_MASK | MSACSR_CEF_MASK | MSACSR_NX_MASK | \
+        MSACSR_FS_MASK)
+
+    float_status msa_fp_status;
+
+#define NUMBER_OF_MXU_REGISTERS 16
+    target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+    target_ulong mxu_cr;
+#define MXU_CR_LC       31
+#define MXU_CR_RC       30
+#define MXU_CR_BIAS     2
+#define MXU_CR_RD_EN    1
+#define MXU_CR_MXU_EN   0
+
+};
+
+typedef struct CPUMIPSState CPUMIPSState;
+struct CPUMIPSState {
+    TCState active_tc;
+    CPUMIPSFPUContext active_fpu;
+
+    uint32_t current_tc;
+    uint32_t current_fpu;
+
+    uint32_t SEGBITS;
+    uint32_t PABITS;
+#if defined(TARGET_MIPS64)
+# define PABITS_BASE 36
+#else
+# define PABITS_BASE 32
+#endif
+    target_ulong SEGMask;
+    uint64_t PAMask;
+#define PAMASK_BASE ((1ULL << PABITS_BASE) - 1)
+
+    int32_t msair;
+#define MSAIR_ProcID    8
+#define MSAIR_Rev       0
+
 /*
  * CP0 Register 0
  */
-- 
2.7.4
