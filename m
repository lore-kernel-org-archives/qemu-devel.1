Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0k-0006ca-KO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0j-0003Q5-Qw
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:22 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 15:36:02 +0000
Message-Id: <1487604965-23220-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/11] armv7m: Don't put core v7M devices under
 CONFIG_STELLARIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

The NVIC is a core v7M device that exists for all v7M CPUs;
put it under a CONFIG_ARM_V7M rather than hiding it under
CONFIG_STELLARIS.

(We'll use CONFIG_ARM_V7M for the SysTick device too
when we split it out of the NVIC.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/Makefile.objs           | 2 +-
 default-configs/arm-softmmu.mak | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 8948106..adedd0d 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -24,7 +24,7 @@ obj-$(CONFIG_APIC) += apic.o apic_common.o
 obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
-obj-$(CONFIG_STELLARIS) += armv7m_nvic.o
+obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
 obj-$(CONFIG_GRLIB) += grlib_irqmp.o
 obj-$(CONFIG_IOAPIC) += ioapic.o
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index fdf4089..1e3bd2b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -42,6 +42,8 @@ CONFIG_ARM11MPCORE=y
 CONFIG_A9MPCORE=y
 CONFIG_A15MPCORE=y
 
+CONFIG_ARM_V7M=y
+
 CONFIG_ARM_GIC=y
 CONFIG_ARM_GIC_KVM=$(CONFIG_KVM)
 CONFIG_ARM_TIMER=y
-- 
2.7.4
