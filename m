Received: from eggs.gnu.org ([2001:4830:134:3::10]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5mF-0007LE-6p
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5mE-0003dE-FA
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5mE-0003cW-91
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:30 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6447A63E03
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:59:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:59:15 +0100
Message-Id: <20161222155915.7232-12-pbonzini@redhat.com>
In-Reply-To: <20161222155915.7232-1-pbonzini@redhat.com>
References: <20161222155915.7232-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] stubs: remove stubs/kvm.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

This has a single function, just move it to the other target/*/kvm.c files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/Makefile.objs | 1 -
 stubs/kvm.c         | 8 --------
 target/mips/kvm.c   | 5 +++++
 target/ppc/kvm.c    | 5 +++++
 target/s390x/kvm.c  | 5 +++++
 5 files changed, 15 insertions(+), 9 deletions(-)
 delete mode 100644 stubs/kvm.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index a7d3b72..a187295 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -31,7 +31,6 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += kvm.o
 stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
diff --git a/stubs/kvm.c b/stubs/kvm.c
deleted file mode 100644
index ddd6204..0000000
--- a/stubs/kvm.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "sysemu/kvm.h"
-
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
-{
-    return 0;
-}
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index dcf5fbb..998c341 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -55,6 +55,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
+int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9c4834c..6c53a6d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -145,6 +145,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
+int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+{
+    return 0;
+}
+
 static int kvm_arch_sync_sregs(PowerPCCPU *cpu)
 {
     CPUPPCState *cenv = &cpu->env;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97afe02..e938954 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -294,6 +294,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
+int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+{
+    return 0;
+}
+
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 {
     return cpu->cpu_index;
-- 
2.9.3
