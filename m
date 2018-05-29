Received: from eggs.gnu.org ([2001:4830:134:3::10]:37964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVn-0004Ei-Vl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fNkVk-0000R8-UR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fNkVk-0000PB-L9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:42:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 29 May 2018 21:41:52 +0200
Message-Id: <20180529194207.31503-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 00/15] linux-user: move more definitions out of
 syscall_defs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Move fcntl.h definitions to target directories.
Introduce a generic header for the targets without
specific definitions.
Move more signal.h definitions to target directories.

Laurent Vivier (15):
  linux-user: move generic fcntl definitions to generic/fcntl.h
  linux-user: move alpha fcntl definitions to alpha/target_fcntl.h
  linux-user: move hppa fcntl definitions to hppa/target_fcntl.h
  linux-user: move arm/aarch64/m68k fcntl definitions to
    [arm|aarch64|m68k]/target_fcntl.h
  linux-user: move mips/mips64 fcntl definitions to mips/target_fcntl.h
  linux-user: move ppc fcntl definitions to ppc/target_fcntl.h
  linux-user: move sparc/sparc64 fcntl definitions to
    sparc/target_fcntl.h
  linux-user: move get_sp_from_cpustate() to target_cpu.h
  linux-user: move generic signal definitions to generic/signal.h
  linux-user: move sparc signal definitions to sparc/target_signal.h
  linux-user: move mips signal definitions to mips/target_signal.h
  linux-user: move openrisc signal definitions to
    openrisc/target_signal.h
  linux-user: move alpha signal definitions to alpha/target_signal.h
  linux-user: move hppa signal definitions to hppa/target_signal.h
  linux-user: remove useless #if

 linux-user/aarch64/signal.c           |   1 -
 linux-user/aarch64/target_cpu.h       |   4 +
 linux-user/aarch64/target_fcntl.h     |  16 +
 linux-user/aarch64/target_signal.h    |   7 +-
 linux-user/alpha/signal.c             |   1 -
 linux-user/alpha/target_cpu.h         |   4 +
 linux-user/alpha/target_fcntl.h       |  40 +++
 linux-user/alpha/target_signal.h      |  51 +++-
 linux-user/arm/signal.c               |   1 -
 linux-user/arm/target_cpu.h           |   4 +
 linux-user/arm/target_fcntl.h         |  17 ++
 linux-user/arm/target_signal.h        |   7 +-
 linux-user/cris/signal.c              |   1 -
 linux-user/cris/target_cpu.h          |   4 +
 linux-user/cris/target_fcntl.h        |  11 +
 linux-user/cris/target_signal.h       |   7 +-
 linux-user/generic/fcntl.h            | 151 ++++++++++
 linux-user/generic/signal.h           |  57 ++++
 linux-user/hppa/signal.c              |   1 -
 linux-user/hppa/target_cpu.h          |   8 +-
 linux-user/hppa/target_fcntl.h        |  42 +++
 linux-user/hppa/target_signal.h       |  50 +++-
 linux-user/i386/signal.c              |   1 -
 linux-user/i386/target_cpu.h          |   4 +
 linux-user/i386/target_fcntl.h        |  11 +
 linux-user/i386/target_signal.h       |   7 +-
 linux-user/m68k/signal.c              |   1 -
 linux-user/m68k/target_cpu.h          |   4 +
 linux-user/m68k/target_fcntl.h        |  17 ++
 linux-user/m68k/target_signal.h       |   7 +-
 linux-user/microblaze/signal.c        |   1 -
 linux-user/microblaze/target_cpu.h    |   4 +
 linux-user/microblaze/target_fcntl.h  |  11 +
 linux-user/microblaze/target_signal.h |   7 +-
 linux-user/mips/signal.c              |   1 -
 linux-user/mips/target_cpu.h          |   4 +
 linux-user/mips/target_fcntl.h        |  38 +++
 linux-user/mips/target_signal.h       |  55 +++-
 linux-user/mips64/target_fcntl.h      |   1 +
 linux-user/mips64/target_signal.h     |  53 +++-
 linux-user/nios2/signal.c             |   1 -
 linux-user/nios2/target_cpu.h         |   4 +
 linux-user/nios2/target_fcntl.h       |  11 +
 linux-user/nios2/target_signal.h      |   8 +-
 linux-user/openrisc/signal.c          |   1 -
 linux-user/openrisc/target_cpu.h      |   4 +
 linux-user/openrisc/target_fcntl.h    |  11 +
 linux-user/openrisc/target_signal.h   |  16 +-
 linux-user/ppc/signal.c               |   1 -
 linux-user/ppc/target_cpu.h           |   5 +-
 linux-user/ppc/target_fcntl.h         |  17 ++
 linux-user/ppc/target_signal.h        |   7 +-
 linux-user/qemu.h                     |   1 -
 linux-user/riscv/signal.c             |   1 -
 linux-user/riscv/target_cpu.h         |   4 +
 linux-user/riscv/target_fcntl.h       |  11 +
 linux-user/riscv/target_signal.h      |   8 +-
 linux-user/s390x/signal.c             |   1 -
 linux-user/s390x/target_cpu.h         |   4 +
 linux-user/s390x/target_fcntl.h       |  11 +
 linux-user/s390x/target_signal.h      |   7 +-
 linux-user/sh4/signal.c               |   1 -
 linux-user/sh4/target_cpu.h           |   4 +
 linux-user/sh4/target_fcntl.h         |  11 +
 linux-user/sh4/target_signal.h        |   7 +-
 linux-user/signal.c                   |   1 -
 linux-user/sparc/signal.c             |   1 -
 linux-user/sparc/target_cpu.h         |  11 +
 linux-user/sparc/target_fcntl.h       |  45 +++
 linux-user/sparc/target_signal.h      |  60 +++-
 linux-user/sparc64/signal.c           |   1 -
 linux-user/sparc64/target_fcntl.h     |   1 +
 linux-user/sparc64/target_signal.h    |  38 +--
 linux-user/syscall_defs.h             | 536 +---------------------------------
 linux-user/tilegx/signal.c            |   1 -
 linux-user/tilegx/target_cpu.h        |   4 +
 linux-user/tilegx/target_fcntl.h      |  11 +
 linux-user/tilegx/target_signal.h     |   8 +-
 linux-user/x86_64/target_fcntl.h      |  11 +
 linux-user/x86_64/target_signal.h     |   8 +-
 linux-user/xtensa/signal.c            |   1 -
 linux-user/xtensa/target_cpu.h        |   4 +
 linux-user/xtensa/target_fcntl.h      |  11 +
 linux-user/xtensa/target_signal.h     |   8 +-
 84 files changed, 909 insertions(+), 721 deletions(-)
 create mode 100644 linux-user/aarch64/target_fcntl.h
 create mode 100644 linux-user/alpha/target_fcntl.h
 create mode 100644 linux-user/arm/target_fcntl.h
 create mode 100644 linux-user/cris/target_fcntl.h
 create mode 100644 linux-user/generic/fcntl.h
 create mode 100644 linux-user/generic/signal.h
 create mode 100644 linux-user/hppa/target_fcntl.h
 create mode 100644 linux-user/i386/target_fcntl.h
 create mode 100644 linux-user/m68k/target_fcntl.h
 create mode 100644 linux-user/microblaze/target_fcntl.h
 create mode 100644 linux-user/mips/target_fcntl.h
 create mode 100644 linux-user/mips64/target_fcntl.h
 create mode 100644 linux-user/nios2/target_fcntl.h
 create mode 100644 linux-user/openrisc/target_fcntl.h
 create mode 100644 linux-user/ppc/target_fcntl.h
 create mode 100644 linux-user/riscv/target_fcntl.h
 create mode 100644 linux-user/s390x/target_fcntl.h
 create mode 100644 linux-user/sh4/target_fcntl.h
 create mode 100644 linux-user/sparc/target_fcntl.h
 create mode 100644 linux-user/sparc64/target_fcntl.h
 create mode 100644 linux-user/tilegx/target_fcntl.h
 create mode 100644 linux-user/x86_64/target_fcntl.h
 create mode 100644 linux-user/xtensa/target_fcntl.h

-- 
2.14.3
