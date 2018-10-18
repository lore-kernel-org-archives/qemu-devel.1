Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMF-0000Yc-2f
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDM3-0005Ux-E6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56684 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDDM3-000443-4p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 18 Oct 2018 20:47:30 +0200
Message-Id: <1539888473-16340-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/28] elf: Fix comments to EF_MIPS_MACH_xxx
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

Regarding R5900 CPU, some sources indicate that the Emotion Engine
ISA/ASE was designed by Toshiba and licensed to Sony. Others sources
claim it was a joint effort. It therefore makes sense to refer to
the CPU as "Toshiba/Sony R5900".

Also, remove and "'s" in the line for some other CPU, for the sake
of consistency.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/elf.h b/include/elf.h
index 911b95a..5f45f9b 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -79,9 +79,9 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_MACH_OCTEON2  0x008d0000  /* Cavium Networks Octeon2    =
     */
 #define EF_MIPS_MACH_OCTEON3  0x008e0000  /* Cavium Networks Octeon3    =
     */
 #define EF_MIPS_MACH_5400     0x00910000  /* NEC VR5400                 =
     */
-#define EF_MIPS_MACH_5900     0x00920000  /* MIPS R5900                 =
     */
+#define EF_MIPS_MACH_5900     0x00920000  /* Toshiba/Sony R5900         =
     */
 #define EF_MIPS_MACH_5500     0x00980000  /* NEC VR5500                 =
     */
-#define EF_MIPS_MACH_9000     0x00990000  /* PMC-Sierra's RM9000        =
     */
+#define EF_MIPS_MACH_9000     0x00990000  /* PMC-Sierra RM9000          =
     */
 #define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongso=
n 2E */
 #define EF_MIPS_MACH_LS2F     0x00a10000  /* ST Microelectronics Loongso=
n 2F */
 #define EF_MIPS_MACH_LS3A     0x00a20000  /* ST Microelectronics Loongso=
n 3A */
--=20
2.7.4
