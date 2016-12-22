Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DK-0007ag-KB
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DG-0007AU-T1
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DG-0007AO-Mz
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:22 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:46 +0100
Message-Id: <20161222152300.32395-12-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/25] timer: fix misleading comment in timer.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

It's timer to expire, not clock.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-Id: <1480566640-27264-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index bdfae00..9abed51 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -133,7 +133,7 @@ bool qemu_clock_has_timers(QEMUClockType type);
  * @type: the clock type
  *
  * Determines whether a clock's default timer list
- * has an expired clock.
+ * has an expired timer.
  *
  * Returns: true if the clock's default timer list has
  * an expired timer
-- 
2.9.3
