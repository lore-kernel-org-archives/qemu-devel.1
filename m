Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFl-00088w-HQ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFk-0005U1-PX
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNAFk-0005Tr-JY
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C65B57970A
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 04:27:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  8 Dec 2017 12:26:54 +0800
Message-Id: <20171208042654.10910-3-peterx@redhat.com>
In-Reply-To: <20171208042654.10910-1-peterx@redhat.com>
References: <20171208042654.10910-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] intel_iommu: fix error param in string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

It should be caching-mode.  It may confuse people when it pops up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c1fa08d205..fe15d3ba84 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2327,7 +2327,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     IntelIOMMUNotifierNode *next_node = NULL;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set cache_mode=1 for intel-iommu to enable "
+        error_report("We need to set caching-mode=1 for intel-iommu to enable "
                      "device assignment with IOMMU protection.");
         exit(1);
     }
-- 
2.14.3
