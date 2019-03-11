Received: from eggs.gnu.org ([209.51.188.92]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.abdurachmanov@gmail.com>) id 1h3Gzo-0002Ua-1R
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.abdurachmanov@gmail.com>) id 1h3Gzm-0004Oc-Hz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:13:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.abdurachmanov@gmail.com>)
	id 1h3Gzk-00046c-VE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:13:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id o10so13416823wmc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 02:13:01 -0700 (PDT)
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
Date: Mon, 11 Mar 2019 10:12:56 +0100
Message-Id: <20190311091256.18385-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] riscv/Kconfig: enable PCI_DEVICES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alistair.francis@wdc.com, palmer@sifive.com
Cc: David Abdurachmanov <david.abdurachmanov@gmail.com>

Re-enable PCI_DEVICES for RISC-V.
The patch is based on other <arch>/Kconfig.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: 82a230d5a303 ("riscv-softmmu.mak: replace CONFIG_* with Kconfig "select" directives")
---
 hw/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e0ee3043a6..8c7fc1f31d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -26,6 +26,9 @@ config SPIKE
 
 config RISCV_VIRT
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select PCI
     select HART
     select SERIAL
     select VIRTIO_MMIO
-- 
2.20.1
