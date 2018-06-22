Received: from eggs.gnu.org ([2001:4830:134:3::10]:44631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmY-0001mM-KS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmV-0005bG-Dx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=704af0c1d=Alistair.Francis@wdc.com>)
	id 1fWRmV-0005Zt-1m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:39 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 22 Jun 2018 12:31:27 -0700
Message-Id: <8a9c4a39a990991d375476924e882fd43f49616e.1529695276.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 5/5] riscv64-softmmu.mak: Build Virtio Block
 support
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

Add build time support for the VirtIO block device. This allows us to
attach a drive using the virtio-blk-device.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv64-softmmu.mak | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 73a421d3de..0be2cce269 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -10,3 +10,5 @@ CONFIG_PCI_XILINX=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
+
+CONFIG_VIRTIO_BLK=y
-- 
2.17.1
