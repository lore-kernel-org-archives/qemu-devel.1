Received: from eggs.gnu.org ([2001:4830:134:3::10]:36115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRka0-0003Py-HU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkZx-0003nq-BK
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:07:36 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:07:30 +0000
Message-ID: <373429c7267117de35a56c6ec16405f5097b40c8.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 06/24] riscv: Add the tcg target registers
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
 tcg/riscv/tcg-target.inc.c | 116 +++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 tcg/riscv/tcg-target.inc.c

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
new file mode 100644
index 0000000000..a4a1579440
--- /dev/null
+++ b/tcg/riscv/tcg-target.inc.c
@@ -0,0 +1,116 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2018 SiFive, Inc
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ * Copyright (c) 2008 Fabrice Bellard
+ *
+ * Based on i386/tcg-target.c and mips/tcg-target.c
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifdef CONFIG_DEBUG_TCG
+static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
+    "zero",
+    "ra",
+    "sp",
+    "gp",
+    "tp",
+    "t0",
+    "t1",
+    "t2",
+    "s0",
+    "s1",
+    "a0",
+    "a1",
+    "a2",
+    "a3",
+    "a4",
+    "a5",
+    "a6",
+    "a7",
+    "s2",
+    "s3",
+    "s4",
+    "s5",
+    "s6",
+    "s7",
+    "s8",
+    "s9",
+    "s10",
+    "s11",
+    "t3",
+    "t4",
+    "t5",
+    "t6"
+};
+#endif
+
+static const int tcg_target_reg_alloc_order[] =3D {
+    /* Call saved registers */
+    /* TCG_REG_S0 reservered for TCG_AREG0 */
+    TCG_REG_S1,
+    TCG_REG_S2,
+    TCG_REG_S3,
+    TCG_REG_S4,
+    TCG_REG_S5,
+    TCG_REG_S6,
+    TCG_REG_S7,
+    TCG_REG_S8,
+    TCG_REG_S9,
+    TCG_REG_S10,
+    TCG_REG_S11,
+
+    /* Call clobbered registers */
+    TCG_REG_T0,
+    TCG_REG_T1,
+    TCG_REG_T2,
+    TCG_REG_T3,
+    TCG_REG_T4,
+    TCG_REG_T5,
+    TCG_REG_T6,
+
+    /* Argument registers */
+    TCG_REG_A0,
+    TCG_REG_A1,
+    TCG_REG_A2,
+    TCG_REG_A3,
+    TCG_REG_A4,
+    TCG_REG_A5,
+    TCG_REG_A6,
+    TCG_REG_A7,
+};
+
+static const int tcg_target_call_iarg_regs[] =3D {
+    TCG_REG_A0,
+    TCG_REG_A1,
+    TCG_REG_A2,
+    TCG_REG_A3,
+    TCG_REG_A4,
+    TCG_REG_A5,
+    TCG_REG_A6,
+    TCG_REG_A7,
+};
+
+static const int tcg_target_call_oarg_regs[] =3D {
+    TCG_REG_A0,
+    TCG_REG_A1,
+};
--=20
2.19.1
