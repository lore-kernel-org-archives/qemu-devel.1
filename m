Received: from eggs.gnu.org ([209.51.188.92]:57730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwL-0002PQ-CR
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwE-0002TE-SK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:18 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwD-0002Ra-1Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so816129wra.6
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:17 +0100
Message-Id: <1549562254-41157-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 34/51] ppc: Express dependencies of the
 embedded machines with kconfig
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

From: Thomas Huth <thuth@redhat.com>

This makes it much easier if the users want to disable some of
the embedded machines for their builds.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak | 17 -----------------
 hw/ppc/Kconfig                  | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index fb43cba..6ea36d4 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,27 +1,10 @@
 # Default configuration for ppc-softmmu
 
-CONFIG_ISA_BUS=y
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_TEST_DEVICES=y
-
 # For embedded PPCs:
-CONFIG_PPC4XX=y
-CONFIG_M48T59=y
-CONFIG_SERIAL=y
-CONFIG_OPENPIC=y
-CONFIG_PPCE500_PCI=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_XILINX=y
-CONFIG_XILINX_ETHLITE=y
 CONFIG_E500=y
-CONFIG_PLATFORM_BUS=y
-CONFIG_ETSEC=y
 CONFIG_PPC405=y
 CONFIG_PPC440=y
 CONFIG_VIRTEX=y
-CONFIG_PCI_EXPRESS=y
 
 # For Sam460ex
 CONFIG_SAM460EX=y
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 664fc31..f57d107 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -27,9 +27,18 @@ config POWERNV
 
 config PPC405
     bool
+    select M48T59
+    select PFLASH_CFI02
+    select PPC4XX
+    select SERIAL
 
 config PPC440
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select PCI_EXPRESS
+    select PPC4XX
+    select SERIAL
 
 config PPC4XX
     bool
@@ -87,9 +96,19 @@ config MAC_NEWWORLD
 
 config E500
     bool
+    imply AT24C
+    select ETSEC
+    select OPENPIC
+    select PLATFORM_BUS
+    select PPCE500_PCI
+    select SERIAL
 
 config VIRTEX
     bool
+    select PFLASH_CFI01
+    select SERIAL
+    select XILINX
+    select XILINX_ETHLITE
 
 config XIVE
     bool
-- 
1.8.3.1
