Received: from eggs.gnu.org ([209.51.188.92]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5H4-00036L-IH
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gz-0004Ps-N8
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gq-0004Kk-AU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id f188so4727051wmf.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:10 +0100
Message-Id: <1549390526-24246-61-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 60/76] hw/xtensa/Makefile.objs: Build xtensa_sim
 and xtensa_fpga conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

Add the new CONFIG_* values to default-config/xtensa*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20190202072456.6468-17-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/xtensa-softmmu.mak   | 3 +++
 default-configs/xtensaeb-softmmu.mak | 3 +++
 hw/xtensa/Makefile.objs              | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 9d8899c..baf90ca 100644
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
index 9d8899c..baf90ca 100644
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
index f30e4a7..fa86730 100644
--- a/hw/xtensa/Makefile.objs
+++ b/hw/xtensa/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y += mx_pic.o
 obj-y += pic_cpu.o
-obj-y += sim.o
 obj-y += xtensa_memory.o
-obj-y += xtfpga.o
+obj-$(CONFIG_XTENSA_SIM) += sim.o
+obj-$(CONFIG_XTENSA_FPGA) += xtfpga.o
-- 
1.8.3.1
