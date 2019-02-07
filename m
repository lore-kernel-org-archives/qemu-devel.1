Received: from eggs.gnu.org ([209.51.188.92]:58067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwt-0002sz-9L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002k8-Mi
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwq-0002X5-AD
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so764988wrt.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:29 +0100
Message-Id: <1549562254-41157-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 46/51] sparc-softmmu.mak: express dependencies
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
 default-configs/sparc-softmmu.mak | 22 ++++++----------------
 hw/misc/Kconfig                   |  1 +
 hw/net/Kconfig                    |  1 +
 hw/sparc/Kconfig                  | 13 +++++++++++++
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
index b31a9f2..ee85218 100644
--- a/default-configs/sparc-softmmu.mak
+++ b/default-configs/sparc-softmmu.mak
@@ -1,21 +1,11 @@
 # Default configuration for sparc-softmmu
 
-CONFIG_ISA_BUS=y
-CONFIG_ECC=y
-CONFIG_ESP=y
-CONFIG_ESCC=y
-CONFIG_M48T59=y
-CONFIG_FDC=y
-CONFIG_EMPTY_SLOT=y
-CONFIG_PCNET_COMMON=y
-CONFIG_LANCE=y
-CONFIG_TCX=y
-CONFIG_CG3=y
-CONFIG_SLAVIO=y
-CONFIG_CS4231=y
-CONFIG_GRLIB=y
-CONFIG_STP2000=y
-CONFIG_ECCMEMCTL=y
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_TCX=n
+#CONFIG_CG3=n
 
+# Boards:
+#
 CONFIG_SUN4M=y
 CONFIG_LEON3=y
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 728c561..11d4b30 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -71,6 +71,7 @@ config IVSHMEM_DEVICE
 
 config ECCMEMCTL
     bool
+    select ECC
 
 config IMX
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 1aa1071..c132180 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -77,6 +77,7 @@ config STELLARIS_ENET
 
 config LANCE
     bool
+    select PCNET_COMMON
 
 config SUNHME
     bool
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index c9c2142..2a83a80 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -1,8 +1,21 @@
 config SUN4M
     bool
+    imply TCX
+    imply CG3
+    select CS4231
+    select ECCMEMCTL
+    select EMPTY_SLOT
+    select ESCC
+    select ESP
+    select FDC
+    select SLAVIO
+    select LANCE
+    select M48T59
+    select STP2000
 
 config LEON3
     bool
+    select GRLIB
 
 config GRLIB
     bool
-- 
1.8.3.1
