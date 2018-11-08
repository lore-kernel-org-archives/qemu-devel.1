Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpGj-0005FS-7S
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpGd-0001dF-Kb
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:43:04 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:30171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKpGd-00018Q-7s
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:42:59 -0500
Date: Thu, 8 Nov 2018 19:42:34 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cover.1541701393.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 0/2] linux-user/mips: Support the n32 ABI for
 the R5900
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

Recognise the R5900, which reports itself as MIPS III, as a 64-bit CPU
supporting the n32 ABI. Test that DMULT is emulated in user mode.

This series has been successfully built with the 10 different build
configurations

    {gcc,clang} x -m64 x mips{,64}el-{linux-user,softmmu}
    {gcc,clang} x -m64 x mipsn32el-linux-user

in addition successfully completing the R5900 test suite

    cd tests/tcg/mips/mipsr5900 && make check
    cd tests/tcg/mips/mipsn32r5900 && make check

Fredrik Noring (2):
  linux-user/mips: Support the n32 ABI for the R5900
  tests/tcg/mips: Test user mode DMULT for the R5900

 linux-user/mips64/target_elf.h       |  3 +++
 tests/tcg/mips/mipsn32r5900/Makefile | 25 +++++++++++++++++
 tests/tcg/mips/mipsn32r5900/dmult.c  | 40 ++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/mips/mipsn32r5900/Makefile
 create mode 100644 tests/tcg/mips/mipsn32r5900/dmult.c

-- 
2.18.1
