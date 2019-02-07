Received: from eggs.gnu.org ([209.51.188.92]:57723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwI-0002Mu-PF
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwD-0002ST-6t
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:14 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwC-0002RO-S3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: by mail-wm1-x342.google.com with SMTP id m1so822684wml.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:16 +0100
Message-Id: <1549562254-41157-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 33/51] ppc: Express dependencies of the
 Sam460EX machines with kconfig
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

Most of the dependencies are now directly selected by the SAM460EX
switch. We can drop CONFIG_VGA_CIRRUS since this device is already
selected automatically when CONFIG_PCI_DEVICES is set.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak |  8 --------
 hw/display/Kconfig              |  1 +
 hw/ppc/Kconfig                  | 11 +++++++++++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index caaff60..fb43cba 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -25,14 +25,6 @@ CONFIG_PCI_EXPRESS=y
 
 # For Sam460ex
 CONFIG_SAM460EX=y
-CONFIG_USB_EHCI_SYSBUS=y
-CONFIG_SM501=y
-CONFIG_IDE_SII3112=y
-CONFIG_AT24C=y
-CONFIG_BITBANG_I2C=y
-CONFIG_M41T80=y
-CONFIG_VGA_CIRRUS=y
-CONFIG_SMBUS_EEPROM=y
 
 # For Macs
 CONFIG_MAC_OLDWORLD=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 0f659e9..69f8a7e 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -29,6 +29,7 @@ config SII9022
 config SSD0303
     bool
     depends on I2C
+    select DDC
 
 config SSD0323
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index fb77151..664fc31 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -33,9 +33,20 @@ config PPC440
 
 config PPC4XX
     bool
+    select BITBANG_I2C
+    select PCI
 
 config SAM460EX
     bool
+    select PFLASH_CFI01
+    select IDE_SII3112
+    select M41T80
+    select PPC440
+    select SERIAL
+    select SM501
+    select SMBUS_EEPROM
+    select USB_EHCI_SYSBUS
+    select USB_OHCI
 
 config PREP
     bool
-- 
1.8.3.1
