Received: from eggs.gnu.org ([209.51.188.92]:52109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtugq-0001sX-1L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtugo-00039v-Bp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtugo-00035z-64
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:35:02 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:39 -0500
Message-Id: <1550064346-17012-5-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] virtio: initialize wrap counter for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Set to 'true' by default due to spec.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1a98e61..54dc098 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1238,6 +1238,9 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].shadow_avail_idx = 0;
         vdev->vq[i].used_idx = 0;
+        vdev->vq[i].last_avail_wrap_counter = true;
+        vdev->vq[i].avail_wrap_counter = true;
+        vdev->vq[i].used_wrap_counter = true;
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
-- 
1.8.3.1
