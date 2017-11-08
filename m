Received: from eggs.gnu.org ([2001:4830:134:3::10]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCS9Y-0006QY-GC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCS9V-0005F0-B3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:20:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eCS9V-0005Ek-4Q
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:20:29 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  8 Nov 2017 17:20:23 +0200
Message-Id: <20171108152023.80780-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH] hw/pcie-pci-bridge: restrict to X86 and ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, thuth@redhat.com, zuban32s@gmail.com, cohuck@redhat.com

The PCIE-PCI bridge is specific to "pure" PCI systems
(on QEMU we have X86 and ARM), it does not make sense to
have if in other archs.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 default-configs/arm-softmmu.mak    | 1 +
 default-configs/i386-softmmu.mak   | 1 +
 default-configs/x86_64-softmmu.mak | 1 +
 hw/pci-bridge/Makefile.objs        | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5059d134c8..33934b1dc4 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -122,6 +122,7 @@ CONFIG_FSL_IMX25=y
 CONFIG_IMX_I2C=y
 
 CONFIG_PCIE_PORT=y
+CONFIG_PCIE_PCI_BRIDGE=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index a685c439e7..0d2ce8bcc9 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -59,4 +59,5 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
+CONFIG_PCIE_PCI_BRIDGE=y
 CONFIG_ACPI_VMGENID=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index ea69e8289e..846a72b930 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -59,4 +59,5 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
+CONFIG_PCIE_PCI_BRIDGE=y
 CONFIG_ACPI_VMGENID=y
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 666db37da2..9d23a7038a 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,6 +1,7 @@
-common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
+common-obj-y += pci_bridge_dev.o
 common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
 common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
+common-obj-$(CONFIG_PCIE_PCI_BRIDGE) += pcie_pci_bridge.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
 common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
-- 
2.13.5
