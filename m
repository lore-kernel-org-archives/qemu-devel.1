Received: from eggs.gnu.org ([2001:4830:134:3::10]:36578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMyt-0004B5-Qw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFMyp-0001I7-NB
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56183 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFMyp-0001FE-CV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:30:03 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 19:29:47 +0200
Message-Id: <1540402190-26289-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Add some nanoMIPS bits and
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

Add some nanoMIPS bits and pieces that for various reasons
didn't manage to be integrated.

Aleksandar Markovic (2):
  target/mips: Add nanoMIPS CRC32 instruction pool
  target/mips: Add disassembler support for nanoMIPS

Dimitrije Nikolic (1):
  target/mips: Implement emulation of nanoMIPS EVA instructions

 MAINTAINERS             |     2 +
 disas/Makefile.objs     |     1 +
 disas/mips.c            |    90 +-
 disas/nanomips.cpp      | 22134 ++++++++++++++++++++++++++++++++++++++++++++++
 disas/nanomips.h        |  1100 +++
 include/disas/bfd.h     |     1 +
 target/mips/cpu.c       |    11 +-
 target/mips/translate.c |   138 +
 8 files changed, 23474 insertions(+), 3 deletions(-)
 create mode 100644 disas/nanomips.cpp
 create mode 100644 disas/nanomips.h

-- 
2.7.4
