Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNH3-0001Jq-AS
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNGx-0003zM-Qu
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:41 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNGx-0003z4-Md
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:35 -0500
Received: by mail-qt1-x82f.google.com with SMTP id v11so6210132qtc.2
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:35 -0800 (PST)
Date: Fri, 21 Dec 2018 08:02:54 -0800
Message-Id: <20181221160307.14819-2-palmer@sifive.com>
In-Reply-To: <20181221160307.14819-1-palmer@sifive.com>
References: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 01/14] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Increase the number of interrupts to match the HiFive Unleashed board.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 91163d6cbfe8..2b2e6dd4ea6b 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -45,7 +45,7 @@ enum {
     UART0_IRQ = 10,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
-    VIRTIO_NDEV = 10
+    VIRTIO_NDEV = 0x35 /* Arbitrary maximum number of interrupts */
 };
 
 enum {
-- 
2.18.1
