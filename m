Received: from eggs.gnu.org ([2001:4830:134:3::10]:47831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8M-0008DZ-Bb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8J-0003FB-CB
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8J-0003Ev-3Y
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:35 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:36 +0100
Message-Id: <1481285870-3396-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 06/20] ppc: Move CPU files to target/ folder
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
 MAINTAINERS                                         | 4 ++--
 Makefile.objs                                       | 2 +-
 hw/ppc/fdt.c                                        | 2 +-
 hw/ppc/pnv.c                                        | 2 +-
 hw/ppc/pnv_core.c                                   | 2 +-
 hw/ppc/pnv_lpc.c                                    | 2 +-
 hw/ppc/pnv_xscom.c                                  | 2 +-
 hw/ppc/spapr_cpu_core.c                             | 6 +++---
 include/hw/ppc/fdt.h                                | 2 +-
 include/hw/ppc/ppc.h                                | 2 +-
 include/hw/ppc/spapr_cpu_core.h                     | 2 +-
 {target-ppc => target/ppc}/Makefile.objs            | 0
 {target-ppc => target/ppc}/STATUS                   | 0
 {target-ppc => target/ppc}/arch_dump.c              | 0
 {target-ppc => target/ppc}/cpu-models.c             | 0
 {target-ppc => target/ppc}/cpu-models.h             | 0
 {target-ppc => target/ppc}/cpu-qom.h                | 0
 {target-ppc => target/ppc}/cpu.h                    | 0
 {target-ppc => target/ppc}/dfp_helper.c             | 0
 {target-ppc => target/ppc}/excp_helper.c            | 0
 {target-ppc => target/ppc}/fpu_helper.c             | 0
 {target-ppc => target/ppc}/gdbstub.c                | 0
 {target-ppc => target/ppc}/helper.h                 | 0
 {target-ppc => target/ppc}/helper_regs.h            | 0
 {target-ppc => target/ppc}/int_helper.c             | 0
 {target-ppc => target/ppc}/internal.h               | 0
 {target-ppc => target/ppc}/kvm-stub.c               | 0
 {target-ppc => target/ppc}/kvm.c                    | 0
 {target-ppc => target/ppc}/kvm_ppc.h                | 0
 {target-ppc => target/ppc}/machine.c                | 0
 {target-ppc => target/ppc}/mem_helper.c             | 0
 {target-ppc => target/ppc}/mfrom_table.c            | 0
 {target-ppc => target/ppc}/mfrom_table_gen.c        | 0
 {target-ppc => target/ppc}/misc_helper.c            | 0
 {target-ppc => target/ppc}/mmu-hash32.c             | 0
 {target-ppc => target/ppc}/mmu-hash32.h             | 0
 {target-ppc => target/ppc}/mmu-hash64.c             | 0
 {target-ppc => target/ppc}/mmu-hash64.h             | 0
 {target-ppc => target/ppc}/mmu_helper.c             | 0
 {target-ppc => target/ppc}/monitor.c                | 0
 {target-ppc => target/ppc}/timebase_helper.c        | 0
 {target-ppc => target/ppc}/trace-events             | 2 +-
 {target-ppc => target/ppc}/translate.c              | 0
 {target-ppc => target/ppc}/translate/dfp-impl.inc.c | 0
 {target-ppc => target/ppc}/translate/dfp-ops.inc.c  | 0
 {target-ppc => target/ppc}/translate/fp-impl.inc.c  | 0
 {target-ppc => target/ppc}/translate/fp-ops.inc.c   | 0
 {target-ppc => target/ppc}/translate/spe-impl.inc.c | 0
 {target-ppc => target/ppc}/translate/spe-ops.inc.c  | 0
 {target-ppc => target/ppc}/translate/vmx-impl.inc.c | 0
 {target-ppc => target/ppc}/translate/vmx-ops.inc.c  | 0
 {target-ppc => target/ppc}/translate/vsx-impl.inc.c | 0
 {target-ppc => target/ppc}/translate/vsx-ops.inc.c  | 0
 {target-ppc => target/ppc}/translate_init.c         | 0
 {target-ppc => target/ppc}/user_only_helper.c       | 0
 55 files changed, 15 insertions(+), 15 deletions(-)
 rename {target-ppc => target/ppc}/Makefile.objs (100%)
 rename {target-ppc => target/ppc}/STATUS (100%)
 rename {target-ppc => target/ppc}/arch_dump.c (100%)
 rename {target-ppc => target/ppc}/cpu-models.c (100%)
 rename {target-ppc => target/ppc}/cpu-models.h (100%)
 rename {target-ppc => target/ppc}/cpu-qom.h (100%)
 rename {target-ppc => target/ppc}/cpu.h (100%)
 rename {target-ppc => target/ppc}/dfp_helper.c (100%)
 rename {target-ppc => target/ppc}/excp_helper.c (100%)
 rename {target-ppc => target/ppc}/fpu_helper.c (100%)
 rename {target-ppc => target/ppc}/gdbstub.c (100%)
 rename {target-ppc => target/ppc}/helper.h (100%)
 rename {target-ppc => target/ppc}/helper_regs.h (100%)
 rename {target-ppc => target/ppc}/int_helper.c (100%)
 rename {target-ppc => target/ppc}/internal.h (100%)
 rename {target-ppc => target/ppc}/kvm-stub.c (100%)
 rename {target-ppc => target/ppc}/kvm.c (100%)
 rename {target-ppc => target/ppc}/kvm_ppc.h (100%)
 rename {target-ppc => target/ppc}/machine.c (100%)
 rename {target-ppc => target/ppc}/mem_helper.c (100%)
 rename {target-ppc => target/ppc}/mfrom_table.c (100%)
 rename {target-ppc => target/ppc}/mfrom_table_gen.c (100%)
 rename {target-ppc => target/ppc}/misc_helper.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash32.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash32.h (100%)
 rename {target-ppc => target/ppc}/mmu-hash64.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash64.h (100%)
 rename {target-ppc => target/ppc}/mmu_helper.c (100%)
 rename {target-ppc => target/ppc}/monitor.c (100%)
 rename {target-ppc => target/ppc}/timebase_helper.c (100%)
 rename {target-ppc => target/ppc}/trace-events (92%)
 rename {target-ppc => target/ppc}/translate.c (100%)
 rename {target-ppc => target/ppc}/translate/dfp-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/dfp-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/fp-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/fp-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/spe-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/spe-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vmx-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vmx-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vsx-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vsx-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate_init.c (100%)
 rename {target-ppc => target/ppc}/user_only_helper.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2760146..da65284 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -193,7 +193,7 @@ M: David Gibson <david@gibson.dropbear.id.au>
 M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Maintained
