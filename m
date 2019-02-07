Received: from eggs.gnu.org ([209.51.188.92]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002oW-JR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwp-0002i0-KM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwp-0002Ye-9N
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id h22so4957567wmb.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:32 +0100
Message-Id: <1549562254-41157-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 49/51] xtensa-softmmu.mak: express dependencies
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/xtensa-softmmu.mak   | 6 ++----
 default-configs/xtensaeb-softmmu.mak | 7 +------
 hw/xtensa/Kconfig                    | 3 +++
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index baf90ca..6c1e898 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -1,8 +1,6 @@
 # Default configuration for Xtensa
 
-CONFIG_SERIAL=y
-CONFIG_OPENCORES_ETH=y
-CONFIG_PFLASH_CFI01=y
-
+# Boards:
+#
 CONFIG_XTENSA_SIM=y
 CONFIG_XTENSA_FPGA=y
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/xtensaeb-softmmu.mak
index baf90ca..f7e48c7 100644
--- a/default-configs/xtensaeb-softmmu.mak
+++ b/default-configs/xtensaeb-softmmu.mak
@@ -1,8 +1,3 @@
 # Default configuration for Xtensa
 
-CONFIG_SERIAL=y
-CONFIG_OPENCORES_ETH=y
-CONFIG_PFLASH_CFI01=y
-
-CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_FPGA=y
+include xtensa-softmmu.mak
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index 97543a9..2b507d4 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -3,3 +3,6 @@ config XTENSA_SIM
 
 config XTENSA_FPGA
     bool
+    select OPENCORES_ETH
+    select PFLASH_CFI01
+    select SERIAL
-- 
1.8.3.1
