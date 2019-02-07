Received: from eggs.gnu.org ([209.51.188.92]:58065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwt-0002sy-8y
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002l9-VY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:55 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwq-0002Y2-IP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: by mail-wm1-x344.google.com with SMTP id f16so808776wmh.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:31 +0100
Message-Id: <1549562254-41157-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 48/51] unicore32-softmmu.mak: express
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
 default-configs/unicore32-softmmu.mak | 5 +++--
 hw/unicore32/Kconfig                  | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index 17a7915..0bfce48 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -1,4 +1,5 @@
 # Default configuration for unicore32-softmmu
-CONFIG_ISA_BUS=y
+
+# Boards:
+#
 CONFIG_PUV3=y
-CONFIG_PCKBD=y
diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
index a03a996..4443a29 100644
--- a/hw/unicore32/Kconfig
+++ b/hw/unicore32/Kconfig
@@ -1,3 +1,5 @@
 config PUV3
     bool
+    select ISA_BUS
+    select PCKBD
     select PTIMER
-- 
1.8.3.1
