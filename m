Received: from eggs.gnu.org ([2001:4830:134:3::10]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckW-0002bH-JH
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckS-0005AH-L9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckS-0004zB-DV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:32 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:55 +0800
Message-Id: <1498040401-16361-10-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 09/15] tcg: add the tcg-stub.c file into
 accel/stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

If tcg is disabled, the functions in tcg-stub.c file will be called.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/stubs/Makefile.objs |   1 +
 accel/stubs/tcg-stub.c    | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 accel/stubs/tcg-stub.c

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index bd5794f..fdfbf73 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1 +1,2 @@
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
new file mode 100644
index 0000000..12c41dd
--- /dev/null
+++ b/accel/stubs/tcg-stub.c
@@ -0,0 +1,103 @@
+/*
+ * QEMU TCG accelerator stub
+ *
+ * Copyright Red Hat, Inc. 2013
+ *
+ * Author: Paolo Bonzini     <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "exec/cpu-common.h"
+#include "exec/exec-all.h"
+#include "translate-all.h"
+#include "exec/cpu-all.h"
+
+void tb_flush(CPUState *cpu)
+{
+}
+
+void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len)
+{
+}
+
+void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t end)
+{
+}
+
+void tb_check_watchpoint(CPUState *cpu)
+{
+}
+
+TranslationBlock *tb_gen_code(CPUState *cpu,
+                              target_ulong pc, target_ulong cs_base,
+                              uint32_t flags, int cflags)
+{
+    return NULL;
+}
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+{
+}
+
+void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
+{
+}
+
+bool cpu_restore_state(CPUState *cpu, uintptr_t searched_pc)
+{
+    return false;
+}
+
+void update_fp_status(CPUX86State *env)
+{
+}
+
+void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
+{
+}
+
+void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
+{
+}
+
+void cpu_loop_exit(CPUState *cpu)
+{
+    abort();
+}
+
+void cpu_loop_exit_noexc(CPUState *cpu)
+{
+    abort();
+}
+
+void raise_exception(CPUX86State *env, int exception_index)
+{
+    abort();
+}
+
+void raise_exception_err_ra(CPUX86State *env, int exception_index,
+                            int error_code, uintptr_t retaddr)
+{
+    abort();
+}
+
+void x86_cpu_do_interrupt(CPUState *cs)
+{
+}
+
+bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    return false;
+}
+
+int cpu_exec(CPUState *cpu)
+{
+    abort();
+}
-- 
1.9.1
