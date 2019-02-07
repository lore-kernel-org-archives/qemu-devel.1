Received: from eggs.gnu.org ([209.51.188.92]:57300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvs-0001tl-Et
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvr-0002Ca-Bh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-00028h-3W
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so828184wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:52 +0100
Message-Id: <1549562254-41157-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/51] ide: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-29-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak   |  2 --
 default-configs/hppa-softmmu.mak    |  1 -
 default-configs/pci.mak             |  3 ---
 default-configs/sparc64-softmmu.mak |  1 -
 hw/ide/Kconfig                      | 15 +++++++++++++++
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 74501ca..3fd656e 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -11,8 +11,6 @@ CONFIG_PARALLEL=y
 CONFIG_FDC=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
-CONFIG_IDE_CORE=y
-CONFIG_IDE_QDEV=y
 CONFIG_VMWARE_VGA=y
 CONFIG_IDE_CMD646=y
 CONFIG_I8259=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index b594a6d..e0a6cdc 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -5,7 +5,6 @@ CONFIG_SERIAL_ISA=y
 CONFIG_ISA_BUS=y
 CONFIG_I8259=y
 CONFIG_E1000_PCI=y
-CONFIG_IDE_ISA=y
 CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
 CONFIG_VIRTIO_VGA=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 3d4c71d..41af5e7 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -23,9 +23,6 @@ CONFIG_MPTSAS_SCSI_PCI=y
 CONFIG_RTL8139_PCI=y
 CONFIG_E1000_PCI=y
 CONFIG_E1000E_PCI_EXPRESS=y
-CONFIG_IDE_CORE=y
-CONFIG_IDE_QDEV=y
-CONFIG_IDE_PCI=y
 CONFIG_AHCI=y
 CONFIG_ESP=y
 CONFIG_ESP_PCI=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 415d4e0..b17513b 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -9,7 +9,6 @@ CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
 CONFIG_PCKBD=y
 CONFIG_FDC=y
-CONFIG_IDE_ISA=y
 CONFIG_IDE_CMD646=y
 CONFIG_PCI_SABRE=y
 CONFIG_SIMBA=y
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 5ec4495..fe27705 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -3,33 +3,48 @@ config IDE_CORE
 
 config IDE_QDEV
     bool
+    select IDE_CORE
 
 config IDE_PCI
     bool
+    select IDE_CORE
 
 config IDE_ISA
     bool
+    select IDE_QDEV
 
 config IDE_PIIX
     bool
+    select IDE_PCI
+    select IDE_QDEV
 
 config IDE_CMD646
     bool
+    select IDE_PCI
+    select IDE_QDEV
 
 config IDE_MACIO
     bool
+    select IDE_QDEV
 
 config IDE_MMIO
     bool
+    select IDE_QDEV
 
 config IDE_VIA
     bool
+    select IDE_PCI
+    select IDE_QDEV
 
 config MICRODRIVE
     bool
+    select IDE_QDEV
 
 config AHCI
     bool
+    select IDE_QDEV
 
 config IDE_SII3112
     bool
+    select IDE_PCI
+    select IDE_QDEV
-- 
1.8.3.1
