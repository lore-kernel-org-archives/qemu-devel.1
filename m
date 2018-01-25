Received: from eggs.gnu.org ([2001:4830:134:3::10]:48470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFf-0006EC-EG
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFc-0000ir-53
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:43 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eejFb-0000i2-Rw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:40 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 25 Jan 2018 16:15:27 +0100
Message-Id: <20180125151535.25256-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/8] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit 0f79bfe38a2cf0f43c7ea4959da7f8ebd7858f3d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-01-25 09:53:53 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 2097dca6d3a30b80ac5a6232f518548d5ae644a9:

  target/m68k: add HMP command "info tlb" (2018-01-25 16:02:25 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (8):
  target/m68k: fix TCG variable double free
  accel/tcg: add size paremeter in tlb_fill()
  target/m68k: add MC68040 MMU
  target/m68k: add Transparent Translation
  target/m68k: add index parameter to gen_load()/gen_store() and Co.
  target/m68k: add moves
  target/m68k: add pflush/ptest
  target/m68k: add HMP command "info tlb"

 accel/tcg/cputlb.c            |  13 +-
 accel/tcg/softmmu_template.h  |  14 +-
 accel/tcg/user-exec.c         |   2 +-
 hmp-commands-info.hx          |   2 +-
 include/exec/exec-all.h       |   6 +-
 include/qom/cpu.h             |   2 +-
 target/alpha/cpu.h            |   2 +-
 target/alpha/helper.c         |   4 +-
 target/alpha/mem_helper.c     |   6 +-
 target/arm/cpu.c              |   4 +-
 target/arm/op_helper.c        |   4 +-
 target/cris/cpu.h             |   2 +-
 target/cris/helper.c          |   4 +-
 target/cris/op_helper.c       |   6 +-
 target/hppa/cpu.h             |   3 +-
 target/hppa/helper.c          |   2 +-
 target/hppa/op_helper.c       |   2 +-
 target/i386/cpu.h             |   2 +-
 target/i386/excp_helper.c     |   4 +-
 target/i386/mem_helper.c      |   6 +-
 target/lm32/cpu.h             |   2 +-
 target/lm32/helper.c          |   2 +-
 target/lm32/op_helper.c       |   6 +-
 target/m68k/cpu.c             |   4 +-
 target/m68k/cpu.h             | 161 ++++++++++-
 target/m68k/helper.c          | 606 +++++++++++++++++++++++++++++++++++++++++-
 target/m68k/helper.h          |   2 +
 target/m68k/monitor.c         |  22 ++
 target/m68k/op_helper.c       | 101 ++++++-
 target/m68k/translate.c       | 234 +++++++++++-----
 target/microblaze/cpu.h       |   2 +-
 target/microblaze/helper.c    |   4 +-
 target/microblaze/op_helper.c |   6 +-
 target/mips/helper.c          |   2 +-
 target/mips/internal.h        |   2 +-
 target/mips/op_helper.c       |  10 +-
 target/moxie/cpu.h            |   2 +-
 target/moxie/helper.c         |  10 +-
 target/nios2/cpu.h            |   2 +-
 target/nios2/helper.c         |   6 +-
 target/nios2/mmu.c            |   6 +-
 target/openrisc/cpu.h         |   2 +-
 target/openrisc/mmu.c         |   8 +-
 target/openrisc/mmu_helper.c  |   6 +-
 target/ppc/cpu.h              |   2 +-
 target/ppc/mmu_helper.c       |   4 +-
 target/ppc/user_only_helper.c |   2 +-
 target/s390x/excp_helper.c    |   4 +-
 target/s390x/internal.h       |   2 +-
 target/s390x/mem_helper.c     |   8 +-
 target/sh4/cpu.h              |   2 +-
 target/sh4/helper.c           |   4 +-
 target/sh4/op_helper.c        |   6 +-
 target/sparc/cpu.h            |   2 +-
 target/sparc/ldst_helper.c    |   6 +-
 target/sparc/mmu_helper.c     |   6 +-
 target/tilegx/cpu.c           |   4 +-
 target/tricore/op_helper.c    |   4 +-
 target/unicore32/cpu.h        |   2 +-
 target/unicore32/helper.c     |   2 +-
 target/unicore32/op_helper.c  |   6 +-
 target/unicore32/softmmu.c    |   2 +-
 target/xtensa/op_helper.c     |   4 +-
 63 files changed, 1167 insertions(+), 203 deletions(-)

-- 
2.14.3
