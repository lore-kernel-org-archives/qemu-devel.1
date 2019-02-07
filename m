Received: from eggs.gnu.org ([209.51.188.92]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwR-0002Us-5V
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwP-0002Xv-4s
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwL-0002TQ-EP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id y185so4952428wmd.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:20 +0100
Message-Id: <1549562254-41157-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 37/51] hppa-softmmu.mak: express dependencies
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
Cc: thuth@redhat.com, philmd@redhat.com

%-softmmu.mak only keep boards and optional device
definitions in Kconfig mode.

Note that the Dino board uses a memory mapped 16550 UART and
therefore only CONFIG_SERIAL is needed, not CONFIG_SERIAL_ISA.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/hppa-softmmu.mak | 20 ++++++++------------
 hw/hppa/Kconfig                  |  8 ++++++++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index b7f2b43..b64c5eb 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,13 +1,9 @@
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_ISA_BUS=y
-CONFIG_I8259=y
-CONFIG_E1000_PCI=y
-CONFIG_IDE_CMD646=y
-# CONFIG_IDE_MMIO=y
-CONFIG_LSI_SCSI_PCI=y
-CONFIG_VIRTIO_VGA=y
-CONFIG_MC146818RTC=y
+# Default configuration for hppa-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+
+# Boards:
+#
 CONFIG_DINO=y
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 5ce48ef..2d9b072 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -1,2 +1,10 @@
 config DINO
     bool
+    imply PCI_DEVICES
+    select PCI
+    select SERIAL
+    select ISA_BUS
+    select I8259
+    select IDE_CMD646
+    select MC146818RTC
+    select LSI_SCSI_PCI
-- 
1.8.3.1
