Received: from eggs.gnu.org ([209.51.188.92]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwf-0002gr-Rv
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwX-0002bw-9Q
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwU-0002Ua-RM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:32 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so805085wrs.8
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:24 +0100
Message-Id: <1549562254-41157-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 41/51] moxie-softmmu.mak: express dependencies
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

Moxie does not use VGA, ISA or RTC, and only has a memory-mapped
serial port.  Adjust for the correct dependencies.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/moxie-softmmu.mak | 7 ++-----
 hw/moxie/Kconfig                  | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
index 17ba906..bd50da3 100644
--- a/default-configs/moxie-softmmu.mak
+++ b/default-configs/moxie-softmmu.mak
@@ -1,8 +1,5 @@
 # Default configuration for moxie-softmmu
 
-CONFIG_ISA_BUS=y
-CONFIG_MC146818RTC=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_VGA=y
+# Boards:
+#
 CONFIG_MOXIESIM=y
diff --git a/hw/moxie/Kconfig b/hw/moxie/Kconfig
index 03f62e3..3793ef0 100644
--- a/hw/moxie/Kconfig
+++ b/hw/moxie/Kconfig
@@ -1,2 +1,3 @@
 config MOXIESIM
     bool
+    select SERIAL
-- 
1.8.3.1
