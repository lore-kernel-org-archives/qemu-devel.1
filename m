Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Xd-0003hV-5E
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Xc-00013i-D8
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Xb-00013F-Uw
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id p4-v6so2786966wrh.3
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:45 +0200
Message-Id: <20180516185146.30708-38-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 37/38] target-microblaze: cpu_mmu_index:
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fixup the indentation of cpu_mmu_index in preparation for
future edits.
No functional changes.

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
