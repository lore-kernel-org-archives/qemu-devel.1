Received: from eggs.gnu.org ([209.51.188.92]:37581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYZ-00037A-UF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRJ-00017b-Bi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:56304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRH-00013D-3Z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:36 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:34 +0800
Message-Id: <20190115141108.934-4-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 03/37] hw/arm/Makefile.objs: CONFIG_VIRT
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

make virt code configurable and the new CONFIG_VIRT definitions
added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
in arm board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/arm-softmmu.mak | 2 +-
 hw/arm/Makefile.objs            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 2420491aac..3903d1ada3 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -147,7 +147,7 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_ACPI=y
+CONFIG_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 50c7b4a927..25ff98fdbc 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,5 +1,5 @@
-obj-y += boot.o virt.o sysbus-fdt.o
-obj-$(CONFIG_ACPI) += virt-acpi-build.o
+obj-y += boot.o sysbus-fdt.o
+obj-$(CONFIG_VIRT) += virt.o virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
 obj-$(CONFIG_HIGHBANK) += highbank.o
-- 
2.17.1
