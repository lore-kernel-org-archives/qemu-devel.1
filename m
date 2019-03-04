Received: from eggs.gnu.org ([209.51.188.92]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDC-0002Xp-Sn
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDA-0005FV-7e
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD7-0004g1-G7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:11 -0500
Received: by mail-wm1-x343.google.com with SMTP id f65so137668wma.2
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:59 +0100
Message-Id: <1551723614-1823-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/54] hppa-softmmu.mak: express dependencies
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

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
