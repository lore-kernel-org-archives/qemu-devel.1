Received: from eggs.gnu.org ([2001:4830:134:3::10]:54627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8n-0002wQ-1E
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dFx8m-00038l-1n
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:28402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dFx8l-00036p-PV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:29:55 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 31 May 2017 14:29:04 +0800
Message-Id: <1496212144-14947-7-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 6/6] tcg: change tcg related file's compile
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

tcg: move tcg related compile definitions form Makefile.target
to tcg/Makefile.objs

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target   | 7 +------
 tcg/Makefile.objs | 2 ++
 2 files changed, 3 insertions(+), 6 deletions(-)
 create mode 100644 tcg/Makefile.objs

diff --git a/Makefile.target b/Makefile.target
index 8561132..956aeff 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -89,17 +89,12 @@ all: $(PROGS) stap
 #########################################################
 # cpu emulator library
 obj-y = exec.o cpu-exec.o
-obj-y += tcg/translate-all.o
-obj-y += tcg/translate-common.o
 obj-y += cpu-exec-common.o
-obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
-obj-y += tcg/tcg-common.o
+obj-y += tcg/
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg/tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/tcg/Makefile.objs b/tcg/Makefile.objs
new file mode 100644
index 0000000..f4dcc3b
--- /dev/null
+++ b/tcg/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y += translate-all.o translate-common.o tcg.o tcg-op.o optimize.o tcg-common.o tcg-runtime.o
+obj-$(CONFIG_TCG_INTERPRETER) += tci.o
-- 
1.9.1
