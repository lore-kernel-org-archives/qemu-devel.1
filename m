Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iB-0001me-DN
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iA-0008TQ-IN
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:35 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:29 -0500
Message-Id: <20180619014319.28272-4-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 003/113] virtio-balloon: unref the memory
 region before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tiwei Bie <tiwei.bie@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Tiwei Bie <tiwei.bie@intel.com>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit b86107ab43b804e899a226fe287e34ab8acef596)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38982..651fa70ca6 100644
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
2.11.0
