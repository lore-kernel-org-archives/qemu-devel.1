Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFbKX-0000eP-3p
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFbKR-00078r-3Z
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:49:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44267 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFbKQ-000782-Rk
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:49:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 25 Oct 2018 10:49:03 +0200
Message-Id: <1540457346-30999-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/3] target/mips: Add some nanoMIPS bits and
 pieces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add nanoMIPS bits and pieces that for various reasons didn't manage
to be integrated.

NOTE: Three checkpatch.pl warning are known, and won't be fixed:
one is dictated by file format, and the other two are bogus.

v1->v2:

  - added support for successful builds within environments without
    c++ compiler (done after a similar case of arm_64 disassembler)
  - further cleanup of disas/nanomips.cpp

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
