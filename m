Received: from eggs.gnu.org ([2001:4830:134:3::10]:44510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFmMU-0001VT-56
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFm7W-0002nO-K8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:20:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42567 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFm7W-00028U-AE
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:20:42 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 25 Oct 2018 22:19:25 +0200
Message-Id: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 0/3] MIPS queue for October 2018 - part 3
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99cf2:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf0' into staging (2018-10-25 17:41:03 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-3

for you to fetch changes up to 89a955e8df3dba6f96859cd0339356243b6c996f:

  target/mips: Add disassembler support for nanoMIPS (2018-10-25 22:13:33 +0200)

----------------------------------------------------------------
MIPS queue for October 2018 - part 3

  - this pull request contains three assorted nanoMIPS issues
  - three checkpatch.pl warnings are known and should be ignored
----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Add nanoMIPS CRC32 instruction pool
  target/mips: Add disassembler support for nanoMIPS

Dimitrije Nikolic (1):
  target/mips: Implement emulation of nanoMIPS EVA instructions

 MAINTAINERS             |     2 +
 configure               |     3 +
 disas/Makefile.objs     |     1 +
 disas/nanomips.cpp      | 22242 ++++++++++++++++++++++++++++++++++++++++++++++
 disas/nanomips.h        |  1099 +++
 include/disas/bfd.h     |     1 +
 include/exec/poison.h   |     1 +
 target/mips/cpu.c       |    13 +-
 target/mips/translate.c |   138 +
 9 files changed, 23498 insertions(+), 2 deletions(-)
 create mode 100644 disas/nanomips.cpp
 create mode 100644 disas/nanomips.h

-- 
2.7.4
