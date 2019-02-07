Received: from eggs.gnu.org ([209.51.188.92]:58060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwt-0002sn-60
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002jr-KX
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:54 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwq-0002VB-8i
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: by mail-wm1-x341.google.com with SMTP id b11so829975wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:25 +0100
Message-Id: <1549562254-41157-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 42/51] nios2-softmmu.mak: express dependencies
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
 default-configs/nios2-softmmu.mak | 5 ++---
 hw/nios2/Kconfig                  | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index b3c507e..e11dc54 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -1,6 +1,5 @@
 # Default configuration for nios2-softmmu
 
-CONFIG_NIOS2=y
-CONFIG_SERIAL=y
-CONFIG_ALTERA_TIMER=y
+# Boards:
+#
 CONFIG_NIOS2_10M50=y
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
index 22817e4..ab953e0 100644
--- a/hw/nios2/Kconfig
+++ b/hw/nios2/Kconfig
@@ -1,5 +1,8 @@
 config NIOS2_10M50
     bool
+    select NIOS2
+    select SERIAL
+    select ALTERA_TIMER
 
 config NIOS2
     bool
-- 
1.8.3.1
