Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXns-0005E8-8R
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXno-00035z-DO
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:11 +0300
Message-Id: <cc16ee9d4ecec35ea04eb5e44430207a447757ce.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 07/22] altera_timer: fix incorrect memset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

Use sizeof instead of ARRAY_SIZE, fixing -Wmemset-elt-size with recent
GCC versions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
