Received: from eggs.gnu.org ([2001:4830:134:3::10]:57648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbe-00080q-TE
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbe-0005yk-1d
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:22 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 Oct 2018 15:14:02 +0200
Message-Id: <1539954845-26716-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1539954845-26716-1-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] configs: Add a CONFIG_SPLIT_IRQ switch for
 the split-irq device
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

If the user only wants to compile targets that do not require the
"split-irq" device, we should also not compile split-irq.c. Add a proper
CONFIG_SPLIT_IRQ switch to be able to choose this more flexibly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/core/Makefile.objs           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index dc6a581..a3a3b66 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -5,6 +5,7 @@ include usb.mak
 CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_OR_IRQ=y
+CONFIG_SPLIT_IRQ=y
 CONFIG_ECC=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 29b5cfd..cafbe01 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -18,7 +18,7 @@ common-obj-$(CONFIG_FITLOADER) += loader-fit.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_OR_IRQ) += or-irq.o
-common-obj-$(CONFIG_SOFTMMU) += split-irq.o
+common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 
-- 
1.8.3.1
