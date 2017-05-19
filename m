Received: from eggs.gnu.org ([2001:4830:134:3::10]:35476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYTB-00071C-JC
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYT8-0005d8-Ea
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYT8-0005cT-8L
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:46 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:45 +0800
Message-Id: <1495163989-9994-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1495163989-9994-1-git-send-email-peterx@redhat.com>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/10] intel_iommu: use IOMMU_ACCESS_FLAG()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We have that now, so why not use it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b477143..3240e5d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1010,7 +1010,7 @@ out:
     entry->iova = addr & page_mask;
     entry->translated_addr = vtd_get_slpte_addr(slpte) & page_mask;
     entry->addr_mask = ~page_mask;
-    entry->perm = (writes ? 2 : 0) + (reads ? 1 : 0);
+    entry->perm = IOMMU_ACCESS_FLAG(reads, writes);
 }
 
 static void vtd_root_table_setup(IntelIOMMUState *s)
-- 
2.7.4
