Received: from eggs.gnu.org ([2001:4830:134:3::10]:47811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8K-00086k-FF
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8D-0003Db-OH
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8D-0003DM-FP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:35 +0100
Message-Id: <1481285870-3396-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 05/20] arm: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                | 4 ++--
 Makefile.objs                              | 2 +-
 hw/arm/strongarm.h                         | 2 +-
 hw/arm/virt-acpi-build.c                   | 2 +-
 include/hw/arm/arm.h                       | 2 +-
 include/hw/arm/exynos4210.h                | 2 +-
 include/hw/arm/omap.h                      | 2 +-
 include/hw/arm/pxa.h                       | 2 +-
 {target-arm => target/arm}/Makefile.objs   | 0
 {target-arm => target/arm}/arch_dump.c     | 0
 {target-arm => target/arm}/arm-powerctl.c  | 0
 {target-arm => target/arm}/arm-powerctl.h  | 0
 {target-arm => target/arm}/arm-semi.c      | 0
 {target-arm => target/arm}/arm_ldst.h      | 0
 {target-arm => target/arm}/cpu-qom.h       | 0
 {target-arm => target/arm}/cpu.c           | 0
 {target-arm => target/arm}/cpu.h           | 0
 {target-arm => target/arm}/cpu64.c         | 0
 {target-arm => target/arm}/crypto_helper.c | 0
 {target-arm => target/arm}/gdbstub.c       | 0
 {target-arm => target/arm}/gdbstub64.c     | 0
 {target-arm => target/arm}/helper-a64.c    | 0
 {target-arm => target/arm}/helper-a64.h    | 0
 {target-arm => target/arm}/helper.c        | 0
 {target-arm => target/arm}/helper.h        | 0
 {target-arm => target/arm}/internals.h     | 0
 {target-arm => target/arm}/iwmmxt_helper.c | 0
 {target-arm => target/arm}/kvm-consts.h    | 0
 {target-arm => target/arm}/kvm-stub.c      | 0
 {target-arm => target/arm}/kvm.c           | 0
 {target-arm => target/arm}/kvm32.c         | 0
 {target-arm => target/arm}/kvm64.c         | 0
 {target-arm => target/arm}/kvm_arm.h       | 0
 {target-arm => target/arm}/machine.c       | 0
 {target-arm => target/arm}/monitor.c       | 0
 {target-arm => target/arm}/neon_helper.c   | 0
 {target-arm => target/arm}/op_addsub.h     | 0
 {target-arm => target/arm}/op_helper.c     | 0
 {target-arm => target/arm}/psci.c          | 0
 {target-arm => target/arm}/trace-events    | 2 +-
 {target-arm => target/arm}/translate-a64.c | 0
 {target-arm => target/arm}/translate.c     | 0
 {target-arm => target/arm}/translate.h     | 0
 43 files changed, 10 insertions(+), 10 deletions(-)
 rename {target-arm => target/arm}/Makefile.objs (100%)
 rename {target-arm => target/arm}/arch_dump.c (100%)
 rename {target-arm => target/arm}/arm-powerctl.c (100%)
 rename {target-arm => target/arm}/arm-powerctl.h (100%)
 rename {target-arm => target/arm}/arm-semi.c (100%)
 rename {target-arm => target/arm}/arm_ldst.h (100%)
 rename {target-arm => target/arm}/cpu-qom.h (100%)
 rename {target-arm => target/arm}/cpu.c (100%)
 rename {target-arm => target/arm}/cpu.h (100%)
 rename {target-arm => target/arm}/cpu64.c (100%)
 rename {target-arm => target/arm}/crypto_helper.c (100%)
 rename {target-arm => target/arm}/gdbstub.c (100%)
 rename {target-arm => target/arm}/gdbstub64.c (100%)
 rename {target-arm => target/arm}/helper-a64.c (100%)
 rename {target-arm => target/arm}/helper-a64.h (100%)
 rename {target-arm => target/arm}/helper.c (100%)
 rename {target-arm => target/arm}/helper.h (100%)
 rename {target-arm => target/arm}/internals.h (100%)
 rename {target-arm => target/arm}/iwmmxt_helper.c (100%)
 rename {target-arm => target/arm}/kvm-consts.h (100%)
 rename {target-arm => target/arm}/kvm-stub.c (100%)
 rename {target-arm => target/arm}/kvm.c (100%)
 rename {target-arm => target/arm}/kvm32.c (100%)
 rename {target-arm => target/arm}/kvm64.c (100%)
 rename {target-arm => target/arm}/kvm_arm.h (100%)
 rename {target-arm => target/arm}/machine.c (100%)
 rename {target-arm => target/arm}/monitor.c (100%)
 rename {target-arm => target/arm}/neon_helper.c (100%)
 rename {target-arm => target/arm}/op_addsub.h (100%)
 rename {target-arm => target/arm}/op_helper.c (100%)
 rename {target-arm => target/arm}/psci.c (100%)
 rename {target-arm => target/arm}/trace-events (96%)
 rename {target-arm => target/arm}/translate-a64.c (100%)
 rename {target-arm => target/arm}/translate.c (100%)
 rename {target-arm => target/arm}/translate.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37deb43..2760146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -115,7 +115,7 @@ ARM
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: target-arm/
+F: target/arm/
 F: hw/arm/
 F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
