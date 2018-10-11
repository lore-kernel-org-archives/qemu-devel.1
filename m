Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcd-0006cf-4G
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcY-0006U9-4i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=815999a97=Alistair.Francis@wdc.com>)
	id 1gAhcX-0006TI-Lf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:31:46 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 11 Oct 2018 20:31:41 +0000
Message-ID: <20181011203115.18666-2-alistair.francis@wdc.com>
References: <20181011203115.18666-1-alistair.francis@wdc.com>
In-Reply-To: <20181011203115.18666-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 01/10] hw/riscv/virt: Increase the number of
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>

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
