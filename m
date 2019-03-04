Received: from eggs.gnu.org ([209.51.188.92]:46382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD7-0002UC-F7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD5-00059T-Oj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD3-0004cB-T5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id n19so141410wmi.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:57 +0100
Message-Id: <1551723614-1823-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/54] alpha-softmmu.mak: express dependencies
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak | 19 +++++++------------
 hw/alpha/Kconfig                  | 10 ++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 762e3a2..d186fe8 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,15 +1,10 @@
 # Default configuration for alpha-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_I82374=y
-CONFIG_I8254=y
-CONFIG_PCKBD=y
-CONFIG_VGA_CIRRUS=y
-CONFIG_VMWARE_VGA=y
-CONFIG_IDE_CMD646=y
-CONFIG_I8259=y
-CONFIG_MC146818RTC=y
-CONFIG_TEST_DEVICES=y
-CONFIG_SMC37C669=y
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+#CONFIG_TEST_DEVICES=n
+
+# Boards:
+#
 CONFIG_DP264=y
diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
index c5d0438..22cefd9 100644
--- a/hw/alpha/Kconfig
+++ b/hw/alpha/Kconfig
@@ -1,2 +1,12 @@
 config DP264
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select I82374
+    select I8254
+    select I8259
+    select IDE_CMD646
+    select MC146818RTC
+    select PCI
+    select PCKBD
+    select SMC37C669
-- 
1.8.3.1
