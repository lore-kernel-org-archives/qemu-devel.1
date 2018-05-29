Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDk-00020c-C7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDj-0004PU-Jw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:16 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDj-0004OP-D2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:15 -0400
Received: by mail-wr0-x233.google.com with SMTP id i12-v6so24714572wrc.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:10 +0200
Message-Id: <20180529105011.1914-38-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 37/38] target-microblaze: cpu_mmu_index:
 Fixup indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fixup the indentation of cpu_mmu_index in preparation for
future edits.
No functional changes.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e38580cd7f..c77ca2d8f9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -360,13 +360,15 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 
 static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
 {
-        /* Are we in nommu mode?.  */
-        if (!(env->sregs[SR_MSR] & MSR_VM))
-            return MMU_NOMMU_IDX;
-
-	if (env->sregs[SR_MSR] & MSR_UM)
-            return MMU_USER_IDX;
-        return MMU_KERNEL_IDX;
+    /* Are we in nommu mode?.  */
+    if (!(env->sregs[SR_MSR] & MSR_VM)) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->sregs[SR_MSR] & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
 }
 
 int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-- 
2.14.1
