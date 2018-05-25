Received: from eggs.gnu.org ([2001:4830:134:3::10]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7ve-0001md-Pr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vb-0008Ir-Bt
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:26 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vb-0008IH-2E
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:41 +0200
Message-Id: <20180525081754.29506-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/13] Linux user for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 62b9b076d9d37117696ec64f0b3544c1205ff7f9:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180524-pull-request' into staging (2018-05-24 17:48:01 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request

for you to fetch changes up to 4f71086665360eb15cb0cc3392bd5063f26ee934:

  gdbstub: Clarify what gdb_handlesig() is doing (2018-05-25 10:10:55 +0200)

----------------------------------------------------------------
This pull request includes:
- fixes for some comments
- netlink update and fix
- rework/cleanup fo socket.h,
  including fixes for SPARC part.

----------------------------------------------------------------

Igor Mammedov (1):
  linux-user: update comments to point to tcg_exec_init()

Laurent Vivier (9):
  linux-user: update netlink emulation
  linux-user: move mips socket.h definitions to mips/sockbits.h
  linux-user: move alpha socket.h definitions to alpha/sockbits.h
  linux-user: move sparc/sparc64 socket.h definitions to
    sparc/sockbits.h
  linux-user: move socket.h generic definitions to generic/sockbits.h
  linux-user: move ppc socket.h definitions to ppc/sockbits.h
  linux-user: update ARCH_HAS_SOCKET_TYPES use
  linux-user: copy sparc/sockbits.h definitions from linux
  linux-user: define TARGET_SO_REUSEPORT

Peter Maydell (3):
  linux-user: Assert on bad type in thunk_type_align() and
    thunk_type_size()
  linux-user: Fix payload size logic in host_to_target_cmsg()
  gdbstub: Clarify what gdb_handlesig() is doing

 bsd-user/main.c                  |   7 +-
 gdbstub.c                        |   6 +
 include/exec/gdbstub.h           |  15 ++
 include/exec/user/thunk.h        |   4 +-
 linux-user/aarch64/sockbits.h    |   1 +
 linux-user/alpha/sockbits.h      |  83 +++++++++
 linux-user/arm/sockbits.h        |   1 +
 linux-user/cris/sockbits.h       |   1 +
 linux-user/generic/sockbits.h    |  58 ++++++
 linux-user/hppa/sockbits.h       |  33 +---
 linux-user/i386/sockbits.h       |   1 +
 linux-user/m68k/sockbits.h       |   1 +
 linux-user/main.c                |   5 +-
 linux-user/microblaze/sockbits.h |   1 +
 linux-user/mips/sockbits.h       | 110 ++++++++++++
 linux-user/mips64/sockbits.h     |   1 +
 linux-user/nios2/sockbits.h      |   1 +
 linux-user/openrisc/sockbits.h   |   1 +
 linux-user/ppc/sockbits.h        |  26 +++
 linux-user/riscv/sockbits.h      |   1 +
 linux-user/s390x/sockbits.h      |   1 +
 linux-user/sh4/sockbits.h        |   1 +
 linux-user/socket.h              | 377 ++++-----------------------------------
 linux-user/sparc/sockbits.h      | 111 ++++++++++++
 linux-user/sparc64/sockbits.h    |   1 +
 linux-user/syscall.c             |  61 ++++++-
 linux-user/tilegx/sockbits.h     |   1 +
 linux-user/x86_64/sockbits.h     |   1 +
 linux-user/xtensa/sockbits.h     |   1 +
 29 files changed, 532 insertions(+), 380 deletions(-)
 create mode 100644 linux-user/aarch64/sockbits.h
 create mode 100644 linux-user/alpha/sockbits.h
 create mode 100644 linux-user/arm/sockbits.h
 create mode 100644 linux-user/cris/sockbits.h
 create mode 100644 linux-user/generic/sockbits.h
 create mode 100644 linux-user/i386/sockbits.h
 create mode 100644 linux-user/m68k/sockbits.h
 create mode 100644 linux-user/microblaze/sockbits.h
 create mode 100644 linux-user/mips/sockbits.h
 create mode 100644 linux-user/mips64/sockbits.h
 create mode 100644 linux-user/nios2/sockbits.h
 create mode 100644 linux-user/openrisc/sockbits.h
 create mode 100644 linux-user/ppc/sockbits.h
 create mode 100644 linux-user/riscv/sockbits.h
 create mode 100644 linux-user/s390x/sockbits.h
 create mode 100644 linux-user/sh4/sockbits.h
 create mode 100644 linux-user/sparc/sockbits.h
 create mode 100644 linux-user/sparc64/sockbits.h
 create mode 100644 linux-user/tilegx/sockbits.h
 create mode 100644 linux-user/x86_64/sockbits.h
 create mode 100644 linux-user/xtensa/sockbits.h

-- 
2.14.3
