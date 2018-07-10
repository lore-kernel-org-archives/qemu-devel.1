Received: from eggs.gnu.org ([2001:4830:134:3::10]:41497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgW4-0004eb-Ox
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgW1-0008J0-K2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgW1-0008Ii-6n
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:28:25 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  9 Jul 2018 17:28:12 -0700
Message-Id: <d0ec2856f8c70e5d13707806249f92d718e7a83f.1531182400.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531182400.git.alistair.francis@wdc.com>
References: <cover.1531182400.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/6] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alistair23@gmail.com, mjc@sifive.com

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
