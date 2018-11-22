Received: from eggs.gnu.org ([2001:4830:134:3::10]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPphD-0007Jz-GX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPphC-0001ee-Bm
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPphC-0001bE-4o
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:06 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:21 -0500
Message-Id: <1542895581-10721-17-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v1 16/16] virtio: enable packed ring via a new
 command line
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
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index a6fdf3f..36fc4ef 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -264,7 +264,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
+                      VIRTIO_F_IOMMU_PLATFORM, false), \
+    DEFINE_PROP_BIT64("ring_packed", _state, _field, \
+                      VIRTIO_F_RING_PACKED, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
1.8.3.1
