Received: from eggs.gnu.org ([2001:4830:134:3::10]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8r-0001Xi-9O
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8p-0005pE-GK
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8p-0005oS-9u
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:27 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:18 +0800
Message-Id: <1483092559-24488-10-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 09/10] memory: handle alias in
 memory_region_is_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/exec/memory.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 358edfb..bec9756 100644
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
