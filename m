Received: from eggs.gnu.org ([2001:4830:134:3::10]:45355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgX-0003EF-QE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgW-0003Mm-TM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:49 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgW-0003Mc-LN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:48 -0500
Received: by mail-wj0-x244.google.com with SMTP id ey1so12923576wjd.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:48 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:09 +0100
Message-Id: <1484163327-111841-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/33] stubs: remove stubs/kvm.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
1.8.3.1
