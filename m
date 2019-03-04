Received: from eggs.gnu.org ([209.51.188.92]:46388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD7-0002UE-GV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD6-0005Ai-4L
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD5-00050v-Ny
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id i12so6644210wrw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:21:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:10 +0100
Message-Id: <1551723614-1823-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/54] sparc64-softmmu.mak: express dependencies
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
 default-configs/sparc64-softmmu.mak | 23 ++++++++---------------
 hw/sparc64/Kconfig                  | 13 +++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 528af8f..e50030a 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -1,19 +1,12 @@
 # Default configuration for sparc64-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_M48T59=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_PARALLEL=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
-CONFIG_IDE_CMD646=y
-CONFIG_PCI_SABRE=y
-CONFIG_SIMBA=y
-CONFIG_SUNHME=y
-CONFIG_MC146818RTC=y
-CONFIG_TEST_DEVICES=y
-CONFIG_SUN4V_RTC=y
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+#CONFIG_SUNHME=n
+#CONFIG_TEST_DEVICES=n
+
+# Boards:
+#
 CONFIG_SUN4U=y
 CONFIG_NIAGARA=y
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index 41f7295..4a8166e 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -1,6 +1,19 @@
 config SUN4U
     bool
+    imply PCI_DEVICES
+    imply SUNHME
+    imply TEST_DEVICES
+    select M48T59
     select ISA_BUS
+    select FDC
+    select SERIAL_ISA
+    select PCI_SABRE
+    select IDE_CMD646
+    select PARALLEL
+    select PCKBD
+    select SIMBA
 
 config NIAGARA
     bool
+    select EMPTY_SLOT
+    select SUN4V_RTC
-- 
1.8.3.1
