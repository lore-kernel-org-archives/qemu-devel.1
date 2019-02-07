Received: from eggs.gnu.org ([209.51.188.92]:57824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwW-0002ax-UG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwS-0002aT-T6
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwQ-0002XJ-2c
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id g67so816822wmd.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:30 +0100
Message-Id: <1549562254-41157-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 47/51] sparc64-softmmu.mak: express
 dependencies with Kconfig
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
