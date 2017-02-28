Received: from eggs.gnu.org ([2001:4830:134:3::10]:45117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfq-00079W-RV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfn-0005ss-Qp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:14 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:51 +0300
Message-Id: <8ea1d056320dd5bbbd480c45e6cfb8e3689bcc7e.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 08/14] cadence_gem: Remove unused parameter
 debug message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Fam Zheng <famz@redhat.com>

Reported by cppcheck.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.1.4
