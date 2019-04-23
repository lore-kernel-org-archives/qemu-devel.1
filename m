Received: from eggs.gnu.org ([209.51.188.92]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001dB-GM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005WE-8Y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41178 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004B0-TN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 13:29:36 +0200
Message-Id: <1556018982-3715-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/8] target/mips: Realign comments to fix
 checkpatch warnings
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

From: Jules Irenge <jbi.octave@gmail.com>

Realign comments to fix warnings issued by checkpatc.pl tool
"WARNING: Block comments use a leading /* on a separate line"
within target/mips/cpu.h file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190413202818.13622-3-jbi.octave@gmail.com>
---
 target/mips/cpu.h | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 469f3ef..5819cb9 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -37,7 +37,8 @@ union fpr_t {
 /* FPU/MSA register mapping is not tested on big-endian hosts. */
     wr_t     wr;   /* vector data */
 };
-/* define FP_ENDIAN_IDX to access the same location
+/*
+ *define FP_ENDIAN_IDX to access the same location
  * in the fpr_t union regardless of the host endianness
  */
 #if defined(HOST_WORDS_BIGENDIAN)
@@ -976,9 +977,11 @@ struct CPUMIPSState {
     /* TMASK defines different execution modes */
 #define MIPS_HFLAG_TMASK  0x1F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
-    /* The KSU flags must be the lowest bits in hflags. The flag order
-       must be the same as defined for CP0 Status. This allows to use
-       the bits as the value of mmu_idx. */
+    /*
+     * The KSU flags must be the lowest bits in hflags. The flag order
+     * must be the same as defined for CP0 Status. This allows to use
+     * the bits as the value of mmu_idx.
+     */
 #define MIPS_HFLAG_KSU    0x00003 /* kernel/supervisor/user mode mask   */
 #define MIPS_HFLAG_UM     0x00002 /* user mode flag                     */
 #define MIPS_HFLAG_SM     0x00001 /* supervisor mode flag               */
@@ -988,18 +991,22 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_CP0    0x00010 /* CP0 enabled                        */
 #define MIPS_HFLAG_FPU    0x00020 /* FPU enabled                        */
 #define MIPS_HFLAG_F64    0x00040 /* 64-bit FPU enabled                 */
-    /* True if the MIPS IV COP1X instructions can be used.  This also
-       controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
-       and RSQRT.D.  */
+    /*
+     * True if the MIPS IV COP1X instructions can be used.  This also
+     * controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
+     * and RSQRT.D.
+     */
 #define MIPS_HFLAG_COP1X  0x00080 /* COP1X instructions enabled         */
 #define MIPS_HFLAG_RE     0x00100 /* Reversed endianness                */
 #define MIPS_HFLAG_AWRAP  0x00200 /* 32-bit compatibility address wrapping */
 #define MIPS_HFLAG_M16    0x00400 /* MIPS16 mode flag                   */
 #define MIPS_HFLAG_M16_SHIFT 10
-    /* If translation is interrupted between the branch instruction and
+    /*
+     * If translation is interrupted between the branch instruction and
      * the delay slot, record what type of branch it is so that we can
      * resume translation properly.  It might be possible to reduce
-     * this from three bits to two.  */
+     * this from three bits to two.
+     */
 #define MIPS_HFLAG_BMASK_BASE  0x803800
 #define MIPS_HFLAG_B      0x00800 /* Unconditional branch               */
 #define MIPS_HFLAG_BC     0x01000 /* Conditional branch                 */
@@ -1086,8 +1093,10 @@ void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
 extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
-/* MMU modes definitions. We carefully match the indices with our
-   hflags layout. */
+/*
+ * MMU modes definitions. We carefully match the indices with our
+ * hflags layout.
+ */
 #define MMU_MODE0_SUFFIX _kernel
 #define MMU_MODE1_SUFFIX _super
 #define MMU_MODE2_SUFFIX _user
@@ -1110,7 +1119,8 @@ static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-/* Memory access type :
+/*
+ * Memory access type :
  * may be needed for precise access rights control and precise exceptions.
  */
 enum {
-- 
2.7.4
