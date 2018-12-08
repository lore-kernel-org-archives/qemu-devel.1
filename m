Received: from eggs.gnu.org ([2001:4830:134:3::10]:39212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQlH-0007nj-HZ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQlD-0000M1-JZ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:46:27 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:46:20 +0000
Message-ID: <2fa0bfa036354699eb80cb431fc04e44b699f476.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 01/24] elf.h: Add the RISCV ELF magic numbers
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
 include/elf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index c151164b63..0ac7911b7b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1338,6 +1338,61 @@ typedef struct {
 #define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym + add), data8 LSB */
 #define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
=20
+/* RISC-V relocations.  */
+#define R_RISCV_NONE          0
+#define R_RISCV_32            1
+#define R_RISCV_64            2
+#define R_RISCV_RELATIVE      3
+#define R_RISCV_COPY          4
+#define R_RISCV_JUMP_SLOT     5
+#define R_RISCV_TLS_DTPMOD32  6
+#define R_RISCV_TLS_DTPMOD64  7
+#define R_RISCV_TLS_DTPREL32  8
+#define R_RISCV_TLS_DTPREL64  9
+#define R_RISCV_TLS_TPREL32   10
+#define R_RISCV_TLS_TPREL64   11
+#define R_RISCV_BRANCH        16
+#define R_RISCV_JAL           17
+#define R_RISCV_CALL          18
+#define R_RISCV_CALL_PLT      19
+#define R_RISCV_GOT_HI20      20
+#define R_RISCV_TLS_GOT_HI20  21
+#define R_RISCV_TLS_GD_HI20   22
+#define R_RISCV_PCREL_HI20    23
+#define R_RISCV_PCREL_LO12_I  24
+#define R_RISCV_PCREL_LO12_S  25
+#define R_RISCV_HI20          26
+#define R_RISCV_LO12_I        27
+#define R_RISCV_LO12_S        28
+#define R_RISCV_TPREL_HI20    29
+#define R_RISCV_TPREL_LO12_I  30
+#define R_RISCV_TPREL_LO12_S  31
+#define R_RISCV_TPREL_ADD     32
+#define R_RISCV_ADD8          33
+#define R_RISCV_ADD16         34
+#define R_RISCV_ADD32         35
+#define R_RISCV_ADD64         36
+#define R_RISCV_SUB8          37
+#define R_RISCV_SUB16         38
+#define R_RISCV_SUB32         39
+#define R_RISCV_SUB64         40
+#define R_RISCV_GNU_VTINHERIT 41
+#define R_RISCV_GNU_VTENTRY   42
+#define R_RISCV_ALIGN         43
+#define R_RISCV_RVC_BRANCH    44
+#define R_RISCV_RVC_JUMP      45
+#define R_RISCV_RVC_LUI       46
+#define R_RISCV_GPREL_I       47
+#define R_RISCV_GPREL_S       48
+#define R_RISCV_TPREL_I       49
+#define R_RISCV_TPREL_S       50
+#define R_RISCV_RELAX         51
+#define R_RISCV_SUB6          52
+#define R_RISCV_SET6          53
+#define R_RISCV_SET8          54
+#define R_RISCV_SET16         55
+#define R_RISCV_SET32         56
+
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
--=20
2.19.1
