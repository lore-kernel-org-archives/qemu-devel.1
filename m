Received: from eggs.gnu.org ([2001:4830:134:3::10]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXBaK-0004OW-MK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXBaG-0003hE-Pi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:58:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXBaD-0003cg-HJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:58:19 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 12 Dec 2018 20:58:11 +0000
Message-ID: <7dfbddf7014a595150aa79011ddb342c3cc17ec3.1544648105.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/1] tcg: mips: Improve the add2/sub2
 command to use TCG_TARGET_REG_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "smarkovic@wavecomp.com" <smarkovic@wavecomp.com>, "rth@twiddle.net" <rth@twiddle.net>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Instead of hard coding 31 for the shift right use
TCG_TARGET_REG_BITS - 1.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index cff525373b..aa7cdabf23 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -796,7 +796,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGReg rl, T=
CGReg rh, TCGReg al,
             tcg_out_opc_imm(s, OPC_ADDIU, rl, al, bl);
             tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, rl, bl);
         } else if (rl =3D=3D al && rl =3D=3D bl) {
-            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, 31);
+            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, TCG_TARGET_REG_BITS -=
 1);
             tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
         } else {
             tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
--=20
2.19.1
