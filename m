Received: from eggs.gnu.org ([2001:4830:134:3::10]:50141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eec4K-00020c-7u
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 02:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eec4H-0000jy-5o
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 02:35:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:25189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eec4G-0000jY-O9
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 02:35:29 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 25 Jan 2018 15:12:43 +0800
Message-Id: <20180125071243.2720-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH] virtio-balloon: unref the memory region before
 continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 14e08d20d0..f2104bfcef 100644
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
2.13.3
