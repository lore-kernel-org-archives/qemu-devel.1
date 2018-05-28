Received: from eggs.gnu.org ([2001:4830:134:3::10]:32852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYg-0007CE-OF
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYd-000148-Di
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:07 -0300
Message-Id: <20180528232719.4721-10-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/21] target: Do not include
 "exec/exec-all.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

Code change produced with:
    $ git grep '#include "exec/exec-all.h"' | \
      cut -d: -f-1 | \
      xargs egrep -L "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GETPC|singlestep|TranslationBlock)" | \
      xargs sed -i.bak '/#include "exec\/exec-all.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 bsd-user/qemu.h                        | 1 -
 target/arm/arm_ldst.h                  | 1 -
 hw/i386/kvmvapic.c                     | 1 -
 target/arm/arm-powerctl.c              | 1 -
 target/arm/crypto_helper.c             | 1 -
 target/arm/iwmmxt_helper.c             | 1 -
 target/arm/neon_helper.c               | 1 -
 target/arm/psci.c                      | 1 -
 target/arm/vec_helper.c                | 1 -
 target/cris/cpu.c                      | 1 -
 target/hppa/helper.c                   | 1 -
 target/hppa/int_helper.c               | 1 -
 target/i386/hax-all.c                  | 1 -
 target/i386/hax-mem.c                  | 1 -
 target/i386/hax-windows.c              | 1 -
 target/i386/hvf/hvf.c                  | 1 -
 target/i386/hvf/x86_task.c             | 1 -
 target/i386/whpx-all.c                 | 1 -
 target/lm32/cpu.c                      | 1 -
 target/m68k/cpu.c                      | 1 -
 target/moxie/cpu.c                     | 1 -
 target/moxie/mmu.c                     | 1 -
 target/openrisc/cpu.c                  | 1 -
 target/ppc/int_helper.c                | 1 -
 target/s390x/cpu.c                     | 1 -
 target/s390x/diag.c                    | 1 -
 target/s390x/helper.c                  | 1 -
 target/tilegx/cpu.c                    | 1 -
 target/xtensa/core-dc232b.c            | 1 -
 target/xtensa/core-dc233c.c            | 1 -
 target/xtensa/core-de212.c             | 1 -
 target/xtensa/core-fsf.c               | 1 -
 target/xtensa/core-sample_controller.c | 1 -
 target/xtensa/cpu.c                    | 1 -
 tcg/tcg-op-vec.c                       | 1 -
 target/xtensa/import_core.sh           | 1 -
 36 files changed, 36 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 19b2b8fecb..09e8aed9c7 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -19,7 +19,6 @@
 
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 
 #undef DEBUG_REMAP
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 01587b3ebb..5e0ac8bef0 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -20,7 +20,6 @@
 #ifndef ARM_LDST_H
 #define ARM_LDST_H
 
-#include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/bswap.h"
 
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index fc962c5fbc..70f6f26a94 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 25207cb850..ce55eeb682 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -15,7 +15,6 @@
 #include "arm-powerctl.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "exec/exec-all.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index cc339ea7e0..f800266727 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 
diff --git a/target/arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
index 7d87e1a0a8..f6a4fc5b7f 100644
--- a/target/arm/iwmmxt_helper.c
+++ b/target/arm/iwmmxt_helper.c
@@ -22,7 +22,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 
 /* iwMMXt macros extracted from GNU gdb.  */
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index a1ec6537eb..c2c6491a83 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/psci.c b/target/arm/psci.c
index eb7b88e926..a74d78802a 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -22,7 +22,6 @@
 #include "sysemu/sysemu.h"
 #include "internals.h"
 #include "arm-powerctl.h"
-#include "exec/exec-all.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index ec705cfca5..25e209da31 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index db8d0884a1..a23aba2688 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "mmu.h"
-#include "exec/exec-all.h"
 
 
 static void cris_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 858ec205b6..6539061e52 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 561bf6eb60..8d5edd3a20 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qom/cpu.h"
 
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index c5856bbdc3..d2e512856b 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
 
 #include "qemu-common.h"
 #include "hax-i386.h"
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index f46e85544d..5c37e94caa 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
 #include "qemu/error-report.h"
 
 #include "target/i386/hax-i386.h"
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index b1ac737ae4..5729ad9b48 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "hax-i386.h"
 
 /*
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index f6c872e678..df69e6d0a7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -65,7 +65,6 @@
 #include <Hypervisor/hv_vmx.h>
 
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 7610d85802..7099335e89 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -26,7 +26,6 @@
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 
-#include "exec/exec-all.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 58435178a4..bd7df10ba5 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
 #include "exec/ioport.h"
 #include "qemu-common.h"
 #include "strings.h"
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 0003152469..b7499cb627 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -22,7 +22,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu-common.h"
-#include "exec/exec-all.h"
 
 
 static void lm32_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index a4ed8770aa..582e3a73b3 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
-#include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 4170284da6..8d67eb6727 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -23,7 +23,6 @@
 #include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "machine.h"
-#include "exec/exec-all.h"
 
 static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/moxie/mmu.c b/target/moxie/mmu.c
index 9203330b3b..bd90b1eebc 100644
--- a/target/moxie/mmu.c
+++ b/target/moxie/mmu.c
@@ -21,7 +21,6 @@
 
 #include "cpu.h"
 #include "mmu.h"
-#include "exec/exec-all.h"
 
 int moxie_mmu_translate(MoxieMMUResult *res,
                        CPUMoxieState *env, uint32_t vaddr,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 20b115afae..a692a98ec0 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -21,7 +21,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu-common.h"
-#include "exec/exec-all.h"
 
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1607a7a42b..03d37da79f 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c2b775f4eb..c268065887 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -38,7 +38,6 @@
 #include "qapi/qapi-visit-misc.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "sysemu/hw_accel.h"
-#include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index ac2c40f363..0a1fabee51 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -16,7 +16,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index fd5791f134..254631693d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -23,7 +23,6 @@
 #include "internal.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
 #include "hw/s390x/ioinst.h"
 #include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index b7451bdcf2..bfe9be59b5 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
-#include "exec/exec-all.h"
 
 static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
                                   fprintf_function cpu_fprintf, int flags)
diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 70f33622ec..7131337840 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
 #include "qemu/timer.h"
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index 8296e6fa10..d701e3f5de 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/core-de212.c b/target/xtensa/core-de212.c
index 53775a97fa..7322179b56 100644
--- a/target/xtensa/core-de212.c
+++ b/target/xtensa/core-de212.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/core-fsf.c b/target/xtensa/core-fsf.c
index 01932bdc8b..e100e212b9 100644
--- a/target/xtensa/core-fsf.c
+++ b/target/xtensa/core-fsf.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/core-sample_controller.c b/target/xtensa/core-sample_controller.c
index c622335ca5..f433ea8d66 100644
--- a/target/xtensa/core-sample_controller.c
+++ b/target/xtensa/core-sample_controller.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2b5b537222..b50c840e09 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -33,7 +33,6 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
-#include "exec/exec-all.h"
 
 
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 2ca219734d..cefba3d185 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "tcg.h"
 #include "tcg-op.h"
 #include "tcg-mo.h"
diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index af6c610479..039406bf28 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -39,7 +39,6 @@ tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
 cat <<EOF > "${TARGET}.c"
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
-- 
2.17.0
