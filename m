Received: from eggs.gnu.org ([209.51.188.92]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCi-00024f-7i
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCg-0004M3-C0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:44 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCe-0004HP-MM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:41 -0500
Received: by mail-wr1-x42d.google.com with SMTP id q1so6646752wrp.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:44 +0100
Message-Id: <1551723614-1823-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/54] vfio: express vfio dependencies with
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 --
 hw/vfio/Kconfig                 | 13 ++++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b7b0542..40e1a1a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -123,8 +123,6 @@ CONFIG_VERSATILE_I2C=y
 
 CONFIG_PCI_EXPRESS=y
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
-CONFIG_VFIO_XGMAC=y
-CONFIG_VFIO_AMD_XGBE=y
 
 CONFIG_SDHCI=y
 CONFIG_INTEGRATOR=y
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 0fdff10..ebda9fd 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -9,21 +9,28 @@ config VFIO_PCI
 
 config VFIO_CCW
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && S390_CCW_VIRTIO
 
 config VFIO_PLATFORM
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && PLATFORM_BUS
 
 config VFIO_XGMAC
     bool
+    default y
+    depends on VFIO_PLATFORM
 
 config VFIO_AMD_XGBE
     bool
+    default y
+    depends on VFIO_PLATFORM
 
 config VFIO_AP
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && S390_CCW_VIRTIO
-- 
1.8.3.1
