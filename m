Received: from eggs.gnu.org ([2001:4830:134:3::10]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D6z-00078z-3R
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5D6u-0000Bg-7L
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:43347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5D6u-0000AU-1H
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:51:52 -0400
Received: by mail-pg0-x244.google.com with SMTP id s75so7532043pgs.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 08:51:37 -0700
Message-Id: <20171019155146.30434-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Changes since v5:
  * Rearranged how we choose git submodule vs system installed library.
    By default, the system library will be used, if present;
    Followed by git submodule, if present;
    Followed by not-git submodule, if for some reason a tarball contained it.
  * Force the decision one way or another from the command-line:
    --enable-capstone=system
    --enable-capstone=git.


r~


Richard Henderson (9):
  target/i386: Convert to disas_set_info hook
  target/ppc: Convert to disas_set_info hook
  disas: Remove unused flags arguments
  disas: Support the Capstone disassembler library
  i386: Support Capstone in disas_set_info
  arm: Support Capstone in disas_set_info
  ppc: Support Capstone in disas_set_info
  disas: Remove monitor_disas_is_physical
  disas: Add capstone as submodule

 Makefile                      |  13 ++
 include/disas/bfd.h           |   4 +
 include/disas/capstone.h      |  38 ++++++
 include/disas/disas.h         |   4 +-
 include/exec/log.h            |   4 +-
 disas.c                       | 308 ++++++++++++++++++++++++++++++------------
 monitor.c                     |  29 +---
 target/alpha/translate.c      |   2 +-
 target/arm/cpu.c              |  21 ++-
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
 configure                     |  61 +++++++++
 32 files changed, 431 insertions(+), 151 deletions(-)
 create mode 100644 include/disas/capstone.h
 create mode 160000 capstone

-- 
2.13.6
