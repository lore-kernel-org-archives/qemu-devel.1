Received: from eggs.gnu.org ([209.51.188.92]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUp-0003c6-Tc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCUo-0002Te-To
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCUo-0002Mh-3Q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:58:46 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:38 +0800
Message-Id: <20190123065618.3520-5-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 04/44] hw/arm/Makefile.objs: CONFIG_VIRT
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

make virt code configurable and the new CONFIG_VIRT definitions
added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
in arm board.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index a978320da3..93983d0be0 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -148,6 +148,7 @@ CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_ACPI=y
+CONFIG_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 50c7b4a927..41dab8a522 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += boot.o virt.o sysbus-fdt.o
+obj-y += boot.o sysbus-fdt.o
+obj-$(CONFIG_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
-- 
2.17.1
