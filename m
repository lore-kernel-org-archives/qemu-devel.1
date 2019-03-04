Received: from eggs.gnu.org ([209.51.188.92]:46479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDC-0002Xt-TN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD4-00057T-KD
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:14 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD3-0004sm-LT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id r5so6632384wrg.9
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:21:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:06 +0100
Message-Id: <1551723614-1823-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/54] riscv-softmmu.mak: replace CONFIG_* with
 Kconfig "select" directives
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

%-softmmu.mak only keep boards and optional device
definitions in Kconfig mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/riscv32-softmmu.mak | 21 ++++++---------------
 default-configs/riscv64-softmmu.mak | 22 ++--------------------
 hw/riscv/Kconfig                    | 13 +++++++++++++
 3 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index fd91efb..1ae077e 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,21 +1,12 @@
-# Default configuration for riscv-softmmu
+# Default configuration for riscv32-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_VIRTIO_MMIO=y
-
-CONFIG_CADENCE=y
-
-CONFIG_PCI_EXPRESS=y
-CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
-
-CONFIG_VGA=y
-CONFIG_VGA_PCI=y
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
 
+# Boards:
+#
 CONFIG_SPIKE=y
-CONFIG_HART=y
 CONFIG_SIFIVE_E=y
-CONFIG_SIFIVE=y
 CONFIG_SIFIVE_U=y
 CONFIG_RISCV_VIRT=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index fd91efb..235c6f4 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,21 +1,3 @@
-# Default configuration for riscv-softmmu
+# Default configuration for riscv64-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_VIRTIO_MMIO=y
-
-CONFIG_CADENCE=y
-
-CONFIG_PCI_EXPRESS=y
-CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
-
-CONFIG_VGA=y
-CONFIG_VGA_PCI=y
-
-CONFIG_SPIKE=y
-CONFIG_HART=y
-CONFIG_SIFIVE_E=y
-CONFIG_SIFIVE=y
-CONFIG_SIFIVE_U=y
-CONFIG_RISCV_VIRT=y
+include riscv32-softmmu.mak
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 4989589..e0ee304 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -9,12 +9,25 @@ config SIFIVE
 
 config SIFIVE_E
     bool
+    select HART
+    select SIFIVE
 
 config SIFIVE_U
     bool
+    select CADENCE
+    select HART
+    select SIFIVE
 
 config SPIKE
     bool
+    select HART
+    select HTIF
+    select SIFIVE
 
 config RISCV_VIRT
     bool
+    select HART
+    select SERIAL
+    select VIRTIO_MMIO
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select SIFIVE
-- 
1.8.3.1