-F: target-ppc/
+F: target/ppc/
 F: hw/ppc/
 F: include/hw/ppc/
 F: disas/ppc.c
@@ -279,7 +279,7 @@ F: target-mips/kvm.c
 PPC
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
-F: target-ppc/kvm.c
+F: target/ppc/kvm.c
 
 S390
 M: Christian Borntraeger <borntraeger@de.ibm.com>
diff --git a/Makefile.objs b/Makefile.objs
index 6d2b36e..2c4de93 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -159,7 +159,7 @@ trace-events-y += target/arm/trace-events
 trace-events-y += target-i386/trace-events
 trace-events-y += target-sparc/trace-events
 trace-events-y += target-s390x/trace-events
-trace-events-y += target-ppc/trace-events
+trace-events-y += target/ppc/trace-events
 trace-events-y += qom/trace-events
 trace-events-y += linux-user/trace-events
 trace-events-y += qapi/trace-events
diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
index e67d60d..38a7234 100644
--- a/hw/ppc/fdt.c
+++ b/hw/ppc/fdt.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 
 #include "hw/ppc/fdt.h"
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9df7b25..83597fe 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "hw/hw.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 76ce854..d79d530 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -20,7 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0e2117f..78db524 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 8da2718..b82af4f 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -21,7 +21,7 @@
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "sysemu/kvm.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
 
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e0c14f6..f60efbc 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -8,14 +8,14 @@
  */
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
-#include "target-ppc/kvm_ppc.h"
+#include "kvm_ppc.h"
 #include "hw/ppc/ppc.h"
-#include "target-ppc/mmu-hash64.h"
+#include "mmu-hash64.h"
 #include "sysemu/numa.h"
 
 static void spapr_cpu_reset(void *opaque)
diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index 0cabb6a..6450a87 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -11,7 +11,7 @@
 #define PPC_FDT_H
 
 #include "qemu/error-report.h"
