Received: from eggs.gnu.org ([209.51.188.92]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzn-00053Y-K9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsGzm-00068F-75
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 19:59:51 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 00:59:47 +0000
Message-ID: <f3876e4e18060732817a2f657a8bf4e0af75d4d5.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 03/11] RISC-V: Replace __builtin_popcount
 with ctpop8 in PLIC
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

From: Michael Clark <mjc@sifive.com>

The mode variable only uses the lower 4-bits (M,H,S,U) so
replace the GCC specific __builtin_popcount with ctpop8.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index d12ec3fc9a..b859f919a7 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -383,7 +383,7 @@ static void parse_hart_config(SiFivePLICState *plic)
     p =3D plic->hart_config;
     while ((c =3D *p++)) {
         if (c =3D=3D ',') {
-            addrid +=3D __builtin_popcount(modes);
+            addrid +=3D ctpop8(modes);
             modes =3D 0;
             hartid++;
         } else {
@@ -397,7 +397,7 @@ static void parse_hart_config(SiFivePLICState *plic)
         }
     }
     if (modes) {
-        addrid +=3D __builtin_popcount(modes);
+        addrid +=3D ctpop8(modes);
     }
     hartid++;
=20
--=20
2.20.1
