Received: from eggs.gnu.org ([2001:4830:134:3::10]:39817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR1-0002lE-9y
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0001ag-2X
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQz-0001Yu-Sb
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQo-000306-K5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:46:59 +0100
Message-Id: <20180426104715.21702-4-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/19] target/arm: Remove stale TODO comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove a stale TODO comment -- we have now made the arm_ldl_ptw()
and arm_ldq_ptw() functions propagate physical memory read errors
out to their callers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180419142151.9862-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b14fdab140..3ad0371aeb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8680,13 +8680,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
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
