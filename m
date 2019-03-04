Received: from eggs.gnu.org ([209.51.188.92]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD1-0002Pn-H2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCz-0004wa-FE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCx-0004iM-Ci
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id g12so6640333wrm.5
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:02 +0100
Message-Id: <1551723614-1823-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 42/54] microblaze-softmmu.mak: express
 dependencies with Kconfig
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

%-softmmu.mak only keep boards and optional device
definitions in Kconfig mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/microblaze-softmmu.mak | 10 ++--------
 hw/microblaze/Kconfig                  | 12 ++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
index 7140ef3..db8c6e4 100644
--- a/default-configs/microblaze-softmmu.mak
+++ b/default-configs/microblaze-softmmu.mak
@@ -1,13 +1,7 @@
 # Default configuration for microblaze-softmmu
 
-CONFIG_PFLASH_CFI01=y
-CONFIG_SERIAL=y
-CONFIG_XILINX=y
-CONFIG_XILINX_AXI=y
-CONFIG_XILINX_SPI=y
-CONFIG_XILINX_ETHLITE=y
-CONFIG_SSI_M25P80=y
-CONFIG_XLNX_ZYNQMP=y
+# Boards:
+#
 CONFIG_PETALOGIX_S3ADSP1800=y
 CONFIG_PETALOGIX_ML605=y
 CONFIG_XLNX_ZYNQMP_PMU=y
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index 44683b2..c4dc120 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -1,8 +1,20 @@
 config PETALOGIX_S3ADSP1800
     bool
+    select PFLASH_CFI01
+    select XILINX
+    select XILINX_AXI
+    select XILINX_ETHLITE
 
 config PETALOGIX_ML605
     bool
+    select PFLASH_CFI01
+    select SERIAL
+    select SSI_M25P80
+    select XILINX
+    select XILINX_AXI
+    select XILINX_ETHLITE
+    select XILINX_SPI
 
 config XLNX_ZYNQMP_PMU
     bool
+    select XLNX_ZYNQMP
-- 
1.8.3.1
