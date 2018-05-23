Received: from eggs.gnu.org ([2001:4830:134:3::10]:42905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHU7-0000dq-FL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHU3-0001TM-DU
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:31 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHU3-0001T8-6o
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:27 -0400
Received: by mail-pf0-x231.google.com with SMTP id a14-v6so9558070pfi.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:27 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:14 +1200
Message-Id: <1527034517-7851-28-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 27/30] elf: Add RISC-V PSABI ELF header
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
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
index 934dbbd6b3ae..d363ba85a688 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1285,6 +1285,14 @@ typedef struct {
 #define R_IA64_DTPREL64LSB	0xb7	/* @dtprel(sym + add), data8 LSB */
 #define R_IA64_LTOFF_DTPREL22	0xba	/* @ltoff(@dtprel(s+a)), imm22 */
 
+/* RISC-V specific definitions.  */
+#define EF_RISCV_RVC 0x0001
+#define EF_RISCV_FLOAT_ABI_SINGLE 0x0002
+#define EF_RISCV_FLOAT_ABI_DOUBLE 0x0004
+#define EF_RISCV_FLOAT_ABI_QUAD (0x0006
+#define EF_RISCV_RVE 0x0008
+#define EF_RISCV_TSO 0x0010
+
 typedef struct elf32_rel {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
-- 
2.7.0
