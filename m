Received: from eggs.gnu.org ([209.51.188.92]:47740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzl-0003mN-0p
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzj-0008Ix-DS
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzj-0008GJ-6c
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:55 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:20 -0500
Message-Id: <1547663480-547-16-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/15] virtio: enable packed ring via a new
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07..cb286bb 100644
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
