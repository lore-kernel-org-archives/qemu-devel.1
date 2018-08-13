Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH37-0005Op-3A
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH33-00073R-FZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55750 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH33-000728-8o
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:41 +0200
Message-Id: <1534182832-554-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 16/87] elf: Add ELF flags for MIPS machine
 variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add MIPS machine variants ELF flags so that the emulation behavior
can be adjusted if needed.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 include/elf.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 60f6cbe..28a5a63 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -62,6 +62,29 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_FP64      0x00000200
 #define EF_MIPS_NAN2008   0x00000400
=20
+/* MIPS machine variant */
+#define EF_MIPS_MACH_NONE     0x00000000  /* A standard MIPS implementat=
ion  */
+#define EF_MIPS_MACH_3900     0x00810000  /* Toshiba R3900              =
     */
+#define EF_MIPS_MACH_4010     0x00820000  /* LSI R4010                  =
     */
+#define EF_MIPS_MACH_4100     0x00830000  /* NEC VR4100                 =
     */
+#define EF_MIPS_MACH_4650     0x00850000  /* MIPS R4650                 =
     */
+#define EF_MIPS_MACH_4120     0x00870000  /* NEC VR4120                 =
     */
+#define EF_MIPS_MACH_4111     0x00880000  /* NEC VR4111/VR4181          =
     */
+#define EF_MIPS_MACH_SB1      0x008a0000  /* Broadcom SB-1              =
     */
+#define EF_MIPS_MACH_OCTEON   0x008b0000  /* Cavium Networks Octeon     =
     */
+#define EF_MIPS_MACH_XLR      0x008c0000  /* RMI Xlr                    =
     */
+#define EF_MIPS_MACH_OCTEON2  0x008d0000  /* Cavium Networks Octeon2    =
     */
+#define EF_MIPS_MACH_OCTEON3  0x008e0000  /* Cavium Networks Octeon3    =
     */
+#define EF_MIPS_MACH_5400     0x00910000  /* NEC VR5400                 =
     */
+#define EF_MIPS_MACH_5900     0x00920000  /* MIPS R5900                 =
     */
+#define EF_MIPS_MACH_5500     0x00980000  /* NEC VR5500                 =
     */
+#define EF_MIPS_MACH_9000     0x00990000  /* PMC-Sierra's RM9000        =
     */
+#define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongso=
n 2E */
+#define EF_MIPS_MACH_LS2F     0x00a10000  /* ST Microelectronics Loongso=
n 2F */
+#define EF_MIPS_MACH_LS3A     0x00a20000  /* ST Microelectronics Loongso=
n 3A */
+#define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection =
mask */
+
+
 /* These constants define the different elf file types */
 #define ET_NONE   0
 #define ET_REL    1
--=20
2.7.4
