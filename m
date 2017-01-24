Received: from eggs.gnu.org ([2001:4830:134:3::10]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SF-0006D6-ON
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SB-00008l-Kn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:27 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5SB-00008a-FF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so36299315wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jan 2017 19:04:13 +0100
Message-Id: <20170124180420.12430-2-pbonzini@redhat.com>
In-Reply-To: <20170124180420.12430-1-pbonzini@redhat.com>
References: <20170124180420.12430-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/8] virtio: make virtio_should_notify static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c         | 2 +-
 include/hw/virtio/virtio.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

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
 
-- 
2.9.3
