Received: from eggs.gnu.org ([2001:4830:134:3::10]:54269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0006LV-Er
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZM-0008PG-B9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Date: Thu, 8 Feb 2018 21:09:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-20-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/26] virtio-balloon: unref the memory region
 before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Tiwei Bie <tiwei.bie@intel.com>, qemu-stable@nongnu.org

From: Tiwei Bie <tiwei.bie@intel.com>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 14e08d2..f2104bf 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -234,6 +234,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
                 memory_region_is_rom(section.mr) ||
                 memory_region_is_romd(section.mr)) {
                 trace_virtio_balloon_bad_addr(pa);
+                memory_region_unref(section.mr);
                 continue;
             }
 
-- 
MST
