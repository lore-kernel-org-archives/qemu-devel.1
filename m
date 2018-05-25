Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM75e-0007Pr-MG
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM75b-0000ED-LN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:24:42 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fM75b-0000Dq-GD
	for qemu-devel@nongnu.org; Fri, 25 May 2018 03:24:39 -0400
Received: by mail-pl0-x22a.google.com with SMTP id w19-v6so2627810plq.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 00:24:39 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 25 May 2018 19:22:40 +1200
Message-Id: <1527232960-51123-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2] elf: Add RISC-V PSABI ELF header defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>

Refer to the RISC-V PSABI specification for details:

- https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md

Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 include/elf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 934dbbd6b3ae..bd0493f43d19 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1285,6 +1285,14 @@ typedef struct {
 #define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym + add), data8 LSB */
 #define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
 
+/* RISC-V specific definitions.  */
+#define EF_RISCV_RVC 0x0001
+#define EF_RISCV_FLOAT_ABI_SINGLE 0x0002
+#define EF_RISCV_FLOAT_ABI_DOUBLE 0x0004
+#define EF_RISCV_FLOAT_ABI_QUAD 0x0006
+#define EF_RISCV_RVE 0x0008
+#define EF_RISCV_TSO 0x0010
+
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
-- 
2.7.0
