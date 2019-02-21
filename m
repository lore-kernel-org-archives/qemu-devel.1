Received: from eggs.gnu.org ([209.51.188.92]:58012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcT9-00048w-79
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcT5-0002Mf-H7
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:44:05 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 21 Feb 2019 00:43:59 +0000
Message-ID: <c0de9603ba99d5d0aa5b9222366724cbc465ca0f.1550709660.git.alistair.francis@wdc.com>
References: <cover.1550709660.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1550709660.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 05/11] elf: Add RISC-V PSABI ELF header
 defines
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

From: Michael Clark <mjc@sifive.com>

Refer to the RISC-V PSABI specification for details:

- https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md

Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/elf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index b35347eee7..ea7708a4ea 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1393,6 +1393,16 @@ typedef struct {
 #define R_RISCV_SET16         55
 #define R_RISCV_SET32         56
=20
+/* RISC-V ELF Flags.  */
+#define EF_RISCV_RVC              0x0001
+#define EF_RISCV_FLOAT_ABI        0x0006
+#define EF_RISCV_FLOAT_ABI_SOFT   0x0000
+#define EF_RISCV_FLOAT_ABI_SINGLE 0x0002
+#define EF_RISCV_FLOAT_ABI_DOUBLE 0x0004
+#define EF_RISCV_FLOAT_ABI_QUAD   0x0006
+#define EF_RISCV_RVE              0x0008
+#define EF_RISCV_TSO              0x0010
+
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
--=20
2.20.1
