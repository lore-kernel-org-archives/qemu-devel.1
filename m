Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo42k-0003ro-4l
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo42g-0005h6-St
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:58 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eo42g-0005fF-II
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:54 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Feb 2018 10:16:36 +0100
Message-Id: <20180220091640.10875-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] Linux user for 2.12 patches
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

The following changes since commit f0fa81767555fe2c4b5f8c9e0725a80eac1d7f56:

  cuda.h: Fix multiple typedef (2018-02-16 18:38:21 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to b44316fb3610972e40849ec5710aeb42dfeba19d:

  linux-user: Remove THREAD macro (2018-02-18 18:52:32 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: Implement ioctl cmd TIOCGPTPEER

Guido Günther (1):
  linux-user: Fix register used for 6th and 7th syscall argument on
    aarch64

Peter Maydell (1):
  linux-user: Remove THREAD macro

Samuel Thibault (1):
  linux-user: Fix sched_getaffinity mask size

 linux-user/aarch64/termbits.h              |  2 ++
 linux-user/alpha/termbits.h                |  1 +
 linux-user/arm/termbits.h                  |  1 +
 linux-user/cris/termbits.h                 |  1 +
 linux-user/host/aarch64/safe-syscall.inc.S |  6 +++---
 linux-user/hppa/termbits.h                 |  2 ++
 linux-user/i386/termbits.h                 |  1 +
 linux-user/ioctls.h                        |  3 +++
 linux-user/m68k/termbits.h                 |  1 +
 linux-user/main.c                          |  2 +-
 linux-user/microblaze/termbits.h           |  1 +
 linux-user/mips/termbits.h                 |  1 +
 linux-user/nios2/termbits.h                |  2 ++
 linux-user/openrisc/termbits.h             |  2 ++
 linux-user/ppc/termbits.h                  |  1 +
 linux-user/qemu.h                          |  4 +---
 linux-user/s390x/termbits.h                |  1 +
 linux-user/sh4/termbits.h                  |  1 +
 linux-user/sparc/termbits.h                |  1 +
 linux-user/sparc64/termbits.h              |  1 +
 linux-user/syscall.c                       | 13 ++++++++++++-
 linux-user/tilegx/termbits.h               |  1 +
 linux-user/x86_64/termbits.h               |  1 +
 23 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.14.3
