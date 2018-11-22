Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPpei-0004sV-3F
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPped-0000hN-Ko
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPpeb-0000az-P7
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:25 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:11 -0500
Message-Id: <1542895581-10721-7-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/16] virtio: init wrap counter for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 99565c6..74d9710 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1239,6 +1239,9 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].shadow_avail_idx = 0;
         vdev->vq[i].used_idx = 0;
+        vdev->vq[i].avail_wrap_counter = true;
+        vdev->vq[i].event_wrap_counter = true;
+        vdev->vq[i].used_wrap_counter = true;
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
-- 
1.8.3.1