@@ -269,7 +269,7 @@ ARM
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: target-arm/kvm.c
+F: target/arm/kvm.c
 
 MIPS
 M: James Hogan <james.hogan@imgtec.com>
diff --git a/Makefile.objs b/Makefile.objs
index 06f74b8..6d2b36e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -155,7 +155,7 @@ trace-events-y += hw/alpha/trace-events
 trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
-trace-events-y += target-arm/trace-events
+trace-events-y += target/arm/trace-events
 trace-events-y += target-i386/trace-events
 trace-events-y += target-sparc/trace-events
 trace-events-y += target-s390x/trace-events
diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index 1470eac..c5ff903 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -2,7 +2,7 @@
 #define STRONGARM_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "cpu-qom.h"
 
 #define SA_CS0          0x00000000
 #define SA_CS1          0x08000000
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d4160df..60770d4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -33,7 +33,7 @@
 #include "qemu/bitmap.h"
 #include "trace.h"
 #include "qom/cpu.h"
-#include "target-arm/cpu.h"
+#include "cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index aeeebfe..68b8f83 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -12,7 +12,7 @@
 #define HW_ARM_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "cpu-qom.h"
 #include "hw/irq.h"
 #include "qemu/notify.h"
 
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 29fef8b..cc43bdb 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -27,7 +27,7 @@
 
 #include "qemu-common.h"
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "cpu-qom.h"
 
 #define EXYNOS4210_NCPUS                    2
 
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index f026c8d..04e11f5 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,7 +20,7 @@
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
-#include "target-arm/cpu-qom.h"
+#include "cpu-qom.h"
 
 # define OMAP_EMIFS_BASE	0x00000000
 # define OMAP2_Q0_BASE		0x00000000
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 191e068..1cb8480 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -11,7 +11,7 @@
 #define PXA_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "cpu-qom.h"
 
 /* Interrupt numbers */
 # define PXA2XX_PIC_SSP3	0
