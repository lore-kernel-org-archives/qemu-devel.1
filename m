Received: from eggs.gnu.org ([2001:4830:134:3::10]:32826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q1-0006HR-SH
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4pz-00066g-CN
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:09:55 +0200
Message-Id: <20180430091037.13878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/42] Linux user for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request

for you to fetch changes up to 62aaa5146476911aea1fbe6fbf919d06bba8ab5d:

  linux-user: Add ARM get_tls syscall support (2018-04-30 09:51:31 +0200)

----------------------------------------------------------------
Essentially moving code: move signal and cpu_loop arch specific
functions under the linux-user/<arch> directory
Add get_tls() syscall and update the patch to apply on 
linux-user/arm/cpu_loop.c
minor fix for RISC-V (uname) and getdents()
----------------------------------------------------------------

Alex Bennée (1):
  linux-user: set minimum uname for RISC-V

Christophe Lyon (1):
  linux-user: Add ARM get_tls syscall support

Laurent Vivier (39):
  linux-user: create a dummy per arch signal.c
  linux-user: move aarch64 signal.c parts to aarch64 directory
  linux-user: move arm signal.c parts to arm directory
  linux-user: move sh4 signal.c parts to sh4 directory
  linux-user: move microblaze signal.c parts to microblaze directory
  linux-user: move cris signal.c parts to cris directory
  linux-user: move nios2 signal.c parts to nios2 directory
  linux-user: move openrisc signal.c parts to openrisc directory
  linux-user: move s390x signal.c parts to s390x directory
  linux-user: move m68k signal.c parts to m68k directory
  linux-user: move alpha signal.c parts to alpha directory
  linux-user: move tilegx signal.c parts to tilegx directory
  linux-user: move riscv signal.c parts to riscv directory
  linux-user: move hppa signal.c parts to hppa directory
  linux-user: move xtensa signal.c parts to xtensa directory
  linux-user: move i386/x86_64 signal.c parts to i386 directory
  linux-user: move sparc/sparc64 signal.c parts to sparc directory
  linux-user: move mips/mips64 signal.c parts to mips directory
  linux-user: move ppc/ppc64 signal.c parts to ppc directory
  linux-user: define TARGET_ARCH_HAS_SETUP_FRAME
  linux-user: create a dummy per arch cpu_loop.c
  linux-user: move i386/x86_64 cpu loop to i386 directory
  linux-user: move aarch64 cpu loop to aarch64 directory
  linux-user: move arm cpu loop to arm directory
  linux-user: move sparc/sparc64 cpu loop to sparc directory
  linux-user: move ppc/ppc64 cpu loop to ppc directory
  linux-user: move mips/mips64 cpu loop to mips directory
  linux-user: move nios2 cpu loop to nios2 directory
  linux-user: move openrisc cpu loop to openrisc directory
  linux-user: move sh4 cpu loop to sh4 directory
  linux-user: move cris cpu loop to cris directory
  linux-user: move microblaze cpu loop to microblaze directory
  linux-user: move m68k cpu loop to m68k directory
  linux-user: move alpha cpu loop to alpha directory
  linux-user: move s390x cpu loop to s390x directory
  linux-user: move tilegx cpu loop to tilegx directory
  linux-user: move riscv cpu loop to riscv directory
  linux-user: move hppa cpu loop to hppa directory
  linux-user: move xtensa cpu loop to xtensa directory

