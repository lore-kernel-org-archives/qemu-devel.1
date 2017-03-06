Received: from eggs.gnu.org ([2001:4830:134:3::10]:42556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ckjLh-0007PX-6D
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 22:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ckjLc-0002UA-GA
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 22:30:13 -0500
Received: from [45.249.212.187] (port=2994 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ckjLc-0002OB-3z
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 22:30:08 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Mon, 6 Mar 2017 11:29:31 +0800
Message-ID: <1488770972-322500-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio-serial-bus: Delete timer from list
 before free it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amit@kernel.org, mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 hw/char/virtio-serial-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d544cd9..d797a67 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -724,6 +724,7 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
         }
     }
     g_free(s->post_load->connected);
+    timer_del(s->post_load->timer);
     timer_free(s->post_load->timer);
     g_free(s->post_load);
     s->post_load = NULL;
-- 
1.8.3.1
