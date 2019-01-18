Received: from eggs.gnu.org ([209.51.188.92]:37041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSJI-00022q-4G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSJH-0007sG-5m
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:47043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSJG-0005tr-TB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:39 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:24:07 +0800
Message-Id: <20190118112410.3010-41-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 40/43] virtio: make virtio dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/i386-softmmu.mak  |  1 -
 default-configs/s390x-softmmu.mak |  1 -
 default-configs/virtio.mak        | 14 --------------
 hw/9pfs/Kconfig                   |  2 ++
 hw/block/Kconfig                  |  2 ++
 hw/char/Kconfig                   |  2 ++
 hw/display/Kconfig                |  5 +++++
 hw/input/Kconfig                  |  2 ++
 hw/net/Kconfig                    |  2 ++
 hw/pci-host/Kconfig               |  2 ++
 hw/scsi/Kconfig                   |  1 +
 hw/virtio/Kconfig                 |  9 ++++++++-
 12 files changed, 26 insertions(+), 17 deletions(-)
 delete mode 100644 default-configs/virtio.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index ab57978b9a..992aea8f30 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,7 +1,6 @@
 # Default configuration for i386-softmmu
 
 CONFIG_VMXNET3_PCI=y
-CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 5eef375924..6640af2ec2 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
-include virtio.mak
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
deleted file mode 100644
index 1304849018..0000000000
--- a/default-configs/virtio.mak
+++ /dev/null
@@ -1,14 +0,0 @@
-CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
-CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
-CONFIG_VIRTIO=y
-CONFIG_VIRTIO_9P=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_CRYPTO=y
-CONFIG_VIRTIO_GPU=y
-CONFIG_VIRTIO_INPUT=y
-CONFIG_VIRTIO_NET=y
-CONFIG_VIRTIO_RNG=y
-CONFIG_SCSI=y
-CONFIG_VIRTIO_SCSI=y
-CONFIG_VIRTIO_SERIAL=y
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index a4750999d9..d85869ca81 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -1,2 +1,4 @@
 config VIRTIO_9P
     bool
+    default y
+    depends on VIRTIO
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 83c2be5915..771967ad9f 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -28,6 +28,8 @@ config NVME_PCI
 
 config VIRTIO_BLK
     bool
+    default y
+    depends on VIRTIO
 
 config VHOST_USER_BLK
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 56c1177f95..9836739679 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -26,6 +26,8 @@ config SERIAL_PCI
 
 config VIRTIO_SERIAL
     bool
+    default y
+    depends on VIRTIO
 
 config STM32F2XX_USART
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 933793cc13..a80c0eace6 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -93,9 +93,14 @@ config QXL
 
 config VIRTIO_GPU
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_VGA
     bool
+    default y
+    depends on VIRTIO && PCI
+    select VGA
 
 config DPCD
     bool
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 5d64e07fc6..7434a14cb0 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -21,6 +21,8 @@ config TSC2005
 
 config VIRTIO_INPUT
     bool
+    default y
+    depends on VIRTIO
 
 config TSC210X
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index b54577e00b..94761f0d7e 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -94,6 +94,8 @@ config XILINX_ETHLITE
 
 config VIRTIO_NET
    bool
+   default y
+   depends on VIRTIO
 
 config ETSEC
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 84670ee37c..ee0111d061 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -22,6 +22,7 @@ config PCI_SABRE
 config PCI_PIIX
     bool
     select PCI
+    select VIRTIO
 
 config PCI_Q35
     bool
@@ -30,6 +31,7 @@ config PCI_Q35
     select XIO3130
     select IOH3420
     select I82801B11
+    select VIRTIO
 
 config PCI_GENERIC
     bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 7a9d373382..22281213ba 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -43,6 +43,7 @@ config SPAPR_VSCSI
 config VIRTIO_SCSI
     bool
     default y
+    depends on VIRTIO
     select SCSI
 
 config VHOST_USER_SCSI
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aabd6d4d96..a684de9af4 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -3,18 +3,25 @@ config VIRTIO
 
 config VIRTIO_RNG
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_PCI
     bool
     default y
     depends on PCI
-    select VIRTIO
+    depends on VIRTIO
 
 config VIRTIO_MMIO
     bool
+    depends on VIRTIO
 
 config VIRTIO_BALLOON
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_CRYPTO
     bool
+    default y
+    depends on VIRTIO
-- 
2.17.1
