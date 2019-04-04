Received: from eggs.gnu.org ([209.51.188.92]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hC6Kv-0006rf-41
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hC6Kt-0007Ui-Uy
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hC6Kt-0007Sb-Jq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 13:39:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so4428977wmd.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:39:34 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Thu,  4 Apr 2019 18:39:21 +0100
Message-Id: <20190404173921.30841-3-jbi.octave@gmail.com>
In-Reply-To: <20190404173921.30841-1-jbi.octave@gmail.com>
References: <20190404173921.30841-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] target/mips: add or remove space to fix
 checkpatch errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarkovic@wavecomp.com
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org

Add or remove space to fix errors issued by checkpatch.pl tool
"ERROR: spaces required around ..."
"ERROR: space required after that"
"ERROR: space required before the open parenthesis"
"ERROR: space prohibited between function name and open parenthesis"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5dd71dbe21..0d2718d7bf 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -22,10 +22,10 @@ typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
 typedef union wr_t wr_t;
 union wr_t {
-    int8_t  b[MSA_WRLEN/8];
-    int16_t h[MSA_WRLEN/16];
-    int32_t w[MSA_WRLEN/32];
-    int64_t d[MSA_WRLEN/64];
+    int8_t  b[MSA_WRLEN / 8];
+    int16_t h[MSA_WRLEN / 16];
+    int32_t w[MSA_WRLEN / 32];
+    int64_t d[MSA_WRLEN / 64];
 };
 
 typedef union fpr_t fpr_t;
@@ -72,16 +72,16 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num,env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
-#define CLEAR_FP_COND(num,env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
 #define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg,v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while(0)
-#define SET_FP_ENABLE(reg,v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while(0)
-#define SET_FP_FLAGS(reg,v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while(0)
-#define UPDATE_FP_FLAGS(reg,v)   do { (reg) |= ((v & 0x1f) << 2); } while(0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while (0)
+#define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
 #define FP_OVERFLOW       4
@@ -1072,7 +1072,7 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 #define cpu_signal_handler cpu_mips_signal_handler
 #define cpu_list mips_cpu_list
@@ -1099,7 +1099,7 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 {
     return hflags_mmu_index(env->hflags);
 }
@@ -1107,7 +1107,7 @@ static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
 #include "exec/cpu-all.h"
 
 /*
- * Memory access type :
+ * Memory access type:
  * may be needed for precise access rights control and precise exceptions.
  */
 enum {
@@ -1192,7 +1192,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void itc_reconfigure(struct MIPSITUState *tag);
 
 /* helper.c */
-target_ulong exception_resume_pc (CPUMIPSState *env);
+target_ulong exception_resume_pc(CPUMIPSState *env);
 
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
-- 
2.20.1
