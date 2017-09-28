Received: from eggs.gnu.org ([2001:4830:134:3::10]:39031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxVUu-0000pr-1s
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxVUq-0001sT-RH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxVUq-0001sF-LI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:44 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Sep 2017 11:52:41 +0200
Message-Id: <1506592361-26168-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] default-configs: Enable CONFIG_VMXNET3_PCI
 only on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org

The device can not be instantiated on many non-x86 and just prints
some error messages, e.g.:

$ qemu-system-ppc64 -device vmxnet3 -M g3beige
[vmxnet3][WR][vmxnet3_init_msix]: Failed to initialize MSI-X, error -95
[vmxnet3][WR][vmxnet3_pci_realize]: Failed to initialize MSI-X, configuration is inconsistent.

Since vmxnet3 is a para-virtualized device that is only useful on x86,
it should also only be enabled on the x86 targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/i386-softmmu.mak   | 1 +
 default-configs/pci.mak            | 1 -
 default-configs/x86_64-softmmu.mak | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index d2ab2f6..a685c43 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -7,6 +7,7 @@ CONFIG_QXL=$(CONFIG_SPICE)
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
+CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_VMMOUSE=y
 CONFIG_IPMI=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 187e438..e514bde 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -22,7 +22,6 @@ CONFIG_MPTSAS_SCSI_PCI=y
 CONFIG_RTL8139_PCI=y
 CONFIG_E1000_PCI=y
 CONFIG_E1000E_PCI=y
-CONFIG_VMXNET3_PCI=y
 CONFIG_IDE_CORE=y
 CONFIG_IDE_QDEV=y
 CONFIG_IDE_PCI=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 9bde2f1..ea69e82 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -7,6 +7,7 @@ CONFIG_QXL=$(CONFIG_SPICE)
 CONFIG_VGA_ISA=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
+CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_VMMOUSE=y
 CONFIG_IPMI=y
-- 
1.8.3.1
