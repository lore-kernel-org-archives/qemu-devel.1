Received: from eggs.gnu.org ([2001:4830:134:3::10]:47884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8W-0000LN-86
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8P-0003H8-6p
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8O-0003Gt-Uk
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:41 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:37 +0100
Message-Id: <1481285870-3396-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 07/20] i386: Move CPU files to target/ folder
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
 MAINTAINERS                                          | 4 ++--
 Makefile.objs                                        | 2 +-
 hw/i386/acpi-build.c                                 | 2 +-
 hw/i386/kvm/apic.c                                   | 2 +-
 hw/intc/ioapic.c                                     | 2 +-
 hw/misc/hyperv_testdev.c                             | 2 +-
 scripts/analyze-inclusions                           | 6 +++---
 {target-i386 => target/i386}/Makefile.objs           | 0
 {target-i386 => target/i386}/TODO                    | 0
 {target-i386 => target/i386}/arch_dump.c             | 0
 {target-i386 => target/i386}/arch_memory_mapping.c   | 0
 {target-i386 => target/i386}/bpt_helper.c            | 0
 {target-i386 => target/i386}/cc_helper.c             | 0
 {target-i386 => target/i386}/cc_helper_template.h    | 0
 {target-i386 => target/i386}/cpu-qom.h               | 0
 {target-i386 => target/i386}/cpu.c                   | 0
 {target-i386 => target/i386}/cpu.h                   | 0
 {target-i386 => target/i386}/excp_helper.c           | 0
 {target-i386 => target/i386}/fpu_helper.c            | 0
 {target-i386 => target/i386}/gdbstub.c               | 0
 {target-i386 => target/i386}/helper.c                | 0
 {target-i386 => target/i386}/helper.h                | 0
 {target-i386 => target/i386}/hyperv.c                | 0
 {target-i386 => target/i386}/hyperv.h                | 0
 {target-i386 => target/i386}/int_helper.c            | 0
 {target-i386 => target/i386}/kvm-stub.c              | 0
 {target-i386 => target/i386}/kvm.c                   | 0
 {target-i386 => target/i386}/kvm_i386.h              | 0
 {target-i386 => target/i386}/machine.c               | 0
 {target-i386 => target/i386}/mem_helper.c            | 0
 {target-i386 => target/i386}/misc_helper.c           | 0
 {target-i386 => target/i386}/monitor.c               | 0
 {target-i386 => target/i386}/mpx_helper.c            | 0
 {target-i386 => target/i386}/ops_sse.h               | 0
 {target-i386 => target/i386}/ops_sse_header.h        | 0
 {target-i386 => target/i386}/seg_helper.c            | 0
 {target-i386 => target/i386}/shift_helper_template.h | 0
 {target-i386 => target/i386}/smm_helper.c            | 0
 {target-i386 => target/i386}/svm.h                   | 0
 {target-i386 => target/i386}/svm_helper.c            | 0
 {target-i386 => target/i386}/trace-events            | 2 +-
 {target-i386 => target/i386}/translate.c             | 0
 42 files changed, 11 insertions(+), 11 deletions(-)
 rename {target-i386 => target/i386}/Makefile.objs (100%)
 rename {target-i386 => target/i386}/TODO (100%)
 rename {target-i386 => target/i386}/arch_dump.c (100%)
 rename {target-i386 => target/i386}/arch_memory_mapping.c (100%)
 rename {target-i386 => target/i386}/bpt_helper.c (100%)
 rename {target-i386 => target/i386}/cc_helper.c (100%)
 rename {target-i386 => target/i386}/cc_helper_template.h (100%)
 rename {target-i386 => target/i386}/cpu-qom.h (100%)
 rename {target-i386 => target/i386}/cpu.c (100%)
 rename {target-i386 => target/i386}/cpu.h (100%)
 rename {target-i386 => target/i386}/excp_helper.c (100%)
 rename {target-i386 => target/i386}/fpu_helper.c (100%)
 rename {target-i386 => target/i386}/gdbstub.c (100%)
 rename {target-i386 => target/i386}/helper.c (100%)
 rename {target-i386 => target/i386}/helper.h (100%)
 rename {target-i386 => target/i386}/hyperv.c (100%)
 rename {target-i386 => target/i386}/hyperv.h (100%)
 rename {target-i386 => target/i386}/int_helper.c (100%)
 rename {target-i386 => target/i386}/kvm-stub.c (100%)
 rename {target-i386 => target/i386}/kvm.c (100%)
 rename {target-i386 => target/i386}/kvm_i386.h (100%)
 rename {target-i386 => target/i386}/machine.c (100%)
 rename {target-i386 => target/i386}/mem_helper.c (100%)
 rename {target-i386 => target/i386}/misc_helper.c (100%)
 rename {target-i386 => target/i386}/monitor.c (100%)
 rename {target-i386 => target/i386}/mpx_helper.c (100%)
 rename {target-i386 => target/i386}/ops_sse.h (100%)
 rename {target-i386 => target/i386}/ops_sse_header.h (100%)
 rename {target-i386 => target/i386}/seg_helper.c (100%)
 rename {target-i386 => target/i386}/shift_helper_template.h (100%)
 rename {target-i386 => target/i386}/smm_helper.c (100%)
 rename {target-i386 => target/i386}/svm.h (100%)
 rename {target-i386 => target/i386}/svm_helper.c (100%)
 rename {target-i386 => target/i386}/trace-events (94%)
 rename {target-i386 => target/i386}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index da65284..1b064ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -235,7 +235,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <rth@twiddle.net>
 M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
