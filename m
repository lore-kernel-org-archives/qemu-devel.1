Received: from eggs.gnu.org ([2001:4830:134:3::10]:44602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSB-0004Lv-LF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSA-0004wc-6o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:23 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS9-0004wE-W1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:22 -0500
Received: by mail-wm0-x243.google.com with SMTP id v71so28090128wmv.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:27 +0100
Message-Id: <1517858941-5538-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/47] i2c: Add a CONFIG_I2C master switch to
 the configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The i2c core and the at24c EEPROM should only be compiled and linked
on the machines that support i2c. Otherwise it's quite strange to see
the at24c-eeprom to be "available" on qemu-system-s390x for example.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1516634853-15883-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 +
 default-configs/i386-softmmu.mak        | 1 +
 default-configs/mips-softmmu-common.mak | 1 +
 default-configs/ppc-softmmu.mak         | 1 +
 default-configs/ppcemb-softmmu.mak      | 1 +
 default-configs/x86_64-softmmu.mak      | 1 +
 hw/i2c/Makefile.objs                    | 2 +-
 hw/nvram/Makefile.objs                  | 2 +-
 8 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b0d6e65..ca34cf4 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -67,6 +67,7 @@ CONFIG_CADENCE=y
 CONFIG_XGMAC=y
 CONFIG_EXYNOS4=y
 CONFIG_PXA2XX=y
+CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_FRAMEBUFFER=y
 CONFIG_XILINX_SPIPS=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index ac27700..3326e3e 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -62,3 +62,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
+CONFIG_I2C=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 7d8f5db..e31f046 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -34,3 +34,4 @@ CONFIG_ISA_TESTDEV=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
+CONFIG_I2C=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 3baed6a..65680d8 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -23,6 +23,7 @@ CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
+CONFIG_I2C=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 5db4618..bc5e1b3 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -17,3 +17,4 @@ CONFIG_XILINX=y
 CONFIG_XILINX_ETHLITE=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
+CONFIG_I2C=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index b2104ad..1c6cda1 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -62,3 +62,4 @@ CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
+CONFIG_I2C=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 0594dea..37cacde 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 0f4ee71..a912d25 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_DS1225Y) += ds1225y.o
 common-obj-y += eeprom93xx.o
-common-obj-y += eeprom_at24c.o
+common-obj-$(CONFIG_I2C) += eeprom_at24c.o
 common-obj-y += fw_cfg.o
 common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
-- 
1.8.3.1
