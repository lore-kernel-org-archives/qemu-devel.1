Received: from eggs.gnu.org ([2001:4830:134:3::10]:55965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckg-0002jM-Ez
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckf-0005G1-KA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckf-0004zB-5y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:45 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:20:01 +0800
Message-Id: <1498040401-16361-16-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 15/15] tcg: add the CONFIG_TCG into Makefiles
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

Add the CONFIG_TCG for frontend and backend's files in the related
Makefiles.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target           | 4 ++--
 accel/Makefile.objs       | 2 +-
 target/i386/Makefile.objs | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 0066579..8e185d4 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -90,8 +90,8 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
-obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-y += tcg/tcg-common.o tcg/tcg-runtime.o
+obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
+obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index cd5702f..10666ed 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
 obj-y += kvm/
-obj-y += tcg/
+obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 4fcb7f3..fee6c7e 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,6 +1,7 @@
-obj-y += translate.o helper.o cpu.o bpt_helper.o
-obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
-obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
+obj-y += helper.o cpu.o cc_helper.o bpt_helper.o
+obj-$(CONFIG_TCG) += translate.o
+obj-$(CONFIG_TCG) += excp_helper.o fpu_helper.o int_helper.o svm_helper.o
+obj-$(CONFIG_TCG) += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
-- 
1.9.1