-F: target-i386/
+F: target/i386/
 F: hw/i386/
 F: disas/i386.c
 
@@ -301,7 +301,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: target-i386/kvm.c
+F: target/i386/kvm.c
 
 Guest CPU Cores (Xen):
 ----------------------
diff --git a/Makefile.objs b/Makefile.objs
index 2c4de93..91a24c5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -156,7 +156,7 @@ trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
 trace-events-y += target/arm/trace-events
-trace-events-y += target-i386/trace-events
+trace-events-y += target/i386/trace-events
 trace-events-y += target-sparc/trace-events
 trace-events-y += target-s390x/trace-events
 trace-events-y += target/ppc/trace-events
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9708cdc..42ecf61 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -29,7 +29,7 @@
 #include "hw/pci/pci.h"
 #include "qom/cpu.h"
 #include "hw/i386/pc.h"
-#include "target-i386/cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/timer/hpet.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 01cbaa8..df5180b 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -15,7 +15,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
 #include "sysemu/kvm.h"
-#include "target-i386/kvm_i386.h"
+#include "target/i386/kvm_i386.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index fd9208f..ea7ea0b 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -30,7 +30,7 @@
 #include "hw/i386/ioapic_internal.h"
 #include "include/hw/pci/msi.h"
 #include "sysemu/kvm.h"
-#include "target-i386/cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 6cae9e9..dbd7cdd 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -17,7 +17,7 @@
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
 #include "sysemu/kvm.h"
-#include "target-i386/hyperv.h"
+#include "target/i386/hyperv.h"
 #include "kvm_i386.h"
 
 #define HV_TEST_DEV_MAX_SINT_ROUTES 64
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index a8108d9..4e4bb68 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -95,8 +95,8 @@ analyze -include ../include/qemu/osdep.h ../include/hw/hw.h
 echo trace/generated-tracers.h:
 analyze -include ../include/qemu/osdep.h trace/generated-tracers.h
 
-echo target-i386/cpu.h:
-analyze -DNEED_CPU_H -I../target-i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target-i386/cpu.h
+echo target/i386/cpu.h:
+analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target-i386/cpu.h
 
 echo hw/hw.h + NEED_CPU_H:
