Received: from eggs.gnu.org ([209.51.188.92]:60123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7x-00066l-AJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-0004GS-8o
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00044d-S2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id x10so943900wrs.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.37.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:37:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:13 +0100
Message-Id: <1549305379-51117-72-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 71/77] hw/i2c/Makefile.objs: Create new CONFIG_*
 variables for EEPROM and ACPI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create separate variables for these components, they are
used in many boards but not all.  This allows finer-grain
selection of the included code with default-configs/*.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-27-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 +
 default-configs/i386-softmmu.mak        | 2 ++
 default-configs/mips-softmmu-common.mak | 2 ++
 default-configs/ppc-softmmu.mak         | 1 +
 hw/i2c/Makefile.objs                    | 5 +++--
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1db3639..d700d09 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -151,6 +151,7 @@ CONFIG_ACPI=y
 CONFIG_ARM_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
+CONFIG_SMBUS_EEPROM=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 71c9f6f..15b6287 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -62,6 +62,8 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
+CONFIG_ACPI_SMBUS=y
+CONFIG_SMBUS_EEPROM=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 479fb4d..ded7498 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -39,3 +39,5 @@ CONFIG_I2C=y
 CONFIG_R4K=y
 CONFIG_MALTA=y
 CONFIG_MIPSSIM=y
+CONFIG_ACPI_SMBUS=y
+CONFIG_SMBUS_EEPROM=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 7f80f0c..52acb7c 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -36,6 +36,7 @@ CONFIG_AT24C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
 CONFIG_VGA_CIRRUS=y
+CONFIG_SMBUS_EEPROM=y
 
 # For Macs
 CONFIG_ESCC=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 82e747e..cecee48 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,8 +1,9 @@
-common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus.o
+common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
-common-obj-$(CONFIG_APM) += pm_smbus.o
+common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
 common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
-- 
1.8.3.1
