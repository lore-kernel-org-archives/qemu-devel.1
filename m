Received: from eggs.gnu.org ([209.51.188.92]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sDC-0002Xq-Sm
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD9-0005EW-Nc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:14 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sD7-00053n-CF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id f3so123662wmj.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:21:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:12 +0100
Message-Id: <1551723614-1823-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 52/54] xtensa-softmmu.mak: express dependencies
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
 default-configs/xtensa-softmmu.mak   | 6 ++----
 default-configs/xtensaeb-softmmu.mak | 7 +------
 hw/xtensa/Kconfig                    | 3 +++
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 7aa7fa6..7e4d1cc 100644
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
 CONFIG_XTENSA_XTFPGA=y
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/xtensaeb-softmmu.mak
index 7aa7fa6..f7e48c7 100644
--- a/default-configs/xtensaeb-softmmu.mak
+++ b/default-configs/xtensaeb-softmmu.mak
@@ -1,8 +1,3 @@
 # Default configuration for Xtensa
 
-CONFIG_SERIAL=y
-CONFIG_OPENCORES_ETH=y
-CONFIG_PFLASH_CFI01=y
-
-CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_XTFPGA=y
+include xtensa-softmmu.mak
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index dc8eaf6..d72817d 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -3,3 +3,6 @@ config XTENSA_SIM
 
 config XTENSA_XTFPGA
     bool
+    select OPENCORES_ETH
+    select PFLASH_CFI01
+    select SERIAL
-- 
1.8.3.1
