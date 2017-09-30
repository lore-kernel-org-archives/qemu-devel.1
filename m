Received: from eggs.gnu.org ([2001:4830:134:3::10]:60927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5XX-00063G-Vy
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5XR-00075s-SQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:21:55 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:17:26 -0700
Message-ID: <d64ca97ec0058b24002c387264654b4b322ad7a1.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 47/47] target: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
---

 target/arm/arm-powerctl.c    |  5 +++--
 target/arm/arm-semi.c        |  3 ++-
 target/arm/helper.c          |  4 ++--
 target/arm/kvm.c             | 16 ++++++-------
 target/arm/kvm32.c           |  2 +-
 target/arm/kvm64.c           |  2 +-
 target/arm/translate-a64.c   |  4 ++--
 target/arm/translate.c       |  2 +-
 target/cris/helper.c         |  2 +-
 target/i386/hax-all.c        | 52 +++++++++++++++++++++----------------------
 target/i386/hax-darwin.c     | 26 +++++++++++-----------
 target/i386/hax-mem.c        |  4 ++--
 target/i386/hax-windows.c    | 42 +++++++++++++++++------------------
 target/i386/kvm.c            | 38 +++++++++++++++----------------
 target/i386/misc_helper.c    | 12 +++++-----
 target/lm32/op_helper.c      |  4 ++--
 target/mips/mips-semi.c      |  3 ++-
 target/mips/translate.c      |  2 +-
 target/ppc/excp_helper.c     |  4 ++--
 target/ppc/kvm.c             | 34 ++++++++++++++--------------
 target/ppc/mmu-hash64.c      |  2 +-
 target/ppc/mmu_helper.c      |  2 +-
 target/ppc/translate_init.c  | 53 ++++++++++++++++++++++----------------------
 target/s390x/kvm.c           | 20 ++++++++---------
 target/s390x/misc_helper.c   |  2 +-
 target/unicore32/translate.c |  2 +-
 26 files changed, 173 insertions(+), 169 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 25207cb850..2d56d5d579 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "cpu-qom.h"
 #include "internals.h"
@@ -24,7 +25,7 @@
 #define DPRINTF(fmt, args...) \
     do { \
         if (DEBUG_ARM_POWERCTL) { \
-            fprintf(stderr, "[ARM]%s: " fmt , __func__, ##args); \
+            error_report("[ARM]%s: " fmt , __func__, ##args); \
         } \
     } while (0)
 
@@ -32,7 +33,7 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
 {
     CPUState *cpu;
 
-    DPRINTF("cpu %" PRId64 "\n", id);
+    DPRINTF("cpu %" PRId64 "", id);
 
     CPU_FOREACH(cpu) {
         ARMCPU *armcpu = ARM_CPU(cpu);
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 7cac8734c7..f8f12102f1 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include "cpu.h"
 #include "exec/semihost.h"
@@ -649,7 +650,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
         /* fall through -- invalid for A32/T32 */
     default:
-        fprintf(stderr, "qemu: Unsupported SemiHosting SWI 0x%02x\n", nr);
+        error_report("qemu: Unsupported SemiHosting SWI 0x%02x", nr);
         cpu_dump_state(cs, stderr, fprintf, 0);
         abort();
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8be78ea2f8..881afc3382 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5460,9 +5460,9 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         ARMCPRegInfo *oldreg;
         oldreg = g_hash_table_lookup(cpu->cp_regs, key);
         if (oldreg && !(oldreg->type & ARM_CP_OVERRIDE)) {
-            fprintf(stderr, "Register redefined: cp=%d %d bit "
+            error_report("Register redefined: cp=%d %d bit "
                     "crn=%d crm=%d opc1=%d opc2=%d, "
-                    "was %s, now %s\n", r2->cp, 32 + 32 * is64,
+                    "was %s, now %s", r2->cp, 32 + 32 * is64,
                     r2->crn, r2->crm, r2->opc1, r2->opc2,
                     oldreg->name, r2->name);
             g_assert_not_reached();
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 211a7bf7be..0165960405 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -139,7 +139,7 @@ static void kvm_arm_host_cpu_class_init(ObjectClass *oc, void *data)
      * TCG CPUs.
      */
     if (!kvm_arm_get_host_cpu_features(ahcc)) {
-        fprintf(stderr, "Failed to retrieve host CPU features!\n");
+        error_report("Failed to retrieve host CPU features!");
         abort();
     }
 }
@@ -256,7 +256,7 @@ static void kvm_arm_set_device_addr(KVMDevice *kd)
     }
 
     if (ret < 0) {
-        fprintf(stderr, "Failed to set device address: %s\n",
+        error_report("Failed to set device address: %s",
                 strerror(-ret));
         abort();
     }
@@ -352,7 +352,7 @@ int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         case KVM_REG_SIZE_U64:
             break;
         default:
-            fprintf(stderr, "Can't handle size of register in kernel list\n");
+            error_report("Can't handle size of register in kernel list");
             ret = -EINVAL;
             goto out;
         }
@@ -383,7 +383,7 @@ int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         /* Shouldn't happen unless kernel is inconsistent about
          * what registers exist.
          */
-        fprintf(stderr, "Initial read of kernel register state failed\n");
+        error_report("Initial read of kernel register state failed");
         ret = -EINVAL;
         goto out;
     }
@@ -478,11 +478,11 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
      */
     ret = kvm_arm_vcpu_init(CPU(cpu));
     if (ret < 0) {
-        fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
+        error_report("kvm_arm_vcpu_init failed: %s", strerror(-ret));
         abort();
     }
     if (!write_kvmstate_to_list(cpu)) {
-        fprintf(stderr, "write_kvmstate_to_list failed\n");
+        error_report("write_kvmstate_to_list failed");
         abort();
     }
 }
@@ -499,7 +499,7 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
         };
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
         if (ret) {
-            fprintf(stderr, "%s: failed to set MP_STATE %d/%s\n",
+            error_report("%s: failed to set MP_STATE %d/%s",
                     __func__, ret, strerror(-ret));
             return -1;
         }
@@ -517,7 +517,7 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
         struct kvm_mp_state mp_state;
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
         if (ret) {
-            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
+            error_report("%s: failed to get MP_STATE %d/%s",
                     __func__, ret, strerror(-ret));
             abort();
         }
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f925a21481..97d36a174d 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -191,7 +191,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6554c30007..b3e1484069 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -502,7 +502,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
         !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
+        error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 899ffb96fc..eac76a0747 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -505,8 +505,8 @@ static inline void assert_fp_access_checked(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
     if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
-        fprintf(stderr, "target-arm: FP access check missing for "
-                "instruction 0x%08x\n", s->insn);
+        error_report("target-arm: FP access check missing for "
+                "instruction 0x%08x", s->insn);
         abort();
     }
 #endif
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ab1a12a1b8..d484381aef 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -857,7 +857,7 @@ void arm_test_cc(DisasCompare *cmp, int cc)
         goto no_invert;
 
     default:
-        fprintf(stderr, "Bad condition code 0x%x\n", cc);
+        error_report("Bad condition code 0x%x", cc);
         abort();
     }
 
diff --git a/target/cris/helper.c b/target/cris/helper.c
index af78cca8b9..ba9ce538c3 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -282,7 +282,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     if (!miss) {
         phy = res.phy;
     }
-    D(fprintf(stderr, "%s %x -> %x\n", __func__, addr, phy));
+    D(error_report("%s %x -> %x", __func__, addr, phy));
     return phy;
 }
 #endif
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950296..b0462c8b4c 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -100,13 +100,13 @@ static int hax_get_capability(struct hax_state *hax)
     }
 
     if (!(cap->winfo & HAX_CAP_UG)) {
-        fprintf(stderr, "UG mode is not supported by the hardware.\n");
+        error_report("UG mode is not supported by the hardware.");
         return -ENOTSUP;
     }
 
     if (cap->wstatus & HAX_CAP_MEMQUOTA) {
         if (cap->mem_quota < hax->mem_quota) {
-            fprintf(stderr, "The VM memory needed exceeds the driver limit.\n");
+            error_report("The VM memory needed exceeds the driver limit.");
             return -ENOSPC;
         }
     }
