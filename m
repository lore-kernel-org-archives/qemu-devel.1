Received: from eggs.gnu.org ([2001:4830:134:3::10]:38830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tM-0008E8-8x
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tI-0007gG-6R
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=8083a5a2a=Alistair.Francis@wdc.com>)
	id 1g89tE-0007bx-AM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 16:06:30 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 4 Oct 2018 20:06:18 +0000
Message-ID: <c65db3d0cc18c960f6490731e547785374974883.1538683492.git.alistair.francis@wdc.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1538683492.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 1/5] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "stephen@eideticom.com" <stephen@eideticom.com>, "palmer@sifive.com" <palmer@sifive.com>

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
2.17.1
