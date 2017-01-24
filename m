Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqG-0000fr-BY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqC-00006S-Io
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:24 +0300
Message-Id: <6e7ae46c2c12c3fef093792ca1aff2d4fcf30868.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 20/31] docs: sync pci-ids.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Gerd Hoffmann <kraxel@redhat.com>

Three commits allocated pci ids in include/hw/pci/pci.h
without also updating docs/specs/pci-ids.txt:

  bf439db pci: Allocate PCIe host bridge PCI ID
  40d14be hw/pci: introduce PCI Expander Bridge (PXB)
  02b0743 hw/pxb: introduce pxb-pcie expander for PCIe machines

This patch updates pci-ids.txt accordingly.

Cc: qemu-trivial@nongnu.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.1.4
