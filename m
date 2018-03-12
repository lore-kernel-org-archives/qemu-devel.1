Received: from eggs.gnu.org ([2001:4830:134:3::10]:35738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW25-0003lB-B2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evW21-0003ad-Ax
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evW21-0003aV-52
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:35:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:34:48 -0300
Message-Id: <20180312223455.18124-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Machine queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca7845881a6:

  cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-12 19:33:32 -0300)

----------------------------------------------------------------
Machine queue, 2018-03-12

----------------------------------------------------------------

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
