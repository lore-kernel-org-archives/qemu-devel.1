Received: from eggs.gnu.org ([209.51.188.92]:57778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwQ-0002Ud-Vm
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwP-0002XX-0u
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:25 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwL-0002T0-CO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id z5so831256wmf.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:19 +0100
Message-Id: <1549562254-41157-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 36/51] cris-softmmu.mak: express dependencies
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
 default-configs/cris-softmmu.mak | 5 ++---
 hw/cris/Kconfig                  | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
index b3cae59..5932cf4 100644
--- a/default-configs/cris-softmmu.mak
+++ b/default-configs/cris-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for cris-softmmu
 
-CONFIG_ETRAXFS=y
-CONFIG_NAND=y
-CONFIG_PFLASH_CFI02=y
+# Boards:
+#
 CONFIG_AXIS=y
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index b7738ab..884ad2c 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -1,5 +1,8 @@
 config AXIS
     bool
+    select ETRAXFS
+    select PFLASH_CFI02
+    select NAND
 
 config ETRAXFS
    bool
-- 
1.8.3.1
