Received: from eggs.gnu.org ([208.118.235.92]:55117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPHG-00041P-Ur
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPH9-0005We-B9
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPH6-0004B3-RM
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:09 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:15 +0800
Message-Id: <20181227063419.12981-22-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 21/25] virtio: make virtio dependencies
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
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak |  1 -
 hw/9pfs/Kconfig                  |  2 ++
 hw/block/Kconfig                 |  2 ++
 hw/char/Kconfig                  |  2 ++
 hw/display/Kconfig               |  5 +++++
 hw/input/Kconfig                 |  2 ++
 hw/net/Kconfig                   |  2 ++
 hw/pci-host/Kconfig              |  2 ++
 hw/virtio/Kconfig                | 10 +++++++++-
 9 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index eb2d22de3c..d3488b5a6d 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,7 +1,6 @@
 # Default configuration for i386-softmmu
 
 CONFIG_VMXNET3_PCI=y
-CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
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
index 26765599a5..e2b56a178c 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -25,6 +25,8 @@ config SERIAL_PCI
 
 config VIRTIO_SERIAL
     bool
+    default y
+    depends on VIRTIO
 
 config STM32F2XX_USART
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 8b8f1027b1..38629b8e1b 100644
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
index b50a8a4368..8b65de1d7f 100644
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
index 9d57c6cac9..d7af6aa441 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -23,6 +23,7 @@ config PCI_PIIX
     bool
     select PAM
     select PCI
+    select VIRTIO
 
 config PCI_Q35
     bool
@@ -31,6 +32,7 @@ config PCI_Q35
     select XIO3130
     select IOH3420
     select I82801B11
+    select VIRTIO
 
 config PCI_GENERIC
     bool
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aabd6d4d96..9127daed5e 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -3,18 +3,26 @@ config VIRTIO
 
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
+    default y
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
