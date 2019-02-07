Received: from eggs.gnu.org ([209.51.188.92]:57781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwR-0002Uj-08
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwP-0002Xs-4t
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwL-0002Tz-Dr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id a16so868641wrv.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:22 +0100
Message-Id: <1549562254-41157-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 39/51] m68k-softmmu.mak: express dependencies
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
 default-configs/m68k-softmmu.mak | 3 ++-
 hw/m68k/Kconfig                  | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index a12eece..e17495e 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -1,5 +1,6 @@
 # Default configuration for m68k-softmmu
 
-CONFIG_COLDFIRE=y
+# Boards:
+#
 CONFIG_AN5206=y
 CONFIG_MCF5208=y
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 8e91eda..49ef0b3 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -1,10 +1,9 @@
 config AN5206
     bool
-
-config MCF5206
-    bool
+    select COLDFIRE
     select PTIMER
 
 config MCF5208
     bool
+    select COLDFIRE
     select PTIMER
-- 
1.8.3.1
