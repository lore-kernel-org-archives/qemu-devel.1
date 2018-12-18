Received: from eggs.gnu.org ([2001:4830:134:3::10]:51146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pb-0005W6-O7
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pa-0007OD-3q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6pZ-0007N2-SG
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:06 -0500
Date: Mon, 17 Dec 2018 23:18:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-19-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 18/31] intel_iommu: dump correct iova when failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

The iotlb.iova can be zero if failure really happened.  Dump the addr
instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d97bcbc2f7..f21988f396 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2540,7 +2540,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                           __func__, pci_bus_num(vtd_as->bus),
                           VTD_PCI_SLOT(vtd_as->devfn),
                           VTD_PCI_FUNC(vtd_as->devfn),
-                          iotlb.iova);
+                          addr);
     }
 
     return iotlb;
-- 
MST
