Received: from eggs.gnu.org ([2001:4830:134:3::10]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbek-00055U-6o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbef-00069q-4I
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeb-00067F-8e
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:31 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:34 -0400
Message-Id: <1539266915-15216-12-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 11/12] virtio: enable packed ring via a new
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

only userspace virtio net backend has been supported by
the CLI so far.

(cherry picked from commit 0b3ec96f4a9402cca467c40353066e57608ac6b6)
Signed-off-by: Wei Xu <wexu@redhat.com>
(cherry picked from commit a1a3b85f00299ccc6f4bc819abe470da88059fb7)
Signed-off-by: Wei Xu <wexu@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index e323e76..9af8839 100644
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
