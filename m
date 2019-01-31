Received: from eggs.gnu.org ([209.51.188.92]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qJ-000652-Cy
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qI-0002dl-Of
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qI-0002Yq-H8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:58 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:14 +0800
Message-Id: <20190131073234.18037-8-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 07/27] hw/arm/Makefile.objs: CONFIG_VIRT
 created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

make virt code configurable and the new CONFIG_VIRT definitions
added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
in arm board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 107f801367..d3fc82256f 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -147,6 +147,7 @@ CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_ACPI=y
+CONFIG_ARM_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 50c7b4a927..dab3f88a7c 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += boot.o virt.o sysbus-fdt.o
+obj-y += boot.o sysbus-fdt.o
+obj-$(CONFIG_ARM_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
-- 
2.17.1
