Received: from eggs.gnu.org ([209.51.188.92]:46109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCv-0002Hz-7B
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCq-0004cm-Rj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCo-0004Om-0f
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:50 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w6so6634077wrs.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:48 +0100
Message-Id: <1551723614-1823-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/54] ssi: express dependencies with kconfig
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak        | 1 -
 default-configs/microblaze-softmmu.mak | 1 -
 hw/sd/Kconfig                          | 1 +
 hw/ssi/Kconfig                         | 4 ++++
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 40e1a1a..8bb4fd1 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -24,7 +24,6 @@ CONFIG_DDC=y
 CONFIG_SII9022=y
 CONFIG_ADS7846=y
 CONFIG_MAX111X=y
-CONFIG_SSI=y
 CONFIG_SSI_SD=y
 CONFIG_SSI_M25P80=y
 CONFIG_LAN9118=y
diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
index a4a6770..7140ef3 100644
--- a/default-configs/microblaze-softmmu.mak
+++ b/default-configs/microblaze-softmmu.mak
@@ -6,7 +6,6 @@ CONFIG_XILINX=y
 CONFIG_XILINX_AXI=y
 CONFIG_XILINX_SPI=y
 CONFIG_XILINX_ETHLITE=y
-CONFIG_SSI=y
 CONFIG_SSI_M25P80=y
 CONFIG_XLNX_ZYNQMP=y
 CONFIG_PETALOGIX_S3ADSP1800=y
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index c6c5dfb..8f12d9c 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -3,6 +3,7 @@ config PL181
 
 config SSI_SD
     bool
+    depends on SSI
 
 config SD
     bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 5a03110..9e54a0c 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -1,14 +1,18 @@
 config PL022
     bool
+    select SSI
 
 config SSI
     bool
 
 config XILINX_SPI
     bool
+    select SSI
 
 config XILINX_SPIPS
     bool
+    select SSI
 
 config STM32F2XX_SPI
     bool
+    select SSI
-- 
1.8.3.1
