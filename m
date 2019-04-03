Received: from eggs.gnu.org ([209.51.188.92]:43557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hBfMB-0005d7-Ry
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hBfMA-0004B8-RU
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hBfMA-0004Ak-JQ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:51:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id q1so21190882wrp.0
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:51:06 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
Date: Wed,  3 Apr 2019 13:50:54 +0100
Message-Id: <20190403125055.26564-5-jbi.octave@gmail.com>
In-Reply-To: <20190403125055.26564-1-jbi.octave@gmail.com>
References: <20190403125055.26564-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] target/mips: remove space to fix
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
Cc: aurelien@aurel32.net, qemu-devel@nongnu.org, arikalo@wavecomp.com

Remove space to fix errors issued by checkpatch.pl tool
"ERROR: space prohibited between function name and open parenthesis"
"ERROR: trailing white space"
 within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c4278b3ffe..238a67c405 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -992,7 +992,7 @@ struct CPUMIPSState {
      * If translation is interrupted between the branch instruction and
      * the delay slot, record what type of branch it is so that we can
      * resume translation properly.  It might be possible to reduce
-     * this from three bits to two.  
+     * this from three bits to two.
      */
 #define MIPS_HFLAG_BMASK_BASE  0x803800
 #define MIPS_HFLAG_B      0x00800 /* Unconditional branch               */
@@ -1072,7 +1072,7 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 #define cpu_signal_handler cpu_mips_signal_handler
 #define cpu_list mips_cpu_list
@@ -1099,14 +1099,14 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 {
     return hflags_mmu_index(env->hflags);
 }
 
 #include "exec/cpu-all.h"
 
-/* 
+/*
  * Memory access type :
  * may be needed for precise access rights control and precise exceptions.
  */
@@ -1192,7 +1192,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void itc_reconfigure(struct MIPSITUState *tag);
 
 /* helper.c */
-target_ulong exception_resume_pc (CPUMIPSState *env);
+target_ulong exception_resume_pc(CPUMIPSState *env);
 
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
-- 
2.20.1