@@ -126,13 +126,13 @@ static int hax_version_support(struct hax_state *hax)
     if (hax_min_version > version.cur_version) {
         fprintf(stderr, "Incompatible HAX module version %d,",
                 version.cur_version);
-        fprintf(stderr, "requires minimum version %d\n", hax_min_version);
+        error_report("requires minimum version %d", hax_min_version);
         return 0;
     }
     if (hax_cur_version < version.compat_version) {
         fprintf(stderr, "Incompatible QEMU HAX API version %x,",
                 hax_cur_version);
-        fprintf(stderr, "requires minimum HAX API version %x\n",
+        error_report("requires minimum HAX API version %x",
                 version.compat_version);
         return 0;
     }
@@ -146,18 +146,18 @@ int hax_vcpu_create(int id)
     int ret;
 
     if (!hax_global.vm) {
-        fprintf(stderr, "vcpu %x created failed, vm is null\n", id);
+        error_report("vcpu %x created failed, vm is null", id);
         return -1;
     }
 
     if (hax_global.vm->vcpus[id]) {
-        fprintf(stderr, "vcpu %x allocated already\n", id);
+        error_report("vcpu %x allocated already", id);
         return 0;
     }
 
     vcpu = g_malloc(sizeof(struct hax_vcpu_state));
     if (!vcpu) {
-        fprintf(stderr, "Failed to alloc vcpu state\n");
+        error_report("Failed to alloc vcpu state");
         return -ENOMEM;
     }
 
@@ -165,14 +165,14 @@ int hax_vcpu_create(int id)
 
     ret = hax_host_create_vcpu(hax_global.vm->fd, id);
     if (ret) {
-        fprintf(stderr, "Failed to create vcpu %x\n", id);
+        error_report("Failed to create vcpu %x", id);
         goto error;
     }
 
     vcpu->vcpu_id = id;
     vcpu->fd = hax_host_open_vcpu(hax_global.vm->id, id);
     if (hax_invalid_fd(vcpu->fd)) {
-        fprintf(stderr, "Failed to open the vcpu\n");
+        error_report("Failed to open the vcpu");
         ret = -ENODEV;
         goto error;
     }
@@ -181,7 +181,7 @@ int hax_vcpu_create(int id)
 
     ret = hax_host_setup_vcpu_channel(vcpu);
     if (ret) {
-        fprintf(stderr, "Invalid hax tunnel size\n");
+        error_report("Invalid hax tunnel size");
         ret = -EINVAL;
         goto error;
     }
@@ -203,7 +203,7 @@ int hax_vcpu_destroy(CPUState *cpu)
     struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
 
     if (!hax_global.vm) {
-        fprintf(stderr, "vcpu %x destroy failed, vm is null\n", vcpu->vcpu_id);
+        error_report("vcpu %x destroy failed, vm is null", vcpu->vcpu_id);
         return -1;
     }
 
@@ -227,7 +227,7 @@ int hax_init_vcpu(CPUState *cpu)
 
     ret = hax_vcpu_create(cpu->cpu_index);
     if (ret < 0) {
-        fprintf(stderr, "Failed to create HAX vcpu\n");
+        error_report("Failed to create HAX vcpu");
         exit(-1);
     }
 
@@ -258,13 +258,13 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
     memset(vm, 0, sizeof(struct hax_vm));
     ret = hax_host_create_vm(hax, &vm_id);
     if (ret) {
-        fprintf(stderr, "Failed to create vm %x\n", ret);
+        error_report("Failed to create vm %x", ret);
         goto error;
     }
     vm->id = vm_id;
     vm->fd = hax_host_open_vm(hax, vm_id);
     if (hax_invalid_fd(vm->fd)) {
-        fprintf(stderr, "Failed to open vm %d\n", vm_id);
+        error_report("Failed to open vm %d", vm_id);
         goto error;
     }
 
@@ -283,7 +283,7 @@ int hax_vm_destroy(struct hax_vm *vm)
 
     for (i = 0; i < HAX_MAX_VCPU; i++)
         if (vm->vcpus[i]) {
-            fprintf(stderr, "VCPU should be cleaned before vm clean\n");
+            error_report("VCPU should be cleaned before vm clean");
             return -1;
         }
     hax_close_fd(vm->fd);
@@ -335,7 +335,7 @@ static int hax_init(ram_addr_t ram_size)
 
     hax->vm = hax_vm_create(hax);
     if (!hax->vm) {
-        fprintf(stderr, "Failed to create HAX VM\n");
+        error_report("Failed to create HAX VM");
         ret = -EINVAL;
         goto error;
     }
@@ -364,7 +364,7 @@ static int hax_accel_init(MachineState *ms)
     int ret = hax_init(ms->ram_size);
 
     if (ret && (ret != -ENOSPC)) {
-        fprintf(stderr, "No accelerator found.\n");
+        error_report("No accelerator found.");
     } else {
         fprintf(stdout, "HAX is %s and emulator runs in %s mode.\n",
                 !ret ? "working" : "not working",
@@ -526,7 +526,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         }
 
         if (hax_ret < 0) {
-            fprintf(stderr, "vcpu run failed for vcpu  %x\n", vcpu->vcpu_id);
+            error_report("vcpu run failed for vcpu  %x", vcpu->vcpu_id);
             abort();
         }
         switch (ht->_exit_status) {
@@ -546,7 +546,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             ret = 1;
             break;
         case HAX_EXIT_UNKNOWN_VMEXIT:
-            fprintf(stderr, "Unknown VMX exit %x from guest\n",
+            error_report("Unknown VMX exit %x from guest",
                     ht->_exit_reason);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
@@ -569,16 +569,16 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             break;
         case HAX_EXIT_MMIO:
             /* Should not happen on UG system */
-            fprintf(stderr, "HAX: unsupported MMIO emulation\n");
+            error_report("HAX: unsupported MMIO emulation");
             ret = -1;
             break;
         case HAX_EXIT_REAL:
             /* Should not happen on UG system */
-            fprintf(stderr, "HAX: unimplemented real mode emulation\n");
+            error_report("HAX: unimplemented real mode emulation");
             ret = -1;
             break;
         default:
-            fprintf(stderr, "Unknown exit %x from HAX\n", ht->_exit_status);
+            error_report("Unknown exit %x from HAX", ht->_exit_status);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
             cpu_dump_state(cpu, stderr, fprintf, 0);
@@ -662,7 +662,7 @@ int hax_smp_cpu_exec(CPUState *cpu)
         fatal = hax_vcpu_hax_exec(env);
 
         if (fatal) {
-            fprintf(stderr, "Unsupported HAX vcpu return\n");
+            error_report("Unsupported HAX vcpu return");
             abort();
         }
     }
@@ -1079,17 +1079,17 @@ static int hax_arch_set_registers(CPUArchState *env)
     ret = hax_sync_vcpu_register(env, 1);
 
     if (ret < 0) {
-        fprintf(stderr, "Failed to sync vcpu reg\n");
+        error_report("Failed to sync vcpu reg");
         return ret;
     }
     ret = hax_set_fpu(env);
     if (ret < 0) {
-        fprintf(stderr, "FPU failed\n");
+        error_report("FPU failed");
         return ret;
     }
     ret = hax_set_msrs(env);
     if (ret < 0) {
-        fprintf(stderr, "MSR failed\n");
+        error_report("MSR failed");
         return ret;
     }
 
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
index 1c5bbd0a2d..768521b6d0 100644
--- a/target/i386/hax-darwin.c
+++ b/target/i386/hax-darwin.c
@@ -24,7 +24,7 @@ hax_fd hax_mod_open(void)
 {
     int fd = open("/dev/HAX", O_RDWR);
     if (fd == -1) {
-        fprintf(stderr, "Failed to open the hax module\n");
+        error_report("Failed to open the hax module");
     }
 
     fcntl(fd, F_SETFD, FD_CLOEXEC);
@@ -38,7 +38,7 @@ int hax_populate_ram(uint64_t va, uint32_t size)
     struct hax_alloc_ram_info info;
 
     if (!hax_global.vm || !hax_global.vm->fd) {
-        fprintf(stderr, "Allocate memory before vm create?\n");
+        error_report("Allocate memory before vm create?");
         return -EINVAL;
     }
 
@@ -46,7 +46,7 @@ int hax_populate_ram(uint64_t va, uint32_t size)
     info.va = va;
     ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_ALLOC_RAM, &info);
     if (ret < 0) {
-        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        error_report("Failed to allocate %x memory", size);
         return ret;
     }
     return 0;
@@ -75,7 +75,7 @@ int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap)
 
     ret = ioctl(hax->fd, HAX_IOCTL_CAPABILITY, cap);
     if (ret == -1) {
-        fprintf(stderr, "Failed to get HAX capability\n");
+        error_report("Failed to get HAX capability");
         return -errno;
     }
 
@@ -88,7 +88,7 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
 
     ret = ioctl(hax->fd, HAX_IOCTL_VERSION, version);
     if (ret == -1) {
-        fprintf(stderr, "Failed to get HAX version\n");
+        error_report("Failed to get HAX version");
         return -errno;
     }
 
@@ -100,7 +100,7 @@ static char *hax_vm_devfs_string(int vm_id)
     char *name;
 
     if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
+        error_report("Too big VM id");
         return NULL;
     }
 
@@ -119,7 +119,7 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
     char *name;
 
     if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id);
