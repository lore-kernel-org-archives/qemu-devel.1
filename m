Received: from eggs.gnu.org ([209.51.188.92]:35847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qt-0006YR-WD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qn-0002u9-Jr
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:60109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qn-0002ib-A7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:29 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:23 +0800
Message-Id: <20190131073234.18037-17-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 16/27] hw/xtensa/Makefile.objs: Build
 xtensa_sim and xtensa_fpga conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Add the new CONFIG_* values to default-config/xtensa*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 default-configs/xtensa-softmmu.mak   | 3 +++
 default-configs/xtensaeb-softmmu.mak | 3 +++
 hw/xtensa/Makefile.objs              | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 9d8899cde7..baf90ca162 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -3,3 +3,6 @@
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
 CONFIG_PFLASH_CFI01=y
+
+CONFIG_XTENSA_SIM=y
+CONFIG_XTENSA_FPGA=y
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/xtensaeb-softmmu.mak
index 9d8899cde7..baf90ca162 100644
--- a/default-configs/xtensaeb-softmmu.mak
+++ b/default-configs/xtensaeb-softmmu.mak
@@ -3,3 +3,6 @@
 CONFIG_SERIAL=y
 CONFIG_OPENCORES_ETH=y
 CONFIG_PFLASH_CFI01=y
+
+CONFIG_XTENSA_SIM=y
+CONFIG_XTENSA_FPGA=y
diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
index cb4998d2bf..62e244fa53 100644
--- a/hw/xtensa/Makefile.objs
+++ b/hw/xtensa/Makefile.objs
@@ -1,4 +1,4 @@
 obj-y += pic_cpu.o
-obj-y += sim.o
 obj-y += xtensa_memory.o
-obj-y += xtfpga.o
+obj-$(CONFIG_XTENSA_SIM) += sim.o
+obj-$(CONFIG_XTENSA_FPGA) += xtfpga.o
-- 
2.17.1
