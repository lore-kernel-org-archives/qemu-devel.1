Received: from eggs.gnu.org ([2001:4830:134:3::10]:49313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXASK-0002gh-FJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8779827ad=Alistair.Francis@wdc.com>)
	id 1gXASG-0003Ht-I1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:46:04 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 12 Dec 2018 19:45:57 +0000
Message-ID: <9f20f4297e7da092a5a436ef83c5ac1ae5fc273e.1544643238.git.alistair.francis@wdc.com>
References: <cover.1544643238.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544643238.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 20/23] riscv: tcg-target: Add the target
 init code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 5483d1d350..b6aafd121a 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1852,6 +1852,37 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
 }
=20
+static void tcg_target_init(TCGContext *s)
+{
+    tcg_target_available_regs[TCG_TYPE_I32] =3D 0xffffffff;
+    if (TCG_TARGET_REG_BITS =3D=3D 64) {
+        tcg_target_available_regs[TCG_TYPE_I64] =3D 0xffffffff;
+    }
+
+    tcg_target_call_clobber_regs =3D -1u;
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S1);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S2);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S3);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S4);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S5);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S6);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S7);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S10);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S11);
+
+    s->reserved_regs =3D 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP2);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
+}
+
 typedef struct {
     DebugFrameHeader h;
     uint8_t fde_def_cfa[4];
--=20
2.19.1