+        error_report("Too big vm id %x or vcpu id %x", vm_id, vcpu_id);
         return NULL;
     }
 
@@ -181,7 +181,7 @@ int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion)
     ret = ioctl(vm_fd, HAX_VM_IOCTL_NOTIFY_QEMU_VERSION, qversion);
 
     if (ret < 0) {
-        fprintf(stderr, "Failed to notify qemu API version\n");
+        error_report("Failed to notify qemu API version");
         return ret;
     }
     return 0;
@@ -196,7 +196,7 @@ int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid)
 
     ret = ioctl(vm_fd, HAX_VM_IOCTL_VCPU_CREATE, &vcpuid);
     if (ret < 0) {
-        fprintf(stderr, "Failed to create vcpu %x\n", vcpuid);
+        error_report("Failed to create vcpu %x", vcpuid);
     }
 
     return ret;
@@ -209,14 +209,14 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
 
     devfs_path = hax_vcpu_devfs_string(vmid, vcpuid);
     if (!devfs_path) {
-        fprintf(stderr, "Failed to get the devfs\n");
+        error_report("Failed to get the devfs");
         return -EINVAL;
     }
 
     fd = open(devfs_path, O_RDWR);
     g_free(devfs_path);
     if (fd < 0) {
-        fprintf(stderr, "Failed to open the vcpu devfs\n");
+        error_report("Failed to open the vcpu devfs");
     }
     fcntl(fd, F_SETFD, FD_CLOEXEC);
     return fd;
