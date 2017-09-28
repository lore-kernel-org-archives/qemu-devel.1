Received: from eggs.gnu.org ([2001:4830:134:3::10]:55279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4w-0004mP-1D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxc4t-0004KK-Po
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:26 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:56398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxc4t-0004Jr-KK
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:54:23 -0400
Received: by mail-pf0-x231.google.com with SMTP id g65so1136575pfe.13
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:54:23 -0700 (PDT)
Received: from bigtime.twiddle.net ([70.35.39.2])
	by smtp.gmail.com with ESMTPSA id
	e133sm3062332pfh.177.2017.09.28.09.54.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 28 Sep 2017 09:54:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Sep 2017 09:54:05 -0700
Message-Id: <20170928165414.7339-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes since v3:
  * Adjust how the submodule is detected and invoked.
    - This should fix the reported patchew failure,
    - Fixes e.g. -m32 "cross" compilation, or similar
      abi-changing option sets.


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
 configure                     |  36 +++++
 32 files changed, 406 insertions(+), 151 deletions(-)
 create mode 100644 include/disas/capstone.h
 create mode 160000 capstone

-- 
2.13.5
