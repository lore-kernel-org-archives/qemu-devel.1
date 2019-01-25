Received: from eggs.gnu.org ([209.51.188.92]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOu-0007kS-1f
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOs-00020Y-4T
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOr-0001zK-Q3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id u4so9641258wrp.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:54 +0100
Message-Id: <1548410831-19553-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 35/52] ide: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-29-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak |  2 --
 default-configs/pci.mak           |  3 ---
 hw/ide/Kconfig                    | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 49cb7ce..fc4afeb 100644
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
