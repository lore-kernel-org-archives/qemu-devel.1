Received: from eggs.gnu.org ([209.51.188.92]:60554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODH-0006l3-WD
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODH-0002ot-9b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODH-0002oQ-1k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id t6so5931268wrw.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:07 +0100
Message-Id: <1552323335-46779-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 03/31] riscv/Kconfig: enable PCI_DEVICES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Abdurachmanov <david.abdurachmanov@gmail.com>

From: David Abdurachmanov <david.abdurachmanov@gmail.com>

Re-enable PCI_DEVICES for RISC-V.
The patch is based on other <arch>/Kconfig.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Fixes: 82a230d5a303 ("riscv-softmmu.mak: replace CONFIG_* with Kconfig "select" directives")
Message-Id: <20190311091256.18385-1-david.abdurachmanov@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e0ee304..8c7fc1f 100644
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
1.8.3.1
