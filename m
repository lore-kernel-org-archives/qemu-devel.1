Received: from eggs.gnu.org ([208.118.235.92]:54771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGQ-0002xE-IH
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGN-0004Lm-SS
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:57851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGN-00041J-Gc
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:23 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:03 +0800
Message-Id: <20181227063419.12981-10-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 09/25] ide: express dependencies with
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
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/pci.mak |  3 ---
 hw/ide/Kconfig          | 11 +++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 171bdf48bc..c1b64922b9 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -23,9 +23,6 @@ CONFIG_MPTSAS_SCSI_PCI=y
 CONFIG_RTL8139_PCI=y
 CONFIG_E1000_PCI=y
 CONFIG_E1000E_PCI=y
-CONFIG_IDE_CORE=y
-CONFIG_IDE_QDEV=y
-CONFIG_IDE_PCI=y
 CONFIG_AHCI=y
 CONFIG_ESP=y
 CONFIG_ESP_PCI=y
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 5ec449525f..091f3a81c9 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -3,33 +3,44 @@ config IDE_CORE
 
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
+    select IDE_QDEV
 
 config IDE_CMD646
     bool
+    select IDE_QDEV
 
 config IDE_MACIO
     bool
+    select IDE_QDEV
 
 config IDE_MMIO
     bool
+    select IDE_QDEV
 
 config IDE_VIA
     bool
+    select IDE_QDEV
 
 config MICRODRIVE
     bool
+    select IDE_QDEV
 
 config AHCI
     bool
+    select IDE_QDEV
 
 config IDE_SII3112
     bool
+    select IDE_QDEV
-- 
2.17.1