@@ -229,12 +229,12 @@ int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
 
     ret = ioctl(vcpu->fd, HAX_VCPU_IOCTL_SETUP_TUNNEL, &info);
     if (ret) {
-        fprintf(stderr, "Failed to setup the hax tunnel\n");
+        error_report("Failed to setup the hax tunnel");
         return ret;
     }
 
     if (!valid_hax_tunnel_size(info.size)) {
-        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
+        error_report("Invalid hax tunnel size %x", info.size);
         ret = -EINVAL;
         return ret;
     }
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 27a0d214f2..e1388bb003 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -247,8 +247,8 @@ static void hax_transaction_commit(MemoryListener *listener)
             }
             if (hax_set_ram(entry->start_pa, entry->size,
                             entry->host_va, entry->flags)) {
-                fprintf(stderr, "%s: Failed mapping @0x%016" PRIx64 "+0x%"
-                        PRIx32 " flags %02x\n", __func__, entry->start_pa,
+                error_report("%s: Failed mapping @0x%016" PRIx64 "+0x%"
+                        PRIx32 " flags %02x", __func__, entry->start_pa,
                         entry->size, entry->flags);
             }
             QTAILQ_REMOVE(&mappings, entry, entry);
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 15a180b646..8d724d21ad 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -33,7 +33,7 @@ static int hax_open_device(hax_fd *fd)
                          0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
 
     if (hDevice == INVALID_HANDLE_VALUE) {
-        fprintf(stderr, "Failed to open the HAX device!\n");
+        error_report("Failed to open the HAX device!");
         errNum = GetLastError();
         if (errNum == ERROR_FILE_NOT_FOUND) {
             return -1;
@@ -52,7 +52,7 @@ static int hax_open_device(hax_fd *fd)
 
     ret = hax_open_device(&fd);
     if (ret != 0) {
-        fprintf(stderr, "Open HAX device failed\n");
+        error_report("Open HAX device failed");
     }
 
     return fd;
@@ -66,7 +66,7 @@ int hax_populate_ram(uint64_t va, uint32_t size)
     DWORD dSize = 0;
 
     if (!hax_global.vm || !hax_global.vm->fd) {
-        fprintf(stderr, "Allocate memory before vm create?\n");
+        error_report("Allocate memory before vm create?");
         return -EINVAL;
     }
 
@@ -81,7 +81,7 @@ int hax_populate_ram(uint64_t va, uint32_t size)
                           (LPOVERLAPPED) NULL);
 
     if (!ret) {
-        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        error_report("Failed to allocate %x memory", size);
         return ret;
     }
 
@@ -119,7 +119,7 @@ int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap)
     DWORD err = 0;
 
     if (hax_invalid_fd(hDevice)) {
-        fprintf(stderr, "Invalid fd for hax device!\n");
+        error_report("Invalid fd for hax device!");
         return -ENODEV;
     }
 
@@ -129,9 +129,9 @@ int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap)
     if (!ret) {
         err = GetLastError();
         if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
-            fprintf(stderr, "hax capability is too long to hold.\n");
+            error_report("hax capability is too long to hold.");
         }
-        fprintf(stderr, "Failed to get Hax capability:%luu\n", err);
+        error_report("Failed to get Hax capability:%luu", err);
         return -EFAULT;
     } else {
         return 0;
@@ -146,7 +146,7 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
     DWORD err = 0;
 
     if (hax_invalid_fd(hDevice)) {
-        fprintf(stderr, "Invalid fd for hax device!\n");
+        error_report("Invalid fd for hax device!");
         return -ENODEV;
     }
 
@@ -159,9 +159,9 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
     if (!ret) {
         err = GetLastError();
         if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
-            fprintf(stderr, "hax module verion is too long to hold.\n");
+            error_report("hax module verion is too long to hold.");
         }
-        fprintf(stderr, "Failed to get Hax module version:%lu\n", err);
+        error_report("Failed to get Hax module version:%lu", err);
         return -EFAULT;
     } else {
         return 0;
@@ -173,7 +173,7 @@ static char *hax_vm_devfs_string(int vm_id)
     char *name;
 
     if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
+        error_report("Too big VM id");
         return NULL;
     }
 
@@ -192,7 +192,7 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
     char *name;
 
     if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id);
+        error_report("Too big vm id %x or vcpu id %x", vm_id, vcpu_id);
         return NULL;
     }
 
@@ -226,7 +226,7 @@ int hax_host_create_vm(struct hax_state *hax, int *vmid)
                           NULL, 0, &vm_id, sizeof(vm_id), &dSize,
                           (LPOVERLAPPED) NULL);
     if (!ret) {
-        fprintf(stderr, "Failed to create VM. Error code: %lu\n",
+        error_report("Failed to create VM. Error code: %lu",
                 GetLastError());
         return -1;
     }
@@ -241,7 +241,7 @@ hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
 
     vm_name = hax_vm_devfs_string(vm_id);
     if (!vm_name) {
-        fprintf(stderr, "Failed to open VM. VM name is null\n");
+        error_report("Failed to open VM. VM name is null");
         return INVALID_HANDLE_VALUE;
     }
 
@@ -249,7 +249,7 @@ hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
                            GENERIC_READ | GENERIC_WRITE,
                            0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
     if (hDeviceVM == INVALID_HANDLE_VALUE) {
-        fprintf(stderr, "Open the vm device error:%s, ec:%lu\n",
+        error_report("Open the vm device error:%s, ec:%lu",
                 vm_name, GetLastError());
     }
 
@@ -269,7 +269,7 @@ int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion)
                           qversion, sizeof(struct hax_qemu_version),
                           NULL, 0, &dSize, (LPOVERLAPPED) NULL);
     if (!ret) {
-        fprintf(stderr, "Failed to notify qemu API version\n");
+        error_report("Failed to notify qemu API version");
         return -1;
     }
     return 0;
