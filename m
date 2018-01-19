Received: from eggs.gnu.org ([2001:4830:134:3::10]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYFy-0001vs-MF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYFx-0004nX-RW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:07:02 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 14:49:12 +0000
Message-Id: <1516373355-305-20-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
References: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 19/22] memory.h: Add set_page_size_mask
 IOMMUMemoryRegion callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This callback allows to inform the IOMMU memory region about
restrictions on the supported page sizes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/exec/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index a4cabdf..c0916d7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -204,6 +204,10 @@ typedef struct IOMMUMemoryRegionClass {
                                IOMMUAccessFlags flag);
     /* Returns minimum supported page size */
     uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
+
+    /* Limits the supported page sizes to @pgsizes */
+    void (*set_page_size_mask)(IOMMUMemoryRegion *iommu, uint64_t pgsizes);
+
     /* Called when IOMMU Notifier flag changed */
     void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
-- 
1.9.1
