Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBIkY-0000s1-MR
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBIkV-0004nk-LG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:33:42 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 May 2017 12:33:34 +0200
Message-Id: <20170518103334.8808-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] altera_timer: fix incorrect memset
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

Use sizeof instead of ARRAY_SIZE, fixing -Wmemset-elt-size with recent
GCC versions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/altera_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 6d4862661d..c9a0fc5dca 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -204,7 +204,7 @@ static void altera_timer_reset(DeviceState *dev)
 
     ptimer_stop(t->ptimer);
     ptimer_set_limit(t->ptimer, 0xffffffff, 1);
-    memset(t->regs, 0, ARRAY_SIZE(t->regs));
+    memset(t->regs, 0, sizeof(t->regs));
 }
 
 static Property altera_timer_properties[] = {
-- 
2.13.0
