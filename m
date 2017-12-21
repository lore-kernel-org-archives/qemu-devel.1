Received: from eggs.gnu.org ([2001:4830:134:3::10]:48715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1vO-0003Zd-U8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1vO-00018j-4N
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:34:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1vN-00018M-Tu
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:34:18 -0500
Date: Thu, 21 Dec 2017 16:34:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-23-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/25] intel_iommu: fix error param in string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Yi L <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

It should be caching-mode.  It may confuse people when it pops up.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c1fa08d..fe15d3b 100644
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
MST
