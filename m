Received: from eggs.gnu.org ([2001:4830:134:3::10]:56074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIz-0007Jp-95
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIy-0007m3-7x
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:45 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Thu, 26 Oct 2017 06:34:13 -0400
Message-Id: <1509014053-28134-7-git-send-email-costa@advantech.ca>
In-Reply-To: <1509014053-28134-1-git-send-email-costa@advantech.ca>
References: <1509014053-28134-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel] [PATCH v6]arm: Makefiles to kinetis k64 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

From: Gabriel Augusto Costa <gabriel291075@gmail.com>

This file change the Makefiles to compile the mk64fn1m0 machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Makefile.objs            | 1 +
 hw/char/Makefile.objs           | 1 +
 hw/misc/Makefile.objs           | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5059d13..a835d4f
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -130,3 +130,4 @@ CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
+CONFIG_KINETIS_K64=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2794e08..874a38a
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -20,3 +20,4 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
+obj-$(CONFIG_KINETIS_K64) += mk64fn1m0.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 1bcd37e..75b194c
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -31,3 +31,4 @@ common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
 
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
 obj-$(CONFIG_TERMINAL3270) += terminal3270.o
+obj-$(CONFIG_KINETIS_K64) += kinetis_k64_uart.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 19202d9..c5c8589
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -61,3 +61,6 @@ obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-y += mmio_interface.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
+obj-$(CONFIG_KINETIS_K64) += kinetis_k64_mcg.o
+obj-$(CONFIG_KINETIS_K64) += kinetis_k64_pmux.o
+obj-$(CONFIG_KINETIS_K64) += kinetis_k64_system.o
-- 
2.1.4
