Received: from eggs.gnu.org ([2001:4830:134:3::10]:46995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7exu-0003NS-1d
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7exp-0000mJ-Ri
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:00:42 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7exp-0000lN-LC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:00:37 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r196so6831542wmf.2
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:00:30 +0200
Message-Id: <20171026100031.19042-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Support for Capstone, plus an arm32 fix.

Changes since v1:
  * Fixed mingw32 build in patch 11/11.
    (Not re-sending patches 01-10.)

r~


The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-dis-20171026

for you to fetch changes up to e219c499e9f5d4fa0e25dc07682f75531ee84d86:

  disas: Add capstone as submodule (2017-10-26 11:56:20 +0200)

----------------------------------------------------------------
Capstone disassembler

----------------------------------------------------------------
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

 Makefile                      |  15 ++
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
 configure                     |  72 ++++++++++
 33 files changed, 467 insertions(+), 184 deletions(-)
 create mode 100644 include/disas/capstone.h
 create mode 160000 capstone
