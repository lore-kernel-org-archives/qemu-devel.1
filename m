Received: from eggs.gnu.org ([2001:4830:134:3::10]:41696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWo-0005BW-Ft
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWl-00006q-BQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:29:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=722272e76=Alistair.Francis@wdc.com>)
	id 1fcgWk-00004u-UJ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:29:11 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Mon,  9 Jul 2018 17:28:58 -0700
Message-Id: <93d3ddab10fa45e0fc081b7008f634b635acb204.1531182400.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1531182400.git.alistair.francis@wdc.com>
References: <cover.1531182400.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 6/6] riscv64-softmmu.mak: Build Virtio Block
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
Cc: alistair.francis@wdc.com, alistair23@gmail.com, mjc@sifive.com

Add build time support for the VirtIO block device. This allows us to
attach a drive using the virtio-blk-device.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 default-configs/riscv64-softmmu.mak | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 35e74bebe9..8790f3b115 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -12,3 +12,5 @@ CONFIG_PCI_XILINX=y
 
 CONFIG_VGA=y
 CONFIG_VGA_PCI=y
+
+CONFIG_VIRTIO_BLK=y
-- 
2.17.1
