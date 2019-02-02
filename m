Received: from eggs.gnu.org ([209.51.188.92]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppge-0001JW-H6
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppgd-0003Jh-9Y
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:26:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:56076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppgc-0002hI-S6
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:59 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:47 +0800
Message-Id: <20190202072456.6468-19-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 18/27] hw/riscv/Makefile.objs: Create
 CONFIG_* for riscv boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

Add the new configs to default-configs/riscv*-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/riscv32-softmmu.mak |  7 +++++++
 default-configs/riscv64-softmmu.mak |  7 +++++++
 hw/riscv/Makefile.objs              | 22 +++++++++++-----------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index fbfd1d4e4b..65337166e1 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -12,3 +12,10 @@ CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
+
+CONFIG_SPIKE=y
+CONFIG_HART=y
+CONFIG_SIFIVE_E=y
+CONFIG_SIFIVE=y
+CONFIG_SIFIVE_U=y
+CONFIG_RISCV_VIRT=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index fbfd1d4e4b..65337166e1 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -12,3 +12,10 @@ CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
+
+CONFIG_SPIKE=y
+CONFIG_HART=y
+CONFIG_SIFIVE_E=y
+CONFIG_SIFIVE=y
+CONFIG_SIFIVE_U=y
+CONFIG_RISCV_VIRT=y
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index 1dde01d39d..79bfb3abf9 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,11 +1,11 @@
-obj-y += riscv_htif.o
-obj-y += riscv_hart.o
-obj-y += sifive_e.o
-obj-y += sifive_clint.o
-obj-y += sifive_prci.o
-obj-y += sifive_plic.o
-obj-y += sifive_test.o
-obj-y += sifive_u.o
-obj-y += sifive_uart.o
-obj-y += spike.o
-obj-y += virt.o
+obj-$(CONFIG_SPIKE) += riscv_htif.o
+obj-$(CONFIG_HART) += riscv_hart.o
+obj-$(CONFIG_SIFIVE_E) += sifive_e.o
+obj-$(CONFIG_SIFIVE) += sifive_clint.o
+obj-$(CONFIG_SIFIVE) += sifive_prci.o
+obj-$(CONFIG_SIFIVE) += sifive_plic.o
+obj-$(CONFIG_SIFIVE) += sifive_test.o
+obj-$(CONFIG_SIFIVE_U) += sifive_u.o
+obj-$(CONFIG_SIFIVE) += sifive_uart.o
+obj-$(CONFIG_SPIKE) += spike.o
+obj-$(CONFIG_RISCV_VIRT) += virt.o
-- 
2.17.1
