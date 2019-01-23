Received: from eggs.gnu.org ([209.51.188.92]:60047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCW2-0004hz-5H
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCW1-0003dt-7l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCW0-0002Mh-VS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:01 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:02 +0800
Message-Id: <20190123065618.3520-29-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 28/44] ide: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/alpha-softmmu.mak |  2 --
 default-configs/pci.mak           |  3 ---
 hw/ide/Kconfig                    | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index c570caccd1..400dff3c1c 100644
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
index fb63ea39a2..f7b3690bbd 100644
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
index 5ec449525f..fe27705790 100644
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
2.17.1
