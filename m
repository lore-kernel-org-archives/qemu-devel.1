Received: from eggs.gnu.org ([2001:4830:134:3::10]:50599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4PxA-0002At-Jc
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px5-0003iK-Lw
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:16 -0400
Received: from m12-12.163.com ([220.181.12.12]:42591)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px4-0003dG-Tl
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:11 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 29 Apr 2017 18:49:34 +0800
Message-Id: <20170429104937.31341-7-zxq_yx_007@163.com>
In-Reply-To: <20170429104937.31341-1-zxq_yx_007@163.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2 6/9] hw/timer: QOM'ify m48txx_sysbus (pass 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au, pbonzini@redhat.com, atar4qemu@gmail.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com

assign DeviceClass::vmsd instead of using vmstate_register function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/timer/m48t59.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index eff259ef96..3a9f541c9b 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -640,8 +640,6 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
         s->wd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &watchdog_cb, s);
     }
     qemu_get_timedate(&s->alarm, 0);
-
-    vmstate_register(NULL, -1, &vmstate_m48t59, s);
 }
 
 static void m48t59_init1(Object *obj)
@@ -702,6 +700,7 @@ static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
     dc->realize = m48t59_realize;
     dc->reset = m48t59_reset_sysbus;
     dc->props = m48t59_sysbus_properties;
+    dc->vmsd = &vmstate_m48t59;
     nc->read = m48txx_sysbus_read;
     nc->write = m48txx_sysbus_write;
     nc->toggle_lock = m48txx_sysbus_toggle_lock;
-- 
2.11.0
