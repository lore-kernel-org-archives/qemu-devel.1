Received: from eggs.gnu.org ([2001:4830:134:3::10]:49386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Yx-0008EE-VG
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Yw-0006iu-VT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:57:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53808 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Yw-0006hk-N4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:57:30 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:45 +0200
Message-Id: <1532453527-22911-34-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 33/55] elf: Add nanoMIPS specific variations
 in ELF header fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add nanoMIPS-related values in ELF header fields as specified in
nanoMIPS' "ELF ABI Supplement".

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 include/elf.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 2c4fe7a..fff5967 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -62,6 +62,24 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_NAN2008   0x00000400
 #define EF_MIPS_ARCH      0xf0000000
 
+/* nanoMIPS architecture bits, EF_NANOMIPS_ARCH */
+#define EF_NANOMIPS_ARCH_32R6 0x00000000  /* 32-bit nanoMIPS Release 6 ISA   */
+#define EF_NANOMIPS_ARCH_64R6 0x10000000  /* 62-bit nanoMIPS Release 6 ISA   */
+
+/* nanoMIPS ABI bits, EF_NANOMIPS_ABI */
+#define EF_NANOMIPS_ABI_P32   0x00001000  /* 32-bit nanoMIPS ABI             */
+#define EF_NANOMIPS_ABI_P64   0x00002000  /* 64-bit nanoMIPS ABI             */
+
+/* nanoMIPS processor specific flags, e_flags */
+#define EF_NANOMIPS_LINKRELAX 0x00000001  /* Link-time relaxation            */
+#define EF_NANOMIPS_PIC       0x00000002  /* Position independant code       */
+#define EF_NANOMIPS_32BITMODE 0x00000004  /* 32-bit object for 64-bit arch.  */
+#define EF_NANOMIPS_PID       0x00000008  /* Position independant data       */
+#define EF_NANOMIPS_PCREL     0x00000010  /* PC-relative mode                */
+#define EF_NANOMIPS_ABI       0x0000f000  /* nanoMIPS ABI                    */
+#define EF_NANOMIPS_MACH      0x00ff0000  /* Machine variant                 */
+#define EF_NANOMIPS_ARCH      0xf0000000  /* nanoMIPS architecture           */
+
 /* MIPS machine variant */
 #define EF_MIPS_MACH_NONE     0x00000000  /* A standard MIPS implementation  */
 #define EF_MIPS_MACH_3900     0x00810000  /* Toshiba R3900                   */
@@ -143,6 +161,8 @@ typedef int64_t  Elf64_Sxword;
 
 #define EM_RISCV        243     /* RISC-V */
 
+#define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
+
 /*
  * This is an interim value that we will use until the committee comes
  * up with a final number.
-- 
2.7.4
