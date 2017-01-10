Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA4-0007Q9-7W
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA3-0005bZ-LI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:56 -0500
Received: from mail.kernel.org ([198.145.29.136]:47900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpA3-0005bS-FG
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:55 -0500
Date: Tue, 10 Jan 2017 07:39:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-13-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/41] memory: handle alias in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
MST