@@ -285,7 +285,7 @@ int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid)
                           &vcpuid, sizeof(vcpuid), NULL, 0, &dSize,
                           (LPOVERLAPPED) NULL);
     if (!ret) {
-        fprintf(stderr, "Failed to create vcpu %x\n", vcpuid);
+        error_report("Failed to create vcpu %x", vcpuid);
         return -1;
     }
 
@@ -299,7 +299,7 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
 
     devfs_path = hax_vcpu_devfs_string(vmid, vcpuid);
     if (!devfs_path) {
-        fprintf(stderr, "Failed to get the devfs\n");
+        error_report("Failed to get the devfs");
         return INVALID_HANDLE_VALUE;
     }
 
@@ -309,7 +309,7 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
                              NULL);
 
     if (hDeviceVCPU == INVALID_HANDLE_VALUE) {
-        fprintf(stderr, "Failed to open the vcpu devfs\n");
+        error_report("Failed to open the vcpu devfs");
     }
     g_free(devfs_path);
     return hDeviceVCPU;
@@ -327,12 +327,12 @@ int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
                           NULL, 0, &info, sizeof(info), &dSize,
                           (LPOVERLAPPED) NULL);
     if (!ret) {
-        fprintf(stderr, "Failed to setup the hax tunnel\n");
+        error_report("Failed to setup the hax tunnel");
         return -1;
     }
 
     if (!valid_hax_tunnel_size(info.size)) {
-        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
+        error_report("Invalid hax tunnel size %x", info.size);
         ret = -EINVAL;
         return ret;
     }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b1e32e95d3..d7cf10ae11 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -219,7 +219,7 @@ static struct kvm_cpuid2 *try_get_cpuid(KVMState *s, int max)
             g_free(cpuid);
             return NULL;
         } else {
-            fprintf(stderr, "KVM_GET_SUPPORTED_CPUID failed: %s\n",
+            error_report("KVM_GET_SUPPORTED_CPUID failed: %s",
                     strerror(-r));
             exit(1);
         }
@@ -470,7 +470,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 
 static void hardware_memory_error(void)
 {
-    fprintf(stderr, "Hardware memory error!\n");
+    error_report("Hardware memory error!");
     exit(1);
 }
 
@@ -497,8 +497,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             return;
         }
 
-        fprintf(stderr, "Hardware memory error for memory used by "
-                "QEMU itself instead of guest system!\n");
+        error_report("Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!");
     }
 
     if (code == BUS_MCEERR_AR) {
@@ -666,7 +666,7 @@ static int hyperv_handle_properties(CPUState *cs)
 
         if (!has_msr_hv_synic ||
             kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
-            fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
+            error_report("Hyper-V SynIC is not supported by kernel");
             return -ENOSYS;
         }
 
@@ -678,7 +678,7 @@ static int hyperv_handle_properties(CPUState *cs)
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
-            fprintf(stderr, "Hyper-V timers aren't supported by kernel\n");
+            error_report("Hyper-V timers aren't supported by kernel");
             return -ENOSYS;
         }
         env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
@@ -811,7 +811,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     for (i = 0; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported level value: 0x%x\n", limit);
+            error_report("unsupported level value: 0x%x", limit);
             abort();
         }
         c = &cpuid_data.entries[cpuid_i++];
