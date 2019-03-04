Received: from eggs.gnu.org ([209.51.188.92]:46259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD4-0002R1-Ji
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCz-0004xI-Kn
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCx-0004aQ-FB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so6640061wrm.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:55 +0100
Message-Id: <1551723614-1823-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/54] ppc: Express dependencies of the Sam460EX
 machines with kconfig
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
 hw/ppc/Kconfig                  | 11 +++++++++++
 2 files changed, 11 insertions(+), 8 deletions(-)

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
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 9b5056f..f4fce16 100644
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
