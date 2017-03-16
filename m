Received: from eggs.gnu.org ([2001:4830:134:3::10]:48868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLG0-0000Ka-EP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFz-000194-Eq
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:16 -0400
Received: from mail.kernel.org ([198.145.29.136]:32834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFz-00018f-73
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:15 -0400
Date: Thu, 16 Mar 2017 04:35:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489631689-6382-6-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] virtio-serial-bus: Delete timer from list
 before free it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Amit Shah <amit@kernel.org>
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
MST
