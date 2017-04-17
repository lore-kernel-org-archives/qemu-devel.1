Received: from eggs.gnu.org ([2001:4830:134:3::10]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04uQ-0001ob-AV
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04uP-0003wH-Gb
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d04uP-0003vo-As
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:29 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Apr 2017 19:32:09 +0800
Message-Id: <1492428730-13438-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1492428730-13438-1-git-send-email-peterx@redhat.com>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/7] intel_iommu: use IOMMU_ACCESS_FLAG()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

We have that now, so why not use it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c8751ba..05ae631 100644
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
