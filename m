Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRl1-0000fF-K3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRky-0004of-EO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRky-0004nh-2A
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:30:04 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:29:51 -0700
Message-Id: <855d87b3d326460305ca9e64417b7dc57e59130a.1529695276.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/5] hw/riscv/virt: Increase the number of
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
Cc: alistair.francis@wdc.com, alistair23@gmail.com, palmer@sifive.com, mjc@sifive.com

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
