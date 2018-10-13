Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHpM-0007Rn-OE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHpL-0000EG-23
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:24 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:29961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHpK-0000CP-CI
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:11:22 -0400
Date: Sat, 13 Oct 2018 13:11:07 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <540683755a2357b670b107a29658531466be18f4.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 7/7] elf: Toshiba/Sony rather than MIPS are
 the implementors of the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Sources [1][2] indicate that the Emotion Engine was designed by Toshiba
and licensed to Sony. Others [3][4][5] claim it was a joint effort. It
therefore makes sense to refer to the CPU as "Toshiba/Sony R5900".

[1] http://cs.nyu.edu/courses/spring02/V22.0480-002/projects/aldrich/emot=
ionengine.ppt
[2] http://archive.arstechnica.com/reviews/1q00/playstation2/m-ee-3.html
[3] http://docencia.ac.upc.edu/ETSETB/SEGPAR/microprocessors/emotionengin=
e%20(mpr).pdf
[4] http://www.eetimes.com/document.asp?doc_id=3D1144055
[5] https://www.toshiba.co.jp/about/press/2001_09/pr2701.htm

Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index 312f68af81..2510fc7be4 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -76,7 +76,7 @@ typedef int64_t  Elf64_Sxword;
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
 #define EF_MIPS_MACH_9000     0x00990000  /* PMC-Sierra's RM9000        =
     */
 #define EF_MIPS_MACH_LS2E     0x00a00000  /* ST Microelectronics Loongso=
n 2E */
--=20
2.16.4
