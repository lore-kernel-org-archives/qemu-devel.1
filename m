Received: from eggs.gnu.org ([2001:4830:134:3::10]:54550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9ARf-0002ww-Nw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9ARe-00035I-UZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:21:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 15:21:51 +0100
Message-Id: <20180419142151.9862-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Remove stale TODO comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Remove a stale TODO comment -- we have now made the arm_ldl_ptw()
and arm_ldq_ptw() functions propagate physical memory read errors
out to their callers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2ebd086ef2..0fa02c31e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8681,13 +8681,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
     return addr;
 }
 
-/* All loads done in the course of a page table walk go through here.
- * TODO: rather than ignoring errors from physical memory reads (which
- * are external aborts in ARM terminology) we should propagate this
- * error out so that we can turn it into a Data Abort if this walk
- * was being done for a CPU load/store or an address translation instruction
- * (but not if it was for a debug access).
- */
+/* All loads done in the course of a page table walk go through here. */
 static uint32_t arm_ldl_ptw(CPUState *cs, hwaddr addr, bool is_secure,
                             ARMMMUIdx mmu_idx, ARMMMUFaultInfo *fi)
 {
-- 
2.17.0
