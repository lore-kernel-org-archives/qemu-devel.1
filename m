Received: from eggs.gnu.org ([2001:4830:134:3::10]:43107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19V-00021R-OL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19R-0006eX-7U
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ey19R-0006e1-1l
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 19 Mar 2018 17:12:48 -0300
Message-Id: <20180319201255.9317-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v3 0/7] Machine and x86 queue, 2018-03-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Changes v2 (2018-03-15) -> v3 (2018-03-19):
* Fix bogus warnings on machine-none-test
* Included Intel PT CPUID fix

Changes v1 (2018-03-12) -> v2 (2018-03-15):
* Fix bsd-user build error

The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805be:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-19 11:44:26 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to c078ca968c6c7cb62781c1843d840cb0f5c72781:

  i386: Disable Intel PT if packets IP payloads have LIP values (2018-03-19 17:05:57 -0300)

----------------------------------------------------------------
Machine and x86 queue, 2018-03-19

* cpu_model/cpu_type cleanups
* x86: Fix on Intel Processor Trace CPUID checks

----------------------------------------------------------------

Queue for Machine Core patches


Igor Mammedov (6):
  nios2: 10m50_devboard: replace cpu_model with cpu_type
  tests: add machine 'none' with -cpu test
  cpu: add CPU_RESOLVING_TYPE macro
  Use cpu_create(type) instead of cpu_init(cpu_model)
  cpu: get rid of unused cpu_init() defines
  cpu: drop unnecessary NULL check and cpu_common_class_by_name()

Luwei Kang (1):
  i386: Disable Intel PT if packets IP payloads have LIP values

 include/hw/boards.h       |   1 -
 include/qom/cpu.h         |  16 +------
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
 qom/cpu.c                 |  61 +++------------------------
 target/i386/cpu.c         |  13 +++---
 tests/machine-none-test.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                      |  10 ++---
 tests/Makefile.include    |   2 +
 33 files changed, 178 insertions(+), 130 deletions(-)
 create mode 100644 tests/machine-none-test.c

-- 
2.14.3
