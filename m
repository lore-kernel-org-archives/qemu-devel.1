Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWR-0002XB-E4
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWQ-0006eT-Hp
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWQ-0006eA-CL
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:26 -0400
Date: Sun, 15 Oct 2017 06:23:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-15-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/26] PCI: PCIe access should always be little
 endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Matt Redfearn <matt.redfearn@imgtec.com>

PCIe busses are always little endian, so set the endianness of the
memory region to little endian rather than native such that operations
work as expected on big endian targets.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index dcebf57..553db56 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -81,7 +81,7 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
 static const MemoryRegionOps pcie_mmcfg_ops = {
     .read = pcie_mmcfg_data_read,
     .write = pcie_mmcfg_data_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pcie_host_init(Object *obj)
-- 
MST
