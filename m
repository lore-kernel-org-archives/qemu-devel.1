Received: from eggs.gnu.org ([2001:4830:134:3::10]:41925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRGfl-0004ww-OK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRGfi-0000jU-LW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:02:29 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 12:02:22 +0100
Message-Id: <1484132542-22520-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: sync pci-ids.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org

Three commits allocated pci ids in include/hw/pci/pci.h
without also updating docs/specs/pci-ids.txt:

  bf439db pci: Allocate PCIe host bridge PCI ID
  40d14be hw/pci: introduce PCI Expander Bridge (PXB)
  02b0743 hw/pxb: introduce pxb-pcie expander for PCIe machines

This patch updates pci-ids.txt accordingly.

Cc: qemu-trivial@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/pci-ids.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index fd27c67..16fdb0c 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -57,7 +57,10 @@ PCI devices (other than virtio):
 1b36:0005  PCI test device (docs/specs/pci-testdev.txt)
 1b36:0006  PCI Rocker Ethernet switch device
 1b36:0007  PCI SD Card Host Controller Interface (SDHCI)
+1b36:0008  PCIe host bridge
+1b36:0009  PCI Expander Bridge (-device pxb)
 1b36:000a  PCI-PCI bridge (multiseat)
+1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
 
 All these devices are documented in docs/specs.
 
-- 
1.8.3.1