-#include "target-ppc/cpu-qom.h"
+#include "cpu-qom.h"
 
 #define _FDT(exp)                                                  \
     do {                                                           \
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 00c1fb1..46960bc 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -1,7 +1,7 @@
 #ifndef HW_PPC_H
 #define HW_PPC_H
 
-#include "target-ppc/cpu-qom.h"
+#include "cpu-qom.h"
 
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 283969b..0f95c73 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -11,7 +11,7 @@
 
 #include "hw/qdev.h"
 #include "hw/cpu/core.h"
-#include "target-ppc/cpu-qom.h"
+#include "cpu-qom.h"
 
 #define TYPE_SPAPR_CPU_CORE "spapr-cpu-core"
 #define SPAPR_CPU_CORE(obj) \
diff --git a/target-ppc/Makefile.objs b/target/ppc/Makefile.objs
similarity index 100%
rename from target-ppc/Makefile.objs
rename to target/ppc/Makefile.objs
diff --git a/target-ppc/STATUS b/target/ppc/STATUS
similarity index 100%
rename from target-ppc/STATUS
rename to target/ppc/STATUS
diff --git a/target-ppc/arch_dump.c b/target/ppc/arch_dump.c
similarity index 100%
rename from target-ppc/arch_dump.c
rename to target/ppc/arch_dump.c
diff --git a/target-ppc/cpu-models.c b/target/ppc/cpu-models.c
similarity index 100%
rename from target-ppc/cpu-models.c
rename to target/ppc/cpu-models.c
diff --git a/target-ppc/cpu-models.h b/target/ppc/cpu-models.h
similarity index 100%
rename from target-ppc/cpu-models.h
rename to target/ppc/cpu-models.h
diff --git a/target-ppc/cpu-qom.h b/target/ppc/cpu-qom.h
similarity index 100%
rename from target-ppc/cpu-qom.h
rename to target/ppc/cpu-qom.h
diff --git a/target-ppc/cpu.h b/target/ppc/cpu.h
similarity index 100%
rename from target-ppc/cpu.h
rename to target/ppc/cpu.h
diff --git a/target-ppc/dfp_helper.c b/target/ppc/dfp_helper.c
similarity index 100%
rename from target-ppc/dfp_helper.c
rename to target/ppc/dfp_helper.c
diff --git a/target-ppc/excp_helper.c b/target/ppc/excp_helper.c
similarity index 100%
rename from target-ppc/excp_helper.c
rename to target/ppc/excp_helper.c
diff --git a/target-ppc/fpu_helper.c b/target/ppc/fpu_helper.c
similarity index 100%
rename from target-ppc/fpu_helper.c
rename to target/ppc/fpu_helper.c
diff --git a/target-ppc/gdbstub.c b/target/ppc/gdbstub.c
similarity index 100%
rename from target-ppc/gdbstub.c
rename to target/ppc/gdbstub.c
diff --git a/target-ppc/helper.h b/target/ppc/helper.h
similarity index 100%
rename from target-ppc/helper.h
rename to target/ppc/helper.h
diff --git a/target-ppc/helper_regs.h b/target/ppc/helper_regs.h
similarity index 100%
rename from target-ppc/helper_regs.h
rename to target/ppc/helper_regs.h
diff --git a/target-ppc/int_helper.c b/target/ppc/int_helper.c
similarity index 100%
rename from target-ppc/int_helper.c
rename to target/ppc/int_helper.c
diff --git a/target-ppc/internal.h b/target/ppc/internal.h
similarity index 100%
rename from target-ppc/internal.h
rename to target/ppc/internal.h
diff --git a/target-ppc/kvm-stub.c b/target/ppc/kvm-stub.c
similarity index 100%
rename from target-ppc/kvm-stub.c
rename to target/ppc/kvm-stub.c
diff --git a/target-ppc/kvm.c b/target/ppc/kvm.c
similarity index 100%
rename from target-ppc/kvm.c
rename to target/ppc/kvm.c
diff --git a/target-ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
similarity index 100%
rename from target-ppc/kvm_ppc.h
rename to target/ppc/kvm_ppc.h
diff --git a/target-ppc/machine.c b/target/ppc/machine.c
similarity index 100%
rename from target-ppc/machine.c
rename to target/ppc/machine.c
diff --git a/target-ppc/mem_helper.c b/target/ppc/mem_helper.c
similarity index 100%
rename from target-ppc/mem_helper.c
rename to target/ppc/mem_helper.c
diff --git a/target-ppc/mfrom_table.c b/target/ppc/mfrom_table.c
similarity index 100%
rename from target-ppc/mfrom_table.c
rename to target/ppc/mfrom_table.c
diff --git a/target-ppc/mfrom_table_gen.c b/target/ppc/mfrom_table_gen.c
similarity index 100%
rename from target-ppc/mfrom_table_gen.c
rename to target/ppc/mfrom_table_gen.c
diff --git a/target-ppc/misc_helper.c b/target/ppc/misc_helper.c
similarity index 100%
rename from target-ppc/misc_helper.c
rename to target/ppc/misc_helper.c
diff --git a/target-ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
similarity index 100%
rename from target-ppc/mmu-hash32.c
rename to target/ppc/mmu-hash32.c
diff --git a/target-ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
similarity index 100%
rename from target-ppc/mmu-hash32.h
rename to target/ppc/mmu-hash32.h
diff --git a/target-ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
similarity index 100%
rename from target-ppc/mmu-hash64.c
rename to target/ppc/mmu-hash64.c
diff --git a/target-ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
similarity index 100%
rename from target-ppc/mmu-hash64.h
rename to target/ppc/mmu-hash64.h
diff --git a/target-ppc/mmu_helper.c b/target/ppc/mmu_helper.c
similarity index 100%
rename from target-ppc/mmu_helper.c
rename to target/ppc/mmu_helper.c
diff --git a/target-ppc/monitor.c b/target/ppc/monitor.c
similarity index 100%
rename from target-ppc/monitor.c
rename to target/ppc/monitor.c
diff --git a/target-ppc/timebase_helper.c b/target/ppc/timebase_helper.c
similarity index 100%
rename from target-ppc/timebase_helper.c
rename to target/ppc/timebase_helper.c
diff --git a/target-ppc/trace-events b/target/ppc/trace-events
similarity index 92%
rename from target-ppc/trace-events
rename to target/ppc/trace-events
index 8fcc3ce..b666156 100644
--- a/target-ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,5 +1,5 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-ppc/kvm.c
+# target/ppc/kvm.c
 kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
 kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
diff --git a/target-ppc/translate.c b/target/ppc/translate.c
similarity index 100%
rename from target-ppc/translate.c
rename to target/ppc/translate.c
diff --git a/target-ppc/translate/dfp-impl.inc.c b/target/ppc/translate/dfp-impl.inc.c
similarity index 100%
rename from target-ppc/translate/dfp-impl.inc.c
rename to target/ppc/translate/dfp-impl.inc.c
diff --git a/target-ppc/translate/dfp-ops.inc.c b/target/ppc/translate/dfp-ops.inc.c
similarity index 100%
rename from target-ppc/translate/dfp-ops.inc.c
rename to target/ppc/translate/dfp-ops.inc.c
diff --git a/target-ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
similarity index 100%
rename from target-ppc/translate/fp-impl.inc.c
rename to target/ppc/translate/fp-impl.inc.c
diff --git a/target-ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
similarity index 100%
rename from target-ppc/translate/fp-ops.inc.c
rename to target/ppc/translate/fp-ops.inc.c
diff --git a/target-ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
similarity index 100%
rename from target-ppc/translate/spe-impl.inc.c
rename to target/ppc/translate/spe-impl.inc.c
diff --git a/target-ppc/translate/spe-ops.inc.c b/target/ppc/translate/spe-ops.inc.c
similarity index 100%
rename from target-ppc/translate/spe-ops.inc.c
rename to target/ppc/translate/spe-ops.inc.c
diff --git a/target-ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
similarity index 100%
rename from target-ppc/translate/vmx-impl.inc.c
rename to target/ppc/translate/vmx-impl.inc.c
diff --git a/target-ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
similarity index 100%
rename from target-ppc/translate/vmx-ops.inc.c
rename to target/ppc/translate/vmx-ops.inc.c
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
similarity index 100%
rename from target-ppc/translate/vsx-impl.inc.c
rename to target/ppc/translate/vsx-impl.inc.c
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
similarity index 100%
rename from target-ppc/translate/vsx-ops.inc.c
rename to target/ppc/translate/vsx-ops.inc.c
diff --git a/target-ppc/translate_init.c b/target/ppc/translate_init.c
similarity index 100%
rename from target-ppc/translate_init.c
rename to target/ppc/translate_init.c
diff --git a/target-ppc/user_only_helper.c b/target/ppc/user_only_helper.c
similarity index 100%
rename from target-ppc/user_only_helper.c
rename to target/ppc/user_only_helper.c
-- 
1.8.3.1
