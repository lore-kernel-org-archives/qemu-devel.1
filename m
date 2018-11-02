Received: from eggs.gnu.org ([2001:4830:134:3::10]:51563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIbz7-0007qf-Di
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIbz1-0001fb-Nc
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:07:45 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIbz1-0001Yg-CV
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:07:39 -0400
Date: Fri, 2 Nov 2018 17:07:31 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1541174426.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 0/2] target/mips: Fix decoding mechanisms of
 R5900 M{F, T}{HI, LO}1 and DIV[U]1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

This series amends the R5900 support with the following changes:

- MFLO1, MFHI1, MTLO1 and MTHI1 are generated in gen_HILO1_tx79 instead
  of the generic gen_HILO.

- DIV1 and DIVU1 are generated in gen_div1_tx79 instead of the generic
  gen_muldiv.

Fredrik Noring (2):
  target/mips: Fix decoding mechanism of R5900 MFLO1, MFHI1, MTLO1 and MTHI1
  target/mips: Fix decoding mechanism of R5900 DIV1 and DIVU1

 target/mips/translate.c | 132 ++++++++++++++++++++++++++++++++++------
 1 file changed, 115 insertions(+), 17 deletions(-)

-- 
2.18.1
