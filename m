Received: from eggs.gnu.org ([2001:4830:134:3::10]:44588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2k-0001ij-Dc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2i-0006gP-M2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39445 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2i-0006en-7y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:16 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:42 +0200
Message-Id: <1539779635-15445-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/27] target/mips: Reorganize bit definitions
 for insn_flags (ISAs/ASEs flags)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Distribute bits 56-63 vendor-specific ASEs as follows:

  - bits 0-31 MIPS base instruction sets
  - bits 32-47 MIPS ASEs
  - bits 48-55 vendor-specific base instruction sets
  - bits 56-63 vendor-specific ASEs

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/mips-defs.h | 78 ++++++++++++++++++++++++++++---------------=
------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index c8e9979..66b7953 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -22,40 +22,50 @@
 #endif
 #endif
=20
-/* Masks used to mark instructions to indicate which ISA level they
-   were introduced in. */
-#define		ISA_MIPS1	0x00000001
-#define		ISA_MIPS2	0x00000002
-#define		ISA_MIPS3	0x00000004
-#define		ISA_MIPS4	0x00000008
-#define		ISA_MIPS5	0x00000010
-#define		ISA_MIPS32	0x00000020
-#define		ISA_MIPS32R2	0x00000040
-#define		ISA_MIPS64	0x00000080
-#define		ISA_MIPS64R2	0x00000100
-#define   ISA_MIPS32R3  0x00000200
-#define   ISA_MIPS64R3  0x00000400
-#define   ISA_MIPS32R5  0x00000800
-#define   ISA_MIPS64R5  0x00001000
-#define   ISA_MIPS32R6  0x00002000
-#define   ISA_MIPS64R6  0x00004000
-#define   ISA_NANOMIPS32  0x00008000
-
-/* MIPS ASEs. */
-#define   ASE_MIPS16    0x00010000
-#define   ASE_MIPS3D    0x00020000
-#define   ASE_MDMX      0x00040000
-#define   ASE_DSP       0x00080000
-#define   ASE_DSPR2     0x00100000
-#define   ASE_MT        0x00200000
-#define   ASE_SMARTMIPS 0x00400000
-#define   ASE_MICROMIPS 0x00800000
-#define   ASE_MSA       0x01000000
-
-/* Chip specific instructions. */
-#define		INSN_LOONGSON2E  0x20000000
-#define		INSN_LOONGSON2F  0x40000000
-#define		INSN_VR54XX	0x80000000
+/*
+ * bit definitions for insn_flags (ISAs/ASEs flags)
+ * ------------------------------------------------
+ */
+/*
+ *   bits 0-31: MIPS base instruction sets
+ */
+#define ISA_MIPS1         0x0000000000000001ULL
+#define ISA_MIPS2         0x0000000000000002ULL
+#define ISA_MIPS3         0x0000000000000004ULL
+#define ISA_MIPS4         0x0000000000000008ULL
+#define ISA_MIPS5         0x0000000000000010ULL
+#define ISA_MIPS32        0x0000000000000020ULL
+#define ISA_MIPS32R2      0x0000000000000040ULL
+#define ISA_MIPS64        0x0000000000000080ULL
+#define ISA_MIPS64R2      0x0000000000000100ULL
+#define ISA_MIPS32R3      0x0000000000000200ULL
+#define ISA_MIPS64R3      0x0000000000000400ULL
+#define ISA_MIPS32R5      0x0000000000000800ULL
+#define ISA_MIPS64R5      0x0000000000001000ULL
+#define ISA_MIPS32R6      0x0000000000002000ULL
+#define ISA_MIPS64R6      0x0000000000004000ULL
+#define ISA_NANOMIPS32    0x0000000000008000ULL
+/*
+ *   bits 32-47: MIPS ASEs
+ */
+#define ASE_MIPS16        0x0000000100000000ULL
+#define ASE_MIPS3D        0x0000000200000000ULL
+#define ASE_MDMX          0x0000000400000000ULL
+#define ASE_DSP           0x0000000800000000ULL
+#define ASE_DSPR2         0x0000001000000000ULL
+#define ASE_MT            0x0000004000000000ULL
+#define ASE_SMARTMIPS     0x0000008000000000ULL
+#define ASE_MICROMIPS     0x0000010000000000ULL
+#define ASE_MSA           0x0000020000000000ULL
+/*
+ *   bits 48-55: vendor-specific base instruction sets
+ */
+#define INSN_LOONGSON2E   0x0001000000000000ULL
+#define INSN_LOONGSON2F   0x0002000000000000ULL
+#define INSN_VR54XX       0x0004000000000000ULL
+/*
+ *   bits 56-63: vendor-specific ASEs
+ */
=20
 /* MIPS CPU defines. */
 #define		CPU_MIPS1	(ISA_MIPS1)
--=20
2.7.4
