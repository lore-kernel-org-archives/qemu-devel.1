Received: from eggs.gnu.org ([2001:4830:134:3::10]:42300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eeYw6-0008FF-O1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eeYw2-0007mb-Px
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:14:50 -0500
Received: from ozlabs.ru ([107.173.13.209]:54240)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eeYw2-0007lU-KB
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:14:46 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 25 Jan 2018 15:14:11 +1100
Message-Id: <20180125041411.6647-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio/common: Remove redundand copy of
 local variable
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

There is already @hostwin in vfio_listener_region_add() so there is no
point in having the other one.

Fixes: 2e4109de "vfio/spapr: Create DMA window dynamically (SPAPR IOMMU v2)"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a..3d652c8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -435,7 +435,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
     end = int128_get64(int128_sub(llend, int128_one()));
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        VFIOHostDMAWindow *hostwin;
         hwaddr pgsize = 0;
 
         /* For now intersections are not allowed, we may relax this later */
-- 
2.11.0
