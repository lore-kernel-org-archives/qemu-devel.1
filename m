Received: from eggs.gnu.org ([209.51.188.92]:57988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0007aT-Ai
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOk-0001oP-GR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOh-0001fT-Kz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id d15so6162883wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:37 +0100
Message-Id: <1548410831-19553-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 18/52] hw/riscv/Makefile.objs: Create CONFIG_*
 for riscv boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

Add the new configs to default-configs/riscv*-sofmmu.mak.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-15-yang.zhong@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/riscv32-softmmu.mak |  7 +++++++
 default-configs/riscv64-softmmu.mak |  7 +++++++
 hw/riscv/Makefile.objs              | 22 +++++++++++-----------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index fbfd1d4..6533716 100644
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
index fbfd1d4..6533716 100644
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
index 1dde01d..79bfb3a 100644
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
1.8.3.1