diff --git a/target-arm/Makefile.objs b/target/arm/Makefile.objs
similarity index 100%
rename from target-arm/Makefile.objs
rename to target/arm/Makefile.objs
diff --git a/target-arm/arch_dump.c b/target/arm/arch_dump.c
similarity index 100%
rename from target-arm/arch_dump.c
rename to target/arm/arch_dump.c
diff --git a/target-arm/arm-powerctl.c b/target/arm/arm-powerctl.c
similarity index 100%
rename from target-arm/arm-powerctl.c
rename to target/arm/arm-powerctl.c
diff --git a/target-arm/arm-powerctl.h b/target/arm/arm-powerctl.h
similarity index 100%
rename from target-arm/arm-powerctl.h
rename to target/arm/arm-powerctl.h
diff --git a/target-arm/arm-semi.c b/target/arm/arm-semi.c
similarity index 100%
rename from target-arm/arm-semi.c
rename to target/arm/arm-semi.c
diff --git a/target-arm/arm_ldst.h b/target/arm/arm_ldst.h
similarity index 100%
rename from target-arm/arm_ldst.h
rename to target/arm/arm_ldst.h
diff --git a/target-arm/cpu-qom.h b/target/arm/cpu-qom.h
similarity index 100%
rename from target-arm/cpu-qom.h
rename to target/arm/cpu-qom.h
diff --git a/target-arm/cpu.c b/target/arm/cpu.c
similarity index 100%
rename from target-arm/cpu.c
rename to target/arm/cpu.c
diff --git a/target-arm/cpu.h b/target/arm/cpu.h
similarity index 100%
rename from target-arm/cpu.h
rename to target/arm/cpu.h
diff --git a/target-arm/cpu64.c b/target/arm/cpu64.c
similarity index 100%
rename from target-arm/cpu64.c
rename to target/arm/cpu64.c
diff --git a/target-arm/crypto_helper.c b/target/arm/crypto_helper.c
similarity index 100%
rename from target-arm/crypto_helper.c
rename to target/arm/crypto_helper.c
diff --git a/target-arm/gdbstub.c b/target/arm/gdbstub.c
similarity index 100%
rename from target-arm/gdbstub.c
rename to target/arm/gdbstub.c
diff --git a/target-arm/gdbstub64.c b/target/arm/gdbstub64.c
similarity index 100%
rename from target-arm/gdbstub64.c
rename to target/arm/gdbstub64.c
diff --git a/target-arm/helper-a64.c b/target/arm/helper-a64.c
similarity index 100%
rename from target-arm/helper-a64.c
rename to target/arm/helper-a64.c
diff --git a/target-arm/helper-a64.h b/target/arm/helper-a64.h
similarity index 100%
rename from target-arm/helper-a64.h
rename to target/arm/helper-a64.h
diff --git a/target-arm/helper.c b/target/arm/helper.c
similarity index 100%
rename from target-arm/helper.c
rename to target/arm/helper.c
diff --git a/target-arm/helper.h b/target/arm/helper.h
similarity index 100%
rename from target-arm/helper.h
rename to target/arm/helper.h
diff --git a/target-arm/internals.h b/target/arm/internals.h
similarity index 100%
rename from target-arm/internals.h
rename to target/arm/internals.h
diff --git a/target-arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
similarity index 100%
rename from target-arm/iwmmxt_helper.c
rename to target/arm/iwmmxt_helper.c
diff --git a/target-arm/kvm-consts.h b/target/arm/kvm-consts.h
similarity index 100%
rename from target-arm/kvm-consts.h
rename to target/arm/kvm-consts.h
diff --git a/target-arm/kvm-stub.c b/target/arm/kvm-stub.c
similarity index 100%
rename from target-arm/kvm-stub.c
rename to target/arm/kvm-stub.c
diff --git a/target-arm/kvm.c b/target/arm/kvm.c
similarity index 100%
rename from target-arm/kvm.c
rename to target/arm/kvm.c
diff --git a/target-arm/kvm32.c b/target/arm/kvm32.c
similarity index 100%
rename from target-arm/kvm32.c
rename to target/arm/kvm32.c
diff --git a/target-arm/kvm64.c b/target/arm/kvm64.c
similarity index 100%
rename from target-arm/kvm64.c
rename to target/arm/kvm64.c
diff --git a/target-arm/kvm_arm.h b/target/arm/kvm_arm.h
similarity index 100%
rename from target-arm/kvm_arm.h
rename to target/arm/kvm_arm.h
diff --git a/target-arm/machine.c b/target/arm/machine.c
similarity index 100%
rename from target-arm/machine.c
rename to target/arm/machine.c
diff --git a/target-arm/monitor.c b/target/arm/monitor.c
similarity index 100%
rename from target-arm/monitor.c
rename to target/arm/monitor.c
diff --git a/target-arm/neon_helper.c b/target/arm/neon_helper.c
similarity index 100%
rename from target-arm/neon_helper.c
rename to target/arm/neon_helper.c
diff --git a/target-arm/op_addsub.h b/target/arm/op_addsub.h
similarity index 100%
rename from target-arm/op_addsub.h
rename to target/arm/op_addsub.h
diff --git a/target-arm/op_helper.c b/target/arm/op_helper.c
similarity index 100%
rename from target-arm/op_helper.c
rename to target/arm/op_helper.c
diff --git a/target-arm/psci.c b/target/arm/psci.c
similarity index 100%
rename from target-arm/psci.c
rename to target/arm/psci.c
diff --git a/target-arm/trace-events b/target/arm/trace-events
similarity index 96%
rename from target-arm/trace-events
rename to target/arm/trace-events
index 9f726bd..e21c84f 100644
--- a/target-arm/trace-events
+++ b/target/arm/trace-events
@@ -1,6 +1,6 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-arm/helper.c
+# target/arm/helper.c
 arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %" PRIx64
 arm_gt_recalc_disabled(int timer) "gt recalc: timer %d irqstate 0 timer disabled"
 arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value %" PRIx64
diff --git a/target-arm/translate-a64.c b/target/arm/translate-a64.c
similarity index 100%
rename from target-arm/translate-a64.c
rename to target/arm/translate-a64.c
diff --git a/target-arm/translate.c b/target/arm/translate.c
similarity index 100%
rename from target-arm/translate.c
rename to target/arm/translate.c
diff --git a/target-arm/translate.h b/target/arm/translate.h
similarity index 100%
rename from target-arm/translate.h
rename to target/arm/translate.h
-- 
1.8.3.1
