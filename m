Received: from eggs.gnu.org ([2001:4830:134:3::10]:59726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORs-0001Nl-47
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORr-0008SE-78
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORq-0008Ro-VU
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:35 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:09 -0200
Message-Id: <1482255793-19057-4-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 3/7] kvm: Move some kvm-stub.c code to stubs/kvm.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>

Move the kvm-stub.c code that doesn't depend on cpu.h or CONFIG_*
defines to stubs/kvm.c.

Notes about copyright, licensing, and authorship:

* There was no copyright not on the original stubs/kvm.c file.
* As include/sysemu/kvm.h and kvm-all.c are licensed as
  GPLv2+, I am assuming stubs/kvm.c file is also licensed as
  GPLv2+.
* I have copied the copyright info from kvm-stub.c and added the
  original author of stubs/kvm.c (Christoffer Dall) to the author
  list.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 kvm-stub.c  | 51 ------------------------------------------------
 stubs/kvm.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/kvm-stub.c b/kvm-stub.c
index b1b6b96..7ba697b 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -19,61 +19,10 @@
 #include "hw/pci/msi.h"
 #endif
 
-KVMState *kvm_state;
-bool kvm_kernel_irqchip;
-bool kvm_async_interrupts_allowed;
-bool kvm_eventfds_allowed;
-bool kvm_irqfds_allowed;
-bool kvm_resamplefds_allowed;
-bool kvm_msi_via_irqfd_allowed;
-bool kvm_gsi_routing_allowed;
-bool kvm_gsi_direct_mapping;
-bool kvm_allowed;
-bool kvm_readonly_mem_allowed;
-bool kvm_ioeventfd_any_length_allowed;
-bool kvm_msi_use_devid;
-
-int kvm_destroy_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-int kvm_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
 void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
-void kvm_cpu_synchronize_post_reset(CPUState *cpu)
-{
-}
-
-void kvm_cpu_synchronize_post_init(CPUState *cpu)
-{
-}
-
-int kvm_cpu_exec(CPUState *cpu)
-{
-    abort();
-}
-
-int kvm_has_sync_mmu(void)
-{
-    return 0;
-}
-
-int kvm_has_many_ioeventfds(void)
-{
-    return 0;
-}
-
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 {
     return -ENOSYS;
diff --git a/stubs/kvm.c b/stubs/kvm.c
index ddd6204..9d491c1 100644
--- a/stubs/kvm.c
+++ b/stubs/kvm.c
@@ -1,7 +1,72 @@
+/*
+ * QEMU KVM stub
+ *
+ * Copyright Red Hat, Inc. 2010
+ *
+ * Authors:
+ *  Christoffer Dall  <christoffer.dall@linaro.org>
+ *  Paolo Bonzini     <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "sysemu/kvm.h"
 
+KVMState *kvm_state;
+bool kvm_kernel_irqchip;
+bool kvm_async_interrupts_allowed;
+bool kvm_eventfds_allowed;
+bool kvm_irqfds_allowed;
+bool kvm_resamplefds_allowed;
+bool kvm_msi_via_irqfd_allowed;
+bool kvm_gsi_routing_allowed;
+bool kvm_gsi_direct_mapping;
+bool kvm_allowed;
+bool kvm_readonly_mem_allowed;
+bool kvm_ioeventfd_any_length_allowed;
+bool kvm_msi_use_devid;
+
+int kvm_destroy_vcpu(CPUState *cpu)
+{
+    return -ENOSYS;
+}
+
+int kvm_init_vcpu(CPUState *cpu)
+{
+    return -ENOSYS;
+}
+
+void kvm_cpu_synchronize_state(CPUState *cpu)
+{
+}
+
+void kvm_cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+
+void kvm_cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+
+int kvm_cpu_exec(CPUState *cpu)
+{
+    abort();
+}
+
+int kvm_has_sync_mmu(void)
+{
+    return 0;
+}
+
+int kvm_has_many_ioeventfds(void)
+{
+    return 0;
+}
+
 int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
 {
     return 0;
-- 
2.7.4
