Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcx6-0005Kl-Hc
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcx5-0006RE-Ik
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:18:00 -0500
Received: from ozlabs.ru ([107.173.13.209]:60490)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcx5-0006Qz-C6
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:17:59 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 12 Dec 2017 16:17:26 +1100
Message-Id: <20171212051726.24520-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] vfio-pci: Remove unused fields from
 VFIOMSIXInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>

When support for multiple mappings per a region were added, this was
left behind, let's finish and remove unused bits.

Fixes: db0da029a185 "vfio: Generalize region support"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* updated commit log

---
 hw/vfio/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 502a575..a8fb3b3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -93,8 +93,6 @@ typedef struct VFIOMSIXInfo {
     uint16_t entries;
     uint32_t table_offset;
     uint32_t pba_offset;
-    MemoryRegion mmap_mem;
-    void *mmap;
     unsigned long *pending;
 } VFIOMSIXInfo;
 
-- 
2.11.0
