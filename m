Received: from eggs.gnu.org ([2001:4830:134:3::10]:36865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19N-0001pU-PV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19M-0004Ku-KF
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb19M-0004Jm-EM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:20 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  7 Feb 2017 16:28:11 +0800
Message-Id: <1486456099-7345-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/17] intel_iommu: vtd_slpt_level_shift
 check level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

This helps in debugging incorrect level passed in.

Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ad304f6..22d8226 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -168,6 +168,7 @@ static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
 /* The shift of an addr for a certain level of paging structure */
 static inline uint32_t vtd_slpt_level_shift(uint32_t level)
 {
+    assert(level != 0);
     return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_SL_LEVEL_BITS;
 }
 
-- 
2.7.4
