Received: from eggs.gnu.org ([209.51.188.92]:49572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH07-0005H9-9z
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9369ea4ad=Alistair.Francis@wdc.com>)
	id 1gsH06-0006Ru-9B
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 20:00:11 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 9 Feb 2019 01:00:05 +0000
Message-ID: <875b00b989a60fabb3a03353253ce8d939b5ce28.1549673900.git.alistair.francis@wdc.com>
References: <cover.1549673900.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1549673900.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 05/11] RISC-V: Remove unnecessary
 disassembler constraints
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

Remove machine generated constraints that are not
referenced by the pseudo-instruction constraints.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 138 --------------------------------------------------
 1 file changed, 138 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7fd1019623..27546dd790 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -87,33 +87,10 @@ typedef enum {
=20
 typedef enum {
     rvc_end,
-    rvc_simm_6,
-    rvc_imm_6,
-    rvc_imm_7,
-    rvc_imm_8,
-    rvc_imm_9,
-    rvc_imm_10,
-    rvc_imm_12,
-    rvc_imm_18,
-    rvc_imm_nz,
-    rvc_imm_x2,
-    rvc_imm_x4,
-    rvc_imm_x8,
-    rvc_imm_x16,
-    rvc_rd_b3,
-    rvc_rs1_b3,
-    rvc_rs2_b3,
-    rvc_rd_eq_rs1,
     rvc_rd_eq_ra,
-    rvc_rd_eq_sp,
     rvc_rd_eq_x0,
-    rvc_rs1_eq_sp,
     rvc_rs1_eq_x0,
     rvc_rs2_eq_x0,
-    rvc_rd_ne_x0_x2,
-    rvc_rd_ne_x0,
-    rvc_rs1_ne_x0,
-    rvc_rs2_ne_x0,
     rvc_rs2_eq_rs1,
     rvc_rs1_eq_ra,
     rvc_imm_eq_zero,
@@ -2522,111 +2499,16 @@ static bool check_constraints(rv_decode *dec, cons=
t rvc_constraint *c)
     uint8_t rd =3D dec->rd, rs1 =3D dec->rs1, rs2 =3D dec->rs2;
     while (*c !=3D rvc_end) {
         switch (*c) {
-        case rvc_simm_6:
-            if (!(imm >=3D -32 && imm < 32)) {
-                return false;
-            }
-            break;
-        case rvc_imm_6:
-            if (!(imm <=3D 63)) {
-                return false;
-            }
-            break;
-        case rvc_imm_7:
-            if (!(imm <=3D 127)) {
-                return false;
-            }
-            break;
-        case rvc_imm_8:
-            if (!(imm <=3D 255)) {
-                return false;
-            }
-            break;
-        case rvc_imm_9:
-            if (!(imm <=3D 511)) {
-                return false;
-            }
-            break;
-        case rvc_imm_10:
-            if (!(imm <=3D 1023)) {
-                return false;
-            }
-            break;
-        case rvc_imm_12:
-            if (!(imm <=3D 4095)) {
-                return false;
-            }
-            break;
-        case rvc_imm_18:
-            if (!(imm <=3D 262143)) {
-                return false;
-            }
-            break;
-        case rvc_imm_nz:
-            if (!(imm !=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_imm_x2:
-            if (!((imm & 0b1) =3D=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_imm_x4:
-            if (!((imm & 0b11) =3D=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_imm_x8:
-            if (!((imm & 0b111) =3D=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_imm_x16:
-            if (!((imm & 0b1111) =3D=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_rd_b3:
-            if (!(rd  >=3D 8 && rd  <=3D 15)) {
-                return false;
-            }
-            break;
-        case rvc_rs1_b3:
-            if (!(rs1 >=3D 8 && rs1 <=3D 15)) {
-                return false;
-            }
-            break;
-        case rvc_rs2_b3:
-            if (!(rs2 >=3D 8 && rs2 <=3D 15)) {
-                return false;
-            }
-            break;
-        case rvc_rd_eq_rs1:
-            if (!(rd =3D=3D rs1)) {
-                return false;
-            }
-            break;
         case rvc_rd_eq_ra:
             if (!(rd =3D=3D 1)) {
                 return false;
             }
             break;
-        case rvc_rd_eq_sp:
-            if (!(rd =3D=3D 2)) {
-                return false;
-            }
-            break;
         case rvc_rd_eq_x0:
             if (!(rd =3D=3D 0)) {
                 return false;
             }
             break;
-        case rvc_rs1_eq_sp:
-            if (!(rs1 =3D=3D 2)) {
-                return false;
-            }
-            break;
         case rvc_rs1_eq_x0:
             if (!(rs1 =3D=3D 0)) {
                 return false;
@@ -2637,26 +2519,6 @@ static bool check_constraints(rv_decode *dec, const =
rvc_constraint *c)
                 return false;
             }
             break;
-        case rvc_rd_ne_x0_x2:
-            if (!(rd !=3D 0 && rd !=3D 2)) {
-                return false;
-            }
-            break;
-        case rvc_rd_ne_x0:
-            if (!(rd !=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_rs1_ne_x0:
-            if (!(rs1 !=3D 0)) {
-                return false;
-            }
-            break;
-        case rvc_rs2_ne_x0:
-            if (!(rs2 !=3D 0)) {
-                return false;
-            }
-            break;
         case rvc_rs2_eq_rs1:
             if (!(rs2 =3D=3D rs1)) {
                 return false;
--=20
2.20.1
