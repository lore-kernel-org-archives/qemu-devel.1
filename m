Received: from eggs.gnu.org ([2001:4830:134:3::10]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXOZ-0007TZ-KH
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXOV-0000sA-FQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewXOV-0000q8-9s
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:14:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 15 Mar 2018 15:14:13 -0300
Message-Id: <20180315181420.8694-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/7] Machine queue, 2018-03-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Changes in v2 (v1 was 2018-03-12):
* Fix bsd-user build error

The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 7cbb6fd8926b9b590c0725b9b7d0a11db6aefd08:

  cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-15 14:52:40 -0300)

----------------------------------------------------------------
Machine queue, 2018-03-15

----------------------------------------------------------------

Queue for Machine Core patches


Igor Mammedov (6):
  nios2: 10m50_devboard: replace cpu_model with cpu_type
  tests: add machine 'none' with -cpu test
  cpu: add CPU_RESOLVING_TYPE macro
  Use cpu_create(type) instead of cpu_init(cpu_model)
  cpu: get rid of unused cpu_init() defines
  cpu: drop unnecessary NULL check and cpu_common_class_by_name()

Wang Xin (1):
  pc: correct misspelled CPU model-id for pc 2.2

 include/hw/boards.h       |   1 -
 include/hw/i386/pc.h      |   2 +-
 include/qom/cpu.h         |  16 +-------
 target/alpha/cpu.h        |   3 +-
 target/arm/cpu.h          |   3 +-
 target/cris/cpu.h         |   3 +-
 target/hppa/cpu.h         |   2 +-
 target/i386/cpu.h         |   3 +-
 target/lm32/cpu.h         |   3 +-
 target/m68k/cpu.h         |   3 +-
 target/microblaze/cpu.h   |   2 +-
 target/mips/cpu.h         |   3 +-
 target/moxie/cpu.h        |   3 +-
 target/nios2/cpu.h        |   2 +-
 target/openrisc/cpu.h     |   3 +-
 target/ppc/cpu.h          |   3 +-
 target/riscv/cpu.h        |   1 +
 target/s390x/cpu.h        |   3 +-
 target/sh4/cpu.h          |   3 +-
 target/sparc/cpu.h        |   5 +--
 target/tilegx/cpu.h       |   2 +-
 target/tricore/cpu.h      |   3 +-
 target/unicore32/cpu.h    |   3 +-
 target/xtensa/cpu.h       |   3 +-
 bsd-user/main.c           |   4 +-
 exec.c                    |  23 +++++++++++
 hw/core/null-machine.c    |   6 +--
 hw/nios2/10m50_devboard.c |   2 +-
 linux-user/main.c         |   8 +++-
 qom/cpu.c                 |  61 +++-------------------------
 target/i386/cpu.c         |   8 +---
 tests/machine-none-test.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                      |  10 ++---
 tests/Makefile.include    |   2 +
 34 files changed, 173 insertions(+), 130 deletions(-)
 create mode 100644 tests/machine-none-test.c

-- 
2.14.3
