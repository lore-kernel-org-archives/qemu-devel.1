Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHPe0-0005Rx-P2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 02:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHPdw-0006zV-SY
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 02:40:28 -0500
Received: from ozlabs.ru ([107.173.13.209]:33586)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHPdw-0006z1-Lv
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 02:40:24 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 22 Nov 2017 18:39:47 +1100
Message-Id: <20171122073947.19325-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio-pci: Remove unused fields from
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c5e168e..06dcf99 100644
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
