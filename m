Received: from eggs.gnu.org ([2001:4830:134:3::10]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9a-0003MC-Eh
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9X-00084m-I2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:37863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMJ9X-00082J-6I
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Nov 2018 21:49:25 +0100
Message-Id: <20181112204929.12625-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/4] Linux user for 3.1 patches
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

The following changes since commit b4c0595446cda9252d2c7bc84f3c02f3e591935a:

  docker: use HTTPS git URL for virglrenderer (2018-11-12 11:26:02 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request

for you to fetch changes up to 113a9dd73f6377941e0a4bfd7aea5370728b1c28:

  linux-user: Add support for SO_REUSEPORT (2018-11-12 16:38:26 +0100)

----------------------------------------------------------------
- gdb signal handling fix
- add SO_REUSEPORT
- remove dead-code

----------------------------------------------------------------

Peter Maydell (3):
  linux-user: Remove dead error-checking code
  linux-user: Don't call gdb_handlesig() before queue_signal()
  linux-user: Clean up nios2 main loop signal handling

Yunqiang Su (1):
  linux-user: Add support for SO_REUSEPORT

 linux-user/aarch64/cpu_loop.c    | 13 +++++--------
 linux-user/alpha/cpu_loop.c      | 12 ++++--------
 linux-user/arm/cpu_loop.c        | 16 ++++------------
 linux-user/cris/cpu_loop.c       | 16 ++++------------
 linux-user/hppa/cpu_loop.c       | 11 ++++-------
 linux-user/i386/cpu_loop.c       | 16 ++++------------
 linux-user/m68k/cpu_loop.c       | 16 ++++------------
 linux-user/m68k/signal.c         |  3 ---
 linux-user/microblaze/cpu_loop.c | 16 ++++------------
 linux-user/mips/cpu_loop.c       | 16 ++++------------
 linux-user/nios2/cpu_loop.c      | 17 ++++++-----------
 linux-user/openrisc/cpu_loop.c   | 11 ++++-------
 linux-user/ppc/cpu_loop.c        | 15 +++++----------
 linux-user/riscv/cpu_loop.c      |  2 +-
 linux-user/s390x/cpu_loop.c      |  9 +++------
 linux-user/sh4/cpu_loop.c        | 17 ++++-------------
 linux-user/sh4/signal.c          |  4 ----
 linux-user/sparc/cpu_loop.c      | 16 ++++------------
 linux-user/sparc/signal.c        |  2 --
 linux-user/strace.c              |  3 +++
 linux-user/syscall.c             | 10 ++++++++++
 linux-user/xtensa/cpu_loop.c     | 11 ++++-------
 22 files changed, 81 insertions(+), 171 deletions(-)

-- 
2.17.2
