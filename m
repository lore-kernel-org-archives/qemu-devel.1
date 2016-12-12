Received: from eggs.gnu.org ([2001:4830:134:3::10]:39245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdR-0004cw-Mt
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdQ-0000Ql-Sx
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdQ-0000QJ-Lx
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:08 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:51 +0100
Message-Id: <20161212111857.23399-6-pbonzini@redhat.com>
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] virtio: make virtio_should_notify static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c         | 2 +-
 include/hw/virtio/virtio.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1af2de2..568f4be 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1330,7 +1330,7 @@ static void virtio_set_isr(VirtIODevice *vdev, int value)
     }
 }
 
-bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
+static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ab0e030..9b21795 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -180,7 +180,6 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                unsigned int *out_bytes,
                                unsigned max_in_bytes, unsigned max_out_bytes);
 
-bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
-- 
1.8.3.1
