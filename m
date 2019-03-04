Received: from eggs.gnu.org ([209.51.188.92]:45619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCL-0001kX-Fe
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCK-0003cy-Sp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCK-0003bn-Lc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:20 -0500
Received: by mail-wr1-x429.google.com with SMTP id q1so6645667wrp.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:23 +0100
Message-Id: <1551723614-1823-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/54] xtensa: rename CONFIG_XTENSA_FPGA to
 CONFIG_XTENSA_XTFPGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

Match the symbol name that is used e.g. in Linux (drivers/spi/Kconfig).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/xtensa-softmmu.mak   | 2 +-
 default-configs/xtensaeb-softmmu.mak | 2 +-
 hw/xtensa/Makefile.objs              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index baf90ca..7aa7fa6 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -5,4 +5,4 @@ CONFIG_OPENCORES_ETH=y
 CONFIG_PFLASH_CFI01=y
 
 CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_FPGA=y
+CONFIG_XTENSA_XTFPGA=y
diff --git a/default-configs/xtensaeb-softmmu.mak b/default-configs/xtensaeb-softmmu.mak
index baf90ca..7aa7fa6 100644
--- a/default-configs/xtensaeb-softmmu.mak
+++ b/default-configs/xtensaeb-softmmu.mak
@@ -5,4 +5,4 @@ CONFIG_OPENCORES_ETH=y
 CONFIG_PFLASH_CFI01=y
 
 CONFIG_XTENSA_SIM=y
-CONFIG_XTENSA_FPGA=y
+CONFIG_XTENSA_XTFPGA=y
diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
index fa86730..0bbfccd 100644
--- a/hw/xtensa/Makefile.objs
+++ b/hw/xtensa/Makefile.objs
@@ -2,4 +2,4 @@ obj-y += mx_pic.o
 obj-y += pic_cpu.o
 obj-y += xtensa_memory.o
 obj-$(CONFIG_XTENSA_SIM) += sim.o
-obj-$(CONFIG_XTENSA_FPGA) += xtfpga.o
+obj-$(CONFIG_XTENSA_XTFPGA) += xtfpga.o
-- 
1.8.3.1
