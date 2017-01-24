Received: from eggs.gnu.org ([2001:4830:134:3::10]:41044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9iD-00009W-It
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9i9-0005xU-OJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:12 -0500
Received: from mail.kernel.org ([198.145.29.136]:37472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=8ff6=ZG=redhat.com=mst@kernel.org>)
	id 1cW9i9-0005x7-IC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 17:37:09 -0500
Date: Wed, 25 Jan 2017 00:37:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485297322-10595-15-git-send-email-mst@redhat.com>
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485297322-10595-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/16] virtio: make virtio_should_notify static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio.h | 1 -
 hw/virtio/virtio.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6523bac..525da24 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -182,7 +182,6 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                unsigned int *out_bytes,
                                unsigned max_in_bytes, unsigned max_out_bytes);
 
-bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cc17b97..b1c5563 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1383,7 +1383,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
-- 
MST
