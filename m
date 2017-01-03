Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJY0-0002wN-V5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOJXw-0008If-26
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOJXv-0008IG-SZ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 02:30:11 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  3 Jan 2017 15:29:40 +0800
Message-Id: <1483428594-28880-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1483428594-28880-1-git-send-email-peterx@redhat.com>
References: <1483428594-28880-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 03/17] memory: handle alias in
 memory_region_is_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

From: Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 64560f6..958f4b2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -628,6 +628,9 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  */
 static inline bool memory_region_is_iommu(MemoryRegion *mr)
 {
+    if (mr->alias) {
+        return memory_region_is_iommu(mr->alias);
+    }
     return mr->iommu_ops;
 }
 
-- 
2.7.4