Peter Maydell (1):
  linux-user: Fix getdents emulation for 64 bit guest on 32 bit host

 linux-user/Makefile.objs              |    3 +-
 linux-user/aarch64/cpu_loop.c         |  182 +
 linux-user/aarch64/signal.c           |  586 +++
 linux-user/aarch64/target_signal.h    |    1 +
 linux-user/alpha/cpu_loop.c           |  225 ++
 linux-user/alpha/signal.c             |  280 ++
 linux-user/alpha/target_signal.h      |    1 +
 linux-user/arm/cpu_loop.c             |  459 +++
 linux-user/arm/signal.c               |  772 ++++
 linux-user/arm/target_signal.h        |    2 +-
 linux-user/arm/target_syscall.h       |    1 +
 linux-user/cpu_loop-common.h          |   37 +
 linux-user/cris/cpu_loop.c            |  115 +
 linux-user/cris/signal.c              |  189 +
 linux-user/cris/target_signal.h       |    2 +-
 linux-user/hppa/cpu_loop.c            |  211 ++
 linux-user/hppa/signal.c              |  210 ++
 linux-user/hppa/target_signal.h       |    1 -
 linux-user/i386/cpu_loop.c            |  369 ++
 linux-user/i386/signal.c              |  602 +++
 linux-user/i386/target_signal.h       |    1 +
 linux-user/m68k/cpu_loop.c            |  170 +
 linux-user/m68k/signal.c              |  428 +++
 linux-user/m68k/target_signal.h       |    2 +-
 linux-user/main.c                     | 4440 +---------------------
 linux-user/microblaze/cpu_loop.c      |  176 +
 linux-user/microblaze/signal.c        |  248 ++
 linux-user/microblaze/target_signal.h |    2 +-
 linux-user/mips/cpu_loop.c            |  749 ++++
 linux-user/mips/signal.c              |  400 ++
 linux-user/mips/target_signal.h       |    5 +-
 linux-user/mips64/cpu_loop.c          |   20 +
 linux-user/mips64/signal.c            |   20 +
 linux-user/mips64/target_signal.h     |    2 -
 linux-user/nios2/cpu_loop.c           |  152 +
 linux-user/nios2/signal.c             |  254 ++
 linux-user/nios2/target_signal.h      |    1 -
 linux-user/openrisc/cpu_loop.c        |  115 +
 linux-user/openrisc/signal.c          |  231 ++
 linux-user/openrisc/target_signal.h   |    2 -
 linux-user/ppc/cpu_loop.c             |  579 +++
 linux-user/ppc/signal.c               |  689 ++++
 linux-user/ppc/target_signal.h        |    4 +-
 linux-user/riscv/cpu_loop.c           |  118 +
 linux-user/riscv/signal.c             |  218 ++
 linux-user/riscv/target_signal.h      |    1 -
 linux-user/riscv/target_syscall.h     |    2 +-
 linux-user/s390x/cpu_loop.c           |  165 +
 linux-user/s390x/signal.c             |  327 ++
 linux-user/s390x/target_signal.h      |    2 +-
 linux-user/sh4/cpu_loop.c             |  111 +
 linux-user/sh4/signal.c               |  350 ++
 linux-user/sh4/target_signal.h        |    2 +-
 linux-user/signal-common.h            |   57 +
 linux-user/signal.c                   | 6652 +--------------------------------
 linux-user/sparc/cpu_loop.c           |  306 ++
 linux-user/sparc/signal.c             |  624 ++++
 linux-user/sparc/target_signal.h      |    2 +-
 linux-user/sparc64/cpu_loop.c         |   20 +
 linux-user/sparc64/signal.c           |   20 +
 linux-user/sparc64/target_signal.h    |    2 +-
 linux-user/syscall.c                  |   18 +-
 linux-user/tilegx/cpu_loop.c          |  286 ++
 linux-user/tilegx/signal.c            |  186 +
 linux-user/tilegx/target_signal.h     |    2 -
 linux-user/x86_64/cpu_loop.c          |   20 +
 linux-user/x86_64/signal.c            |   20 +
 linux-user/x86_64/target_signal.h     |    1 -
 linux-user/xtensa/cpu_loop.c          |  267 ++
 linux-user/xtensa/signal.c            |  268 ++
 linux-user/xtensa/target_signal.h     |    1 -
 71 files changed, 11996 insertions(+), 10990 deletions(-)
 create mode 100644 linux-user/aarch64/cpu_loop.c
 create mode 100644 linux-user/aarch64/signal.c
 create mode 100644 linux-user/alpha/cpu_loop.c
 create mode 100644 linux-user/alpha/signal.c
 create mode 100644 linux-user/arm/cpu_loop.c
 create mode 100644 linux-user/arm/signal.c
 create mode 100644 linux-user/cpu_loop-common.h
 create mode 100644 linux-user/cris/cpu_loop.c
 create mode 100644 linux-user/cris/signal.c
 create mode 100644 linux-user/hppa/cpu_loop.c
 create mode 100644 linux-user/hppa/signal.c
 create mode 100644 linux-user/i386/cpu_loop.c
 create mode 100644 linux-user/i386/signal.c
 create mode 100644 linux-user/m68k/cpu_loop.c
 create mode 100644 linux-user/m68k/signal.c
 create mode 100644 linux-user/microblaze/cpu_loop.c
 create mode 100644 linux-user/microblaze/signal.c
 create mode 100644 linux-user/mips/cpu_loop.c
 create mode 100644 linux-user/mips/signal.c
 create mode 100644 linux-user/mips64/cpu_loop.c
 create mode 100644 linux-user/mips64/signal.c
 create mode 100644 linux-user/nios2/cpu_loop.c
 create mode 100644 linux-user/nios2/signal.c
 create mode 100644 linux-user/openrisc/cpu_loop.c
 create mode 100644 linux-user/openrisc/signal.c
 create mode 100644 linux-user/ppc/cpu_loop.c
 create mode 100644 linux-user/ppc/signal.c
 create mode 100644 linux-user/riscv/cpu_loop.c
 create mode 100644 linux-user/riscv/signal.c
 create mode 100644 linux-user/s390x/cpu_loop.c
 create mode 100644 linux-user/s390x/signal.c
 create mode 100644 linux-user/sh4/cpu_loop.c
 create mode 100644 linux-user/sh4/signal.c
 create mode 100644 linux-user/signal-common.h
 create mode 100644 linux-user/sparc/cpu_loop.c
 create mode 100644 linux-user/sparc/signal.c
 create mode 100644 linux-user/sparc64/cpu_loop.c
 create mode 100644 linux-user/sparc64/signal.c
 create mode 100644 linux-user/tilegx/cpu_loop.c
 create mode 100644 linux-user/tilegx/signal.c
 create mode 100644 linux-user/x86_64/cpu_loop.c
 create mode 100644 linux-user/x86_64/signal.c
 create mode 100644 linux-user/xtensa/cpu_loop.c
 create mode 100644 linux-user/xtensa/signal.c

-- 
2.14.3
