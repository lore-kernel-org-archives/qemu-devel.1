Received: from eggs.gnu.org ([2001:4830:134:3::10]:37256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PP-0002CO-Hz
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PK-00089p-MA
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:31 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:43139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e64PK-00088w-Eb
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:26 -0400
Received: by mail-pg0-x22a.google.com with SMTP id s75so9206760pgs.0
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 17:46:26 -0700 (PDT)
Received: from cloudburst.twiddle.net (174-21-9-158.tukw.qwest.net.
	[174.21.9.158]) by smtp.gmail.com with ESMTPSA id
	j12sm5766728pgs.35.2017.10.21.17.46.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 21 Oct 2017 17:46:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 21 Oct 2017 17:46:10 -0700
Message-Id: <20171022004621.28372-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 00/11] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v7:
  * Included target/arm disassembler changes, since one of them
    is affected by the Capstone change.
  * Re-re-redone the module patch (11/11);
    v6 didn't actually work without capstone present in any form.


r~


Richard Henderson (11):
  target/i386: Convert to disas_set_info hook
  target/ppc: Convert to disas_set_info hook
  target/arm: Move BE32 disassembler fixup
  target/arm: Don't set INSN_ARM_BE32 for CONFIG_USER_ONLY
  disas: Remove unused flags arguments
  disas: Support the Capstone disassembler library
  i386: Support Capstone in disas_set_info
  arm: Support Capstone in disas_set_info
  ppc: Support Capstone in disas_set_info
  disas: Remove monitor_disas_is_physical
  disas: Add capstone as submodule

 Makefile                      |  13 ++
 include/disas/bfd.h           |  11 +-
 include/disas/capstone.h      |  38 ++++++
 include/disas/disas.h         |   4 +-
 include/exec/log.h            |   4 +-
 disas.c                       | 308 ++++++++++++++++++++++++++++++------------
 disas/arm.c                   |  21 ++-
 monitor.c                     |  29 +---
 target/alpha/translate.c      |   2 +-
 target/arm/cpu.c              |  49 +++----
 target/arm/translate-a64.c    |   3 +-
 target/arm/translate.c        |   3 +-
 target/cris/translate.c       |   3 +-
 target/hppa/translate.c       |   2 +-
 target/i386/cpu.c             |  19 +++
 target/i386/translate.c       |   8 +-
 target/lm32/translate.c       |   2 +-
 target/m68k/translate.c       |   2 +-
 target/microblaze/translate.c |   2 +-
 target/mips/translate.c       |   2 +-
 target/nios2/translate.c      |   2 +-
 target/openrisc/translate.c   |   2 +-
 target/ppc/translate.c        |   5 +-
 target/ppc/translate_init.c   |  27 ++++
 target/s390x/translate.c      |   2 +-
 target/sh4/translate.c        |   2 +-
 target/sparc/translate.c      |   2 +-
 target/tricore/translate.c    |   2 +-
 target/unicore32/translate.c  |   2 +-
 target/xtensa/translate.c     |   2 +-
 .gitmodules                   |   3 +
 capstone                      |   1 +
 configure                     |  64 +++++++++
 33 files changed, 457 insertions(+), 184 deletions(-)
 create mode 100644 include/disas/capstone.h
 create mode 160000 capstone

-- 
2.13.6
