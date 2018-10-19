Received: from eggs.gnu.org ([2001:4830:134:3::10]:57669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbf-00081i-KP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbe-0005zn-VZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 Oct 2018 15:14:04 +0200
Message-Id: <1539954845-26716-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1539954845-26716-1-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for the
 "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The "unimplemented-device" is currently only used for one arm board.
Let's add a CONFIG switch to make sure that we only compile it when
it is really necessary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/misc/Makefile.objs           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 6f2ffc1..dc9730f 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -7,6 +7,7 @@ CONFIG_NAND=y
 CONFIG_OR_IRQ=y
 CONFIG_SPLIT_IRQ=y
 CONFIG_REGISTER=y
+CONFIG_UNIMP=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6d50b03..c604859 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
 common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
 
-common-obj-y += unimp.o
+common-obj-$(CONFIG_UNIMP) += unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
 
 # ARM devices
-- 
1.8.3.1