-analyze -DNEED_CPU_H -I../target-i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
+analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
diff --git a/target-i386/Makefile.objs b/target/i386/Makefile.objs
similarity index 100%
rename from target-i386/Makefile.objs
rename to target/i386/Makefile.objs
diff --git a/target-i386/TODO b/target/i386/TODO
similarity index 100%
rename from target-i386/TODO
rename to target/i386/TODO
diff --git a/target-i386/arch_dump.c b/target/i386/arch_dump.c
similarity index 100%
rename from target-i386/arch_dump.c
rename to target/i386/arch_dump.c
diff --git a/target-i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
similarity index 100%
rename from target-i386/arch_memory_mapping.c
rename to target/i386/arch_memory_mapping.c
diff --git a/target-i386/bpt_helper.c b/target/i386/bpt_helper.c
similarity index 100%
rename from target-i386/bpt_helper.c
rename to target/i386/bpt_helper.c
diff --git a/target-i386/cc_helper.c b/target/i386/cc_helper.c
similarity index 100%
rename from target-i386/cc_helper.c
rename to target/i386/cc_helper.c
diff --git a/target-i386/cc_helper_template.h b/target/i386/cc_helper_template.h
similarity index 100%
rename from target-i386/cc_helper_template.h
rename to target/i386/cc_helper_template.h
diff --git a/target-i386/cpu-qom.h b/target/i386/cpu-qom.h
similarity index 100%
rename from target-i386/cpu-qom.h
rename to target/i386/cpu-qom.h
diff --git a/target-i386/cpu.c b/target/i386/cpu.c
similarity index 100%
rename from target-i386/cpu.c
rename to target/i386/cpu.c
diff --git a/target-i386/cpu.h b/target/i386/cpu.h
similarity index 100%
rename from target-i386/cpu.h
rename to target/i386/cpu.h
diff --git a/target-i386/excp_helper.c b/target/i386/excp_helper.c
similarity index 100%
rename from target-i386/excp_helper.c
rename to target/i386/excp_helper.c
diff --git a/target-i386/fpu_helper.c b/target/i386/fpu_helper.c
similarity index 100%
rename from target-i386/fpu_helper.c
rename to target/i386/fpu_helper.c
diff --git a/target-i386/gdbstub.c b/target/i386/gdbstub.c
similarity index 100%
rename from target-i386/gdbstub.c
rename to target/i386/gdbstub.c
diff --git a/target-i386/helper.c b/target/i386/helper.c
similarity index 100%
rename from target-i386/helper.c
rename to target/i386/helper.c
diff --git a/target-i386/helper.h b/target/i386/helper.h
similarity index 100%
rename from target-i386/helper.h
rename to target/i386/helper.h
diff --git a/target-i386/hyperv.c b/target/i386/hyperv.c
similarity index 100%
rename from target-i386/hyperv.c
rename to target/i386/hyperv.c
diff --git a/target-i386/hyperv.h b/target/i386/hyperv.h
similarity index 100%
rename from target-i386/hyperv.h
rename to target/i386/hyperv.h
diff --git a/target-i386/int_helper.c b/target/i386/int_helper.c
similarity index 100%
rename from target-i386/int_helper.c
rename to target/i386/int_helper.c
diff --git a/target-i386/kvm-stub.c b/target/i386/kvm-stub.c
similarity index 100%
rename from target-i386/kvm-stub.c
rename to target/i386/kvm-stub.c
diff --git a/target-i386/kvm.c b/target/i386/kvm.c
similarity index 100%
rename from target-i386/kvm.c
rename to target/i386/kvm.c
diff --git a/target-i386/kvm_i386.h b/target/i386/kvm_i386.h
similarity index 100%
rename from target-i386/kvm_i386.h
rename to target/i386/kvm_i386.h
diff --git a/target-i386/machine.c b/target/i386/machine.c
similarity index 100%
rename from target-i386/machine.c
rename to target/i386/machine.c
diff --git a/target-i386/mem_helper.c b/target/i386/mem_helper.c
similarity index 100%
rename from target-i386/mem_helper.c
rename to target/i386/mem_helper.c
diff --git a/target-i386/misc_helper.c b/target/i386/misc_helper.c
similarity index 100%
rename from target-i386/misc_helper.c
rename to target/i386/misc_helper.c
diff --git a/target-i386/monitor.c b/target/i386/monitor.c
similarity index 100%
rename from target-i386/monitor.c
rename to target/i386/monitor.c
diff --git a/target-i386/mpx_helper.c b/target/i386/mpx_helper.c
similarity index 100%
rename from target-i386/mpx_helper.c
rename to target/i386/mpx_helper.c
diff --git a/target-i386/ops_sse.h b/target/i386/ops_sse.h
similarity index 100%
rename from target-i386/ops_sse.h
rename to target/i386/ops_sse.h
diff --git a/target-i386/ops_sse_header.h b/target/i386/ops_sse_header.h
similarity index 100%
rename from target-i386/ops_sse_header.h
rename to target/i386/ops_sse_header.h
diff --git a/target-i386/seg_helper.c b/target/i386/seg_helper.c
similarity index 100%
rename from target-i386/seg_helper.c
rename to target/i386/seg_helper.c
diff --git a/target-i386/shift_helper_template.h b/target/i386/shift_helper_template.h
similarity index 100%
rename from target-i386/shift_helper_template.h
rename to target/i386/shift_helper_template.h
diff --git a/target-i386/smm_helper.c b/target/i386/smm_helper.c
similarity index 100%
rename from target-i386/smm_helper.c
rename to target/i386/smm_helper.c
diff --git a/target-i386/svm.h b/target/i386/svm.h
similarity index 100%
rename from target-i386/svm.h
rename to target/i386/svm.h
diff --git a/target-i386/svm_helper.c b/target/i386/svm_helper.c
similarity index 100%
rename from target-i386/svm_helper.c
rename to target/i386/svm_helper.c
diff --git a/target-i386/trace-events b/target/i386/trace-events
similarity index 94%
rename from target-i386/trace-events
rename to target/i386/trace-events
index 05c5453..de6a1cf 100644
--- a/target-i386/trace-events
+++ b/target/i386/trace-events
@@ -1,6 +1,6 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-i386/kvm.c
+# target/i386/kvm.c
 kvm_x86_fixup_msi_error(uint32_t gsi) "VT-d failed to remap interrupt for GSI %" PRIu32
 kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
diff --git a/target-i386/translate.c b/target/i386/translate.c
similarity index 100%
rename from target-i386/translate.c
rename to target/i386/translate.c
-- 
1.8.3.1
