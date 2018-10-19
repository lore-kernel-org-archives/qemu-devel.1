Received: from eggs.gnu.org ([2001:4830:134:3::10]:48214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gDRs6-0002JZ-8Z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gDRs2-0008L3-6p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:19:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gDRs1-0008Gu-8k
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:19:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id p5-v6so767866plq.8
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:19:05 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 19 Oct 2018 18:18:55 +0800
Message-Id: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>

Remove the unused herder files, 'virt' can be compiled and run without
including them.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 hw/arm/virt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f67782..f0066cb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -30,9 +30,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/sysbus.h"
-#include "hw/arm/arm.h"
-#include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
@@ -41,12 +38,9 @@
 #include "net/net.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "hw/compat.h"
 #include "hw/loader.h"
-#include "exec/address-spaces.h"
-#include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/sysbus-fdt.h"
@@ -56,9 +50,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "kvm_arm.h"
 #include "hw/smbios/smbios.h"
-#include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
-#include "hw/arm/smmuv3.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
-- 
2.7.4