@@ -829,8 +829,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
             for (j = 1; j < times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
+                    error_report("cpuid_data is full, no space for "
+                            "cpuid(eax:2):eax & 0xf = 0x%x", times);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
@@ -862,8 +862,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
                     continue;
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    error_report("cpuid_data is full, no space for "
+                            "cpuid(eax:0x%x,ecx:0x%x)", i, j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
@@ -899,7 +899,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     for (i = 0x80000000; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
+            error_report("unsupported xlevel value: 0x%x", limit);
             abort();
         }
         c = &cpuid_data.entries[cpuid_i++];
@@ -915,7 +915,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         for (i = 0xC0000000; i <= limit; i++) {
             if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
+                error_report("unsupported xlevel2 value: 0x%x", limit);
                 abort();
             }
             c = &cpuid_data.entries[cpuid_i++];
@@ -1245,7 +1245,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
     ret = e820_add_entry(identity_base, 0x4000, E820_RESERVED);
     if (ret < 0) {
-        fprintf(stderr, "e820_add_entry() table is full\n");
+        error_report("e820_add_entry() table is full");
         return ret;
     }
     qemu_register_reset(kvm_unpoison_all, NULL);
@@ -2733,7 +2733,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
             if (ret < 0) {
-                fprintf(stderr, "KVM: injection failed, NMI lost (%s)\n",
+                error_report("KVM: injection failed, NMI lost (%s)",
                         strerror(-ret));
             }
         }
@@ -2744,7 +2744,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
             if (ret < 0) {
-                fprintf(stderr, "KVM: injection failed, SMI lost (%s)\n",
+                error_report("KVM: injection failed, SMI lost (%s)",
                         strerror(-ret));
             }
         }
@@ -3141,7 +3141,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
     case KVM_EXIT_FAIL_ENTRY:
         code = run->fail_entry.hardware_entry_failure_reason;
-        fprintf(stderr, "KVM: entry failed, hardware error 0x%" PRIx64 "\n",
+        error_report("KVM: entry failed, hardware error 0x%" PRIx64 "",
                 code);
         if (host_supports_vmx() && code == VMX_INVALID_GUEST_STATE) {
             fprintf(stderr,
@@ -3157,7 +3157,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = -1;
         break;
     case KVM_EXIT_EXCEPTION:
-        fprintf(stderr, "KVM: exception %d exit (error code 0x%x)\n",
+        error_report("KVM: exception %d exit (error code 0x%x)",
                 run->ex.exception, run->ex.error_code);
         ret = -1;
         break;
@@ -3175,7 +3175,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = 0;
         break;
     default:
-        fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
+        error_report("KVM: unknown exit reason %d", run->exit_reason);
         ret = -1;
         break;
     }
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 628f64aad5..115e80217e 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -28,7 +28,7 @@
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "outb: port=0x%04x, data=%02x\n", port, data);
+    error_report("outb: port=0x%04x, data=%02x", port, data);
 #else
     address_space_stb(&address_space_io, port, data,
                       cpu_get_mem_attrs(env), NULL);
@@ -38,7 +38,7 @@ void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
 target_ulong helper_inb(CPUX86State *env, uint32_t port)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "inb: port=0x%04x\n", port);
+    error_report("inb: port=0x%04x", port);
     return 0;
 #else
     return address_space_ldub(&address_space_io, port,
@@ -49,7 +49,7 @@ target_ulong helper_inb(CPUX86State *env, uint32_t port)
 void helper_outw(CPUX86State *env, uint32_t port, uint32_t data)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "outw: port=0x%04x, data=%04x\n", port, data);
+    error_report("outw: port=0x%04x, data=%04x", port, data);
 #else
     address_space_stw(&address_space_io, port, data,
                       cpu_get_mem_attrs(env), NULL);
@@ -59,7 +59,7 @@ void helper_outw(CPUX86State *env, uint32_t port, uint32_t data)
 target_ulong helper_inw(CPUX86State *env, uint32_t port)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "inw: port=0x%04x\n", port);
+    error_report("inw: port=0x%04x", port);
     return 0;
 #else
     return address_space_lduw(&address_space_io, port,
@@ -70,7 +70,7 @@ target_ulong helper_inw(CPUX86State *env, uint32_t port)
 void helper_outl(CPUX86State *env, uint32_t port, uint32_t data)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "outw: port=0x%04x, data=%08x\n", port, data);
+    error_report("outw: port=0x%04x, data=%08x", port, data);
 #else
     address_space_stl(&address_space_io, port, data,
                       cpu_get_mem_attrs(env), NULL);
@@ -80,7 +80,7 @@ void helper_outl(CPUX86State *env, uint32_t port, uint32_t data)
 target_ulong helper_inl(CPUX86State *env, uint32_t port)
 {
 #ifdef CONFIG_USER_ONLY
-    fprintf(stderr, "inl: port=0x%04x\n", port);
+    error_report("inl: port=0x%04x", port);
     return 0;
 #else
     return address_space_ldl(&address_space_io, port,
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 2177c8ad12..34bfc3fb3b 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -40,9 +40,9 @@ void HELPER(ill)(CPULM32State *env)
 {
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = CPU(lm32_env_get_cpu(env));
-    fprintf(stderr, "VM paused due to illegal instruction. "
+    error_report("VM paused due to illegal instruction. "
             "Connect a debugger or switch to the monitor console "
-            "to find out more.\n");
+            "to find out more.");
     vm_stop(RUN_STATE_PAUSED);
     cs->halted = 1;
     raise_exception(env, EXCP_HALTED);
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index a7aefbaefc..c1f35f8f5a 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
@@ -366,7 +367,7 @@ void helper_do_semihosting(CPUMIPSState *env)
         break;
 #endif
     default:
-        fprintf(stderr, "Unknown UHI operation %d\n", op);
+        error_report("Unknown UHI operation %d", op);
         abort();
     }
 uhi_done:
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d16d879df7..32a5920259 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10886,7 +10886,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
             tcg_gen_lookup_and_goto_ptr(cpu_PC);
             break;
         default:
-            fprintf(stderr, "unknown branch 0x%x\n", proc_hflags);
+            error_report("unknown branch 0x%x", proc_hflags);
             abort();
         }
     }
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e6009e70e5..a142e81a0f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -200,8 +200,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
             /* Machine check exception is not enabled.
              * Enter checkstop state.
              */
-            fprintf(stderr, "Machine check while not allowed. "
-                    "Entering checkstop state\n");
+            error_report("Machine check while not allowed. "
+                    "Entering checkstop state");
             if (qemu_log_separate()) {
                 qemu_log("Machine check while not allowed. "
                         "Entering checkstop state\n");
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 171d3d8040..33c49fe54c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -159,8 +159,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_ppc_pvr_compat = false;
 
     if (!cap_interrupt_level) {
-        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
-                        "VM to stall at times!\n");
+        error_report("KVM: Couldn't find level irq capability. Expect the "
+                        "VM to stall at times!");
     }
 
     kvm_ppc_register_host_cpu_type();
@@ -188,7 +188,7 @@ static int kvm_arch_sync_sregs(PowerPCCPU *cpu)
         return 0;
     } else {
         if (!cap_segstate) {
-            fprintf(stderr, "kvm error: missing PVR setting capability\n");
+            error_report("kvm error: missing PVR setting capability");
             return -ENOSYS;
         }
     }
@@ -237,7 +237,7 @@ static int kvm_booke206_tlb_init(PowerPCCPU *cpu)
 
     ret = kvm_vcpu_enable_cap(cs, KVM_CAP_SW_TLB, 0, (uintptr_t)&cfg);
     if (ret < 0) {
-        fprintf(stderr, "%s: couldn't enable KVM_CAP_SW_TLB: %s\n",
+        error_report("%s: couldn't enable KVM_CAP_SW_TLB: %s",
                 __func__, strerror(-ret));
         return ret;
     }
@@ -552,7 +552,7 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 
     if ((max_hw_breakpoint + max_hw_watchpoint) > MAX_HW_BKPTS) {
-        fprintf(stderr, "Error initializing h/w breakpoints\n");
+        error_report("Error initializing h/w breakpoints");
         return;
     }
 }
@@ -623,7 +623,7 @@ static void kvm_sw_tlb_put(PowerPCCPU *cpu)
 
     ret = kvm_vcpu_ioctl(cs, KVM_DIRTY_TLB, &dirty_tlb);
     if (ret) {
-        fprintf(stderr, "%s: KVM_DIRTY_TLB: %s\n",
+        error_report("%s: KVM_DIRTY_TLB: %s",
                 __func__, strerror(-ret));
     }
 
@@ -1480,7 +1480,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
 static int kvmppc_handle_dcr_read(CPUPPCState *env, uint32_t dcrn, uint32_t *data)
 {
     if (ppc_dcr_read(env->dcr_env, dcrn, data) < 0)
-        fprintf(stderr, "Read to unhandled DCR (0x%x)\n", dcrn);
+        error_report("Read to unhandled DCR (0x%x)", dcrn);
 
     return 0;
 }
@@ -1488,7 +1488,7 @@ static int kvmppc_handle_dcr_read(CPUPPCState *env, uint32_t dcrn, uint32_t *dat
 static int kvmppc_handle_dcr_write(CPUPPCState *env, uint32_t dcrn, uint32_t data)
 {
     if (ppc_dcr_write(env->dcr_env, dcrn, data) < 0)
-        fprintf(stderr, "Write to unhandled DCR (0x%x)\n", dcrn);
+        error_report("Write to unhandled DCR (0x%x)", dcrn);
 
     return 0;
 }
@@ -1799,7 +1799,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
 
     default:
-        fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
+        error_report("KVM: unknown exit reason %d", run->exit_reason);
         ret = -1;
         break;
     }
@@ -1863,7 +1863,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu)
 
     ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_BOOKE_WATCHDOG, 0);
     if (ret < 0) {
-        fprintf(stderr, "%s: couldn't enable KVM_CAP_PPC_BOOKE_WATCHDOG: %s\n",
+        error_report("%s: couldn't enable KVM_CAP_PPC_BOOKE_WATCHDOG: %s",
                 __func__, strerror(-ret));
         return ret;
     }
@@ -2198,7 +2198,7 @@ off_t kvmppc_alloc_rma(void **rma)
 
     fd = kvm_vm_ioctl(kvm_state, KVM_ALLOCATE_RMA, &ret);
     if (fd < 0) {
-        fprintf(stderr, "KVM: Error on KVM_ALLOCATE_RMA: %s\n",
+        error_report("KVM: Error on KVM_ALLOCATE_RMA: %s",
                 strerror(errno));
         return -1;
     }
@@ -2207,7 +2207,7 @@ off_t kvmppc_alloc_rma(void **rma)
 
     *rma = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
     if (*rma == MAP_FAILED) {
-        fprintf(stderr, "KVM: Error mapping RMA: %s\n", strerror(errno));
+        error_report("KVM: Error mapping RMA: %s", strerror(errno));
         return -1;
     };
 
@@ -2309,7 +2309,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
         }
         fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
         if (fd < 0) {
-            fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\n",
+            error_report("KVM: Failed to create TCE table for liobn 0x%x",
                     liobn);
             return NULL;
         }
@@ -2322,7 +2322,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
 
     table = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
     if (table == MAP_FAILED) {
-        fprintf(stderr, "KVM: Failed to map TCE table for liobn 0x%x\n",
+        error_report("KVM: Failed to map TCE table for liobn 0x%x",
                 liobn);
         close(fd);
         return NULL;
@@ -2590,7 +2590,7 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
     do {
         rc = read(fd, buf, bufsize);
         if (rc < 0) {
-            fprintf(stderr, "Error reading data from KVM HTAB fd: %s\n",
+            error_report("Error reading data from KVM HTAB fd: %s",
                     strerror(errno));
             return rc;
         } else if (rc) {
@@ -2635,13 +2635,13 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
 
     rc = write(fd, buf, chunksize);
     if (rc < 0) {
-        fprintf(stderr, "Error writing KVM hash table: %s\n",
+        error_report("Error writing KVM hash table: %s",
                 strerror(errno));
         return rc;
     }
     if (rc != chunksize) {
         /* We should never get a short write on a single chunk */
-        fprintf(stderr, "Short write, restoring KVM hash table\n");
+        error_report("Short write, restoring KVM hash table");
         return -1;
     }
     return 0;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 14d34e512f..8713ed6682 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -377,7 +377,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
     key = HPTE64_R_KEY(pte.pte1);
     amrbits = (env->spr[SPR_AMR] >> 2*(31 - key)) & 0x3;
 
-    /* fprintf(stderr, "AMR protection: key=%d AMR=0x%" PRIx64 "\n", key, */
+    /* error_report("AMR protection: key=%d AMR=0x%" PRIx64 "", key, */
     /*         env->spr[SPR_AMR]); */
 
     /*
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2a1f9902c9..cbf5187ff8 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2600,7 +2600,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
     if (((env->spr[SPR_BOOKE_MAS0] & MAS0_ATSEL) == MAS0_ATSEL_LRAT) &&
         !msr_gs) {
         /* XXX we don't support direct LRAT setting yet */
-        fprintf(stderr, "cpu: don't support LRAT setting yet\n");
+        error_report("cpu: don't support LRAT setting yet");
         return;
     }
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c6399a3a0d..e3e839a75e 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -1778,7 +1778,7 @@ static void gen_spr_BookE(CPUPPCState *env, uint64_t ivor_mask)
     for (i = 0; i < 64; i++) {
         if (ivor_mask & (1ULL << i)) {
             if (ivor_sprn[i] == SPR_BOOKE_IVORxx) {
-                fprintf(stderr, "ERROR: IVOR %d SPR is not defined\n", i);
+                error_report("ERROR: IVOR %d SPR is not defined", i);
                 exit(1);
             }
             spr_register(env, ivor_sprn[i], ivor_names[i],
@@ -9254,13 +9254,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         case POWERPC_FLAG_VRE:
             break;
         default:
-            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n");
+            error_report("PowerPC MSR definition inconsistency "
+                         "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
-        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE");
         exit(1);
     }
     if (env->msr_mask & (1 << 17)) {
@@ -9269,13 +9269,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         case POWERPC_FLAG_CE:
             break;
         default:
-            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE\n");
+            error_report("PowerPC MSR definition inconsistency "
+                         "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE)) {
-        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE");
         exit(1);
     }
     if (env->msr_mask & (1 << 10)) {
@@ -9286,16 +9286,16 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         case POWERPC_FLAG_UBLE:
             break;
         default:
-            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_SE or POWERPC_FLAG_DWE or "
-                    "POWERPC_FLAG_UBLE\n");
+            error_report("PowerPC MSR definition inconsistency "
+                         "Should define POWERPC_FLAG_SE or POWERPC_FLAG_DWE or "
+                         "POWERPC_FLAG_UBLE");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_SE | POWERPC_FLAG_DWE |
                              POWERPC_FLAG_UBLE)) {
-        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_SE nor POWERPC_FLAG_DWE nor "
-                "POWERPC_FLAG_UBLE\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should not define POWERPC_FLAG_SE nor POWERPC_FLAG_DWE"
+                     " nor POWERPC_FLAG_UBLE");
             exit(1);
     }
     if (env->msr_mask & (1 << 9)) {
@@ -9304,13 +9304,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         case POWERPC_FLAG_DE:
             break;
         default:
-            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_BE or POWERPC_FLAG_DE\n");
+            error_report("PowerPC MSR definition inconsistency "
+                         "Should define POWERPC_FLAG_BE or POWERPC_FLAG_DE");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_BE | POWERPC_FLAG_DE)) {
-        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_BE nor POWERPC_FLAG_DE\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should not define POWERPC_FLAG_BE nor POWERPC_FLAG_DE");
         exit(1);
     }
     if (env->msr_mask & (1 << 2)) {
@@ -9319,18 +9319,19 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         case POWERPC_FLAG_PMM:
             break;
         default:
-            fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n");
+            error_report("PowerPC MSR definition inconsistency "
+                         "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
-        fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM");
         exit(1);
     }
     if ((env->flags & (POWERPC_FLAG_RTC_CLK | POWERPC_FLAG_BUS_CLK)) == 0) {
-        fprintf(stderr, "PowerPC flags inconsistency\n"
-                "Should define the time-base and decrementer clock source\n");
+        error_report("PowerPC MSR definition inconsistency "
+                     "Should define the time-base and decrementer clock"
+                     " source");
         exit(1);
     }
     /* Allocate TLBs buffer when needed */
@@ -10534,7 +10535,7 @@ static void ppc_cpu_reset(CPUState *s)
 #if !defined(TARGET_WORDS_BIGENDIAN)
     msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
     if (!((env->msr_mask >> MSR_LE) & 1)) {
-        fprintf(stderr, "Selected CPU does not support little-endian.\n");
+        error_report("Selected CPU does not support little-endian.");
         exit(1);
     }
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ebb75cafaa..6f7ebd1c98 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -967,13 +967,13 @@ static void inject_vcpu_irq_legacy(CPUState *cs, struct kvm_s390_irq *irq)
 
     r = s390_kvm_irq_to_interrupt(irq, &kvmint);
     if (r < 0) {
-        fprintf(stderr, "%s called with bogus interrupt\n", __func__);
+        error_report("%s called with bogus interrupt", __func__);
         exit(1);
     }
 
     r = kvm_vcpu_ioctl(cs, KVM_S390_INTERRUPT, &kvmint);
     if (r < 0) {
-        fprintf(stderr, "KVM failed to inject interrupt\n");
+        error_report("KVM failed to inject interrupt");
         exit(1);
     }
 }
@@ -1002,13 +1002,13 @@ static void __kvm_s390_floating_interrupt(struct kvm_s390_irq *irq)
 
     r = s390_kvm_irq_to_interrupt(irq, &kvmint);
     if (r < 0) {
-        fprintf(stderr, "%s called with bogus interrupt\n", __func__);
+        error_report("%s called with bogus interrupt", __func__);
         exit(1);
     }
 
     r = kvm_vm_ioctl(kvm_state, KVM_S390_INTERRUPT, &kvmint);
     if (r < 0) {
-        fprintf(stderr, "KVM failed to inject interrupt\n");
+        error_report("KVM failed to inject interrupt");
         exit(1);
     }
 }
@@ -1116,14 +1116,14 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
         break;
     case PRIV_B2_TSCH:
         /* We should only get tsch via KVM_EXIT_S390_TSCH. */
-        fprintf(stderr, "Spurious tsch intercept\n");
+        error_report("Spurious tsch intercept");
         break;
     case PRIV_B2_CHSC:
         ioinst_handle_chsc(cpu, run->s390_sieic.ipb);
         break;
     case PRIV_B2_TPI:
         /* This should have been handled by kvm already. */
-        fprintf(stderr, "Spurious tpi intercept\n");
+        error_report("Spurious tpi intercept");
         break;
     case PRIV_B2_SCHM:
         ioinst_handle_schm(cpu, env->regs[1], env->regs[2],
@@ -2050,15 +2050,15 @@ static int handle_intercept(S390CPU *cpu)
             }
             break;
         case ICPT_SOFT_INTERCEPT:
-            fprintf(stderr, "KVM unimplemented icpt SOFT\n");
+            error_report("KVM unimplemented icpt SOFT");
             exit(1);
             break;
         case ICPT_IO:
-            fprintf(stderr, "KVM unimplemented icpt IO\n");
+            error_report("KVM unimplemented icpt IO");
             exit(1);
             break;
         default:
-            fprintf(stderr, "Unknown intercept code: %d\n", icpt_code);
+            error_report("Unknown intercept code: %d", icpt_code);
             exit(1);
             break;
     }
@@ -2215,7 +2215,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = kvm_arch_handle_debug_exit(cpu);
             break;
         default:
-            fprintf(stderr, "Unknown KVM exit: %d\n", run->exit_reason);
+            error_report("Unknown KVM exit: %d", run->exit_reason);
             break;
     }
     qemu_mutex_unlock_iothread();
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 293fc8428a..395872af45 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -354,7 +354,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
 #endif
     default:
         /* unknown sigp */
-        fprintf(stderr, "XXX unknown sigp: 0x%" PRIx64 "\n", order_code);
+        error_report("XXX unknown sigp: 0x%" PRIx64 "", order_code);
         cc = SIGP_CC_NOT_OPERATIONAL;
     }
 
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 1bd7827ee8..5b8a3b0094 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -515,7 +515,7 @@ static void gen_test_cc(int cc, TCGLabel *label)
         tcg_gen_brcondi_i32(TCG_COND_LT, tmp, 0, label);
         break;
     default:
-        fprintf(stderr, "Bad condition code 0x%x\n", cc);
+        error_report("Bad condition code 0x%x", cc);
         abort();
     }
     dead_tmp(tmp);
-- 
2.11.0
