Received: from eggs.gnu.org ([2001:4830:134:3::10]:47649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdvwI-0005BZ-9d
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdvwF-0001k2-5u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:31:54 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Feb 2017 17:31:47 +0800
Message-Id: <20170215093147.29711-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] cadence_gem: Remove unused parameter debug
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Reported by cppcheck.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e99d454..d4de8ad 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -508,7 +508,7 @@ static void gem_update_int_status(CadenceGEMState *s)
 
     if ((s->num_priority_queues == 1) && s->regs[GEM_ISR]) {
         /* No priority queues, just trigger the interrupt */
-        DB_PRINT("asserting int.\n", i);
+        DB_PRINT("asserting int.\n");
         qemu_set_irq(s->irq[0], 1);
         return;
     }
-- 
2.9.3
