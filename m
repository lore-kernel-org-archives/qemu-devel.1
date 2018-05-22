Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLCn7-0000eg-K4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLCn4-0002BW-FN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:17:49 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 May 2018 21:17:43 +0200
Message-Id: <20180522191743.12872-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc: move at24c to its own CONFIG_ symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

AT24c EEPROM is currently gated by CONFIG_I2C, and as such it is
being included in all emulators that use I2C, even if they do not
really need it.  Separate it and, since it was added for the e500
machines, add it to qemu-system-ppc and qemu-system-ppc64.
---
 default-configs/ppc-softmmu.mak | 1 +
 hw/nvram/Makefile.objs          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 4d7be45ac5..c57e568121 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
+CONFIG_AT24C=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index a912d25391..b318e53a43 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_DS1225Y) += ds1225y.o
 common-obj-y += eeprom93xx.o
-common-obj-$(CONFIG_I2C) += eeprom_at24c.o
+common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
 common-obj-y += fw_cfg.o
 common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
-- 
2.17.0
