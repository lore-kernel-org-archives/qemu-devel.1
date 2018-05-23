Received: from eggs.gnu.org ([2001:4830:134:3::10]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyX-0001Vj-3T
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyU-0000iT-Pz
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyU-0000iK-L1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:46 -0400
Date: Wed, 23 May 2018 17:42:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-3-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/28] allocate pci id for mdpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Gerd Hoffmann <kraxel@redhat.com>

mdpy is a sample pci device for vfio-mdev.  Not (yet) merged upstream,
patch available here:

https://www.kraxel.org/cgit/linux/commit/?h=vfio-sample-display&id=6fd86cff3d7df38ab89625b16fdd6434b1c18749

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/pci-ids.txt | 1 +
 include/hw/pci/pci.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index bb99a02..4d53e5c 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -62,6 +62,7 @@ PCI devices (other than virtio):
 1b36:000a  PCI-PCI bridge (multiseat)
 1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
 1b36:000d  PCI xhci usb host adapter
+1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
 
 All these devices are documented in docs/specs.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a9c3ee5..990d6fc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -101,6 +101,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
+#define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
MST
