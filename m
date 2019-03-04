Received: from eggs.gnu.org ([209.51.188.92]:46000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCk-00027R-Md
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCi-0004Oe-9n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:46 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCg-0004JL-AA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:44 -0500
Received: by mail-wr1-x42b.google.com with SMTP id l5so6631390wrw.6
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:45 +0100
Message-Id: <1551723614-1823-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/54] virtio: express virtio dependencies with
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-42-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak  |  1 -
 default-configs/s390x-softmmu.mak |  1 -
 default-configs/virtio.mak        | 11 -----------
 hw/block/Kconfig                  |  2 ++
 hw/char/Kconfig                   |  2 ++
 hw/display/Kconfig                |  2 +-
 hw/input/Kconfig                  |  4 +++-
 hw/net/Kconfig                    |  2 ++
 hw/scsi/Kconfig                   |  2 ++
 hw/virtio/Kconfig                 |  7 +++++++
 hw/virtio/Makefile.objs           |  2 ++
 11 files changed, 21 insertions(+), 15 deletions(-)
 delete mode 100644 default-configs/virtio.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index c0826f5..53e9d5e 100644
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
index 2794ffb..2be5059 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=y
-include virtio.mak
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
deleted file mode 100644
index 7e6d467..0000000
--- a/default-configs/virtio.mak
+++ /dev/null
@@ -1,11 +0,0 @@
-CONFIG_VIRTIO=y
-CONFIG_VIRTIO_BALLOON=y
-CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_CRYPTO=y
-CONFIG_VIRTIO_GPU=y
-CONFIG_EDID=y
-CONFIG_VIRTIO_INPUT=y
-CONFIG_VIRTIO_NET=y
-CONFIG_VIRTIO_RNG=y
-CONFIG_VIRTIO_SCSI=y
-CONFIG_VIRTIO_SERIAL=y
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 0aa82ac..f89e4eb 100644
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
index fc18481..6360c9f 100644
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
index 5529d0f..e126cbb 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -95,7 +95,7 @@ config QXL
 
 config VIRTIO_GPU
     bool
-    default y if PCI_DEVICES
+    default y
     depends on VIRTIO
     select EDID
 
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index e05b7be..e2e66f0 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -21,11 +21,13 @@ config TSC2005
 
 config VIRTIO_INPUT
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_INPUT_HOST
     bool
     default y
-    depends on LINUX
+    depends on VIRTIO && LINUX
 
 config TSC210X
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 86b880b..c562b69 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -95,6 +95,8 @@ config XILINX_ETHLITE
 
 config VIRTIO_NET
     bool
+    default y
+    depends on VIRTIO
 
 config ETSEC
     bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index a696ff0..c0031a4 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -43,6 +43,8 @@ config SPAPR_VSCSI
 
 config VIRTIO_SCSI
     bool
+    default y
+    depends on VIRTIO
     select SCSI
 
 config VHOST_USER_SCSI
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 5dafbe3..74f4573 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -3,6 +3,8 @@ config VIRTIO
 
 config VIRTIO_RNG
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_PCI
     bool
@@ -12,9 +14,14 @@ config VIRTIO_PCI
 
 config VIRTIO_MMIO
     bool
+    select VIRTIO
 
 config VIRTIO_BALLOON
     bool
+    default y
+    depends on VIRTIO
 
 config VIRTIO_CRYPTO
     bool
+    default y
+    depends on VIRTIO
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index a3eb8ed..f2ab667 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -29,6 +29,8 @@ obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
 obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
 endif
+else
+common-obj-y += vhost-stub.o
 endif
 
 common-obj-$(CONFIG_ALL) += vhost-stub.o
-- 
1.8.3.1
