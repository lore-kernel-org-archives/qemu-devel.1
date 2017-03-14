Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnpzO-0000vs-4B
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnpzJ-0000Z9-7t
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:12:02 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:56422)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnpzJ-0000Yx-1C
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:11:57 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 14 Mar 2017 17:11:43 +0000
Message-ID: <1489511503-13334-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] dma/rc4030: fix a mixed declarations and code
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/dma/rc4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 8ad97f1..4dbb4fd 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -99,8 +99,8 @@ typedef struct rc4030State
 
 static void set_next_tick(rc4030State *s)
 {
-    qemu_irq_lower(s->timer_irq);
     uint32_t tm_hz;
+    qemu_irq_lower(s->timer_irq);
 
     tm_hz = 1000 / (s->itr + 1);
 
-- 
2.7.4
