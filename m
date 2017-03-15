Received: from eggs.gnu.org ([2001:4830:134:3::10]:50884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF6-0003KO-2U
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF4-0006xg-6L
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:48 -0400
Received: from mail.kernel.org ([198.145.29.136]:59188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF4-0006x9-0Z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:46 -0400
Date: Wed, 15 Mar 2017 20:01:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-7-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] Revert "virtio: unbreak virtio-pci with
 IOMMU after caching ring translations"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Jason Wang <jasowang@redhat.com>

This reverts commit
96a8821d21411f10d77ea994af369c6e5c35a2cc. Previous patch is a better
solution which does not require a strict order between virtio and IOMMU.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b76f3f6..5ce42af 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1153,7 +1153,7 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     PCIDevice *dev = &proxy->pci_dev;
 
-    return pci_device_iommu_address_space(dev);
+    return pci_get_address_space(dev);
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
-- 
MST
