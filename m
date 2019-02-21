Received: from eggs.gnu.org ([209.51.188.92]:58255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcU3-0005C2-LU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcU2-0002dw-SH
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:45:03 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 21 Feb 2019 00:44:58 +0000
Message-ID: <71002f073a6e9e611658a19bfe14e00de9790e3b.1550709660.git.alistair.francis@wdc.com>
References: <cover.1550709660.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1550709660.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 11/11] riscv: sifive_u: Allow up to 4 CPUs
 to be created
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7bc25820fe..3199238ba0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -398,7 +398,10 @@ static void riscv_sifive_u_machine_init(MachineClass *=
mc)
 {
     mc->desc =3D "RISC-V Board compatible with SiFive U SDK";
     mc->init =3D riscv_sifive_u_init;
-    mc->max_cpus =3D 1;
+    /* The real hardware has 5 CPUs, but one of them is a small embedded p=
ower
+     * management CPU.
+     */
+    mc->max_cpus =3D 4;
 }
=20
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
--=20
2.20.1
