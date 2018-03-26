Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbe-0003Cn-Ck
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xba-0001Lr-9Y
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:34 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:44 +0200
Message-Id: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 00/19] linux-user: move arch specific
 parts from main.c to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

This series moves from main.c the architecture specific parts
to the architecture directory.

This is the continuation of my series
  "linux-user: move arch specific parts to arch directories"
that includes since the v2 only the signal.c parts.

For each architecture, there are two parts:

  - cpu_loop(), and the function with its
    dependencies is moved to <arch>/cpu_loop.c

  - the prologue of the cpu_loop(), that was inlined
    in main(). We move it to a new function in
    <arch>/cpu_loop.c, target_cpu_copy_regs().

The first patch adds the skeleton to move the
parts to the architecture directories, a cpu_loop.c
file with an empty target_cpu_copy_regs() function,
called from main().

There is no change in the code.

Based-on: <20180323225739.17329-1-laurent@vivier.eu>
"[PATCH for 2.13 v2 00/20] linux-user: move arch specific parts to arch directories"

Laurent Vivier (19):
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

 linux-user/Makefile.objs         |    3 +-
 linux-user/aarch64/cpu_loop.c    |  182 ++
 linux-user/alpha/cpu_loop.c      |  225 ++
 linux-user/arm/cpu_loop.c        |  456 ++++
 linux-user/cpu_loop-common.h     |   37 +
 linux-user/cris/cpu_loop.c       |  115 +
 linux-user/hppa/cpu_loop.c       |  211 ++
 linux-user/i386/cpu_loop.c       |  369 ++++
 linux-user/m68k/cpu_loop.c       |  170 ++
 linux-user/main.c                | 4439 +-------------------------------------
 linux-user/microblaze/cpu_loop.c |  176 ++
 linux-user/mips/cpu_loop.c       |  749 +++++++
 linux-user/mips64/cpu_loop.c     |   20 +
 linux-user/nios2/cpu_loop.c      |  152 ++
 linux-user/openrisc/cpu_loop.c   |  115 +
 linux-user/ppc/cpu_loop.c        |  579 +++++
 linux-user/riscv/cpu_loop.c      |  118 +
 linux-user/s390x/cpu_loop.c      |  165 ++
 linux-user/sh4/cpu_loop.c        |  111 +
 linux-user/sparc/cpu_loop.c      |  306 +++
 linux-user/sparc64/cpu_loop.c    |   20 +
 linux-user/tilegx/cpu_loop.c     |  286 +++
 linux-user/x86_64/cpu_loop.c     |   20 +
 linux-user/xtensa/cpu_loop.c     |  264 +++
 24 files changed, 4904 insertions(+), 4384 deletions(-)
 create mode 100644 linux-user/aarch64/cpu_loop.c
 create mode 100644 linux-user/alpha/cpu_loop.c
 create mode 100644 linux-user/arm/cpu_loop.c
 create mode 100644 linux-user/cpu_loop-common.h
 create mode 100644 linux-user/cris/cpu_loop.c
 create mode 100644 linux-user/hppa/cpu_loop.c
 create mode 100644 linux-user/i386/cpu_loop.c
 create mode 100644 linux-user/m68k/cpu_loop.c
 create mode 100644 linux-user/microblaze/cpu_loop.c
 create mode 100644 linux-user/mips/cpu_loop.c
 create mode 100644 linux-user/mips64/cpu_loop.c
 create mode 100644 linux-user/nios2/cpu_loop.c
 create mode 100644 linux-user/openrisc/cpu_loop.c
 create mode 100644 linux-user/ppc/cpu_loop.c
 create mode 100644 linux-user/riscv/cpu_loop.c
 create mode 100644 linux-user/s390x/cpu_loop.c
 create mode 100644 linux-user/sh4/cpu_loop.c
 create mode 100644 linux-user/sparc/cpu_loop.c
 create mode 100644 linux-user/sparc64/cpu_loop.c
 create mode 100644 linux-user/tilegx/cpu_loop.c
 create mode 100644 linux-user/x86_64/cpu_loop.c
 create mode 100644 linux-user/xtensa/cpu_loop.c

-- 
2.14.3
