Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsY-0000Ln-LB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsT-0000Wn-EK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=759fd99b3=Alistair.Francis@wdc.com>)
	id 1fqKsS-0000V1-Lh
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:12:01 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 16 Aug 2018 09:11:46 -0700
Message-Id: <f0001f055026f969beebce307d930553d6ab1ed6.1534435831.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1534435831.git.alistair.francis@wdc.com>
References: <cover.1534435831.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/6] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Increase the number of interrupts to match the HiFive Unleashed board.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 91163d6cbf..7cb2742070 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -45,7 +45,7 @@ enum {
     UART0_IRQ = 10,
     VIRTIO_IRQ = 1, /* 1 to 8 */
     VIRTIO_COUNT = 8,
-    VIRTIO_NDEV = 10
+    VIRTIO_NDEV = 0x35
 };
 
 enum {
-- 
2.17.1
