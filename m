Received: from eggs.gnu.org ([2001:4830:134:3::10]:34878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcKj-0000is-6m
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8344f8b50=Alistair.Francis@wdc.com>)
	id 1gHcKf-0002Yp-VN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:17:57 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Oct 2018 22:17:50 +0000
Message-ID: <eec5d3aa1a28b7982e70610b0036862b788cabe2.1540937826.git.alistair.francis@wdc.com>
References: <cover.1540937826.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1540937826.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 1/5] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

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
     UART0_IRQ =3D 10,
     VIRTIO_IRQ =3D 1, /* 1 to 8 */
     VIRTIO_COUNT =3D 8,
-    VIRTIO_NDEV =3D 10
+    VIRTIO_NDEV =3D 0x35
 };
=20
 enum {
--=20
2.19.1
