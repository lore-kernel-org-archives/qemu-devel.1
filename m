Received: from eggs.gnu.org ([209.51.188.92]:43953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvm-00041W-Tm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvm-0007T2-1y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvl-0007S4-3o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:47 +0100
Message-Id: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/9] Linux user for 4.0 patches
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

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request

for you to fetch changes up to 61b463fbf6cbf21fcd9abb5af765a19b88dbc1ba:

  linux-user: add new netlink types (2019-03-07 11:02:33 +0100)

----------------------------------------------------------------
- Update netlink types to linux v5.0
- fix accept4/getpeername/getsockname/recvfrom/recvmsg/read
- add/fix ELF_PLATFORM ofr aarch64 and arm
- fix "may be used uninitialized" warnings
- Fix breakpoint support in Nios
- Nicer strace output of chroot() syscall

----------------------------------------------------------------

Andreas Schwab (3):
  linux-user: fix recvmsg emulation
  linux-user: fix emulation of accept4/getpeername/getsockname/recvfrom
    syscalls
  linux-user: don't short-circuit read with zero length

Helge Deller (1):
  linux-user: Nicer strace output of chroot() syscall

Laurent Vivier (1):
  linux-user: add new netlink types

Marc-André Lureau (1):
  linux-user: fix "may be used uninitialized" warnings

Richard Henderson (2):
  linux-user: Add ELF_PLATFORM for arm
  linux-user: Fix ELF_PLATFORM for aarch64_be-linux-user

Sandra Loosemore (1):
  Fix breakpoint support in Nios II user-mode emulation.

 linux-user/elfload.c        | 37 +++++++++++++++++++++++++-
 linux-user/fd-trans.c       |  9 +++++++
 linux-user/nios2/cpu_loop.c |  6 +++++
 linux-user/strace.c         | 12 +++++++++
 linux-user/strace.list      |  2 +-
 linux-user/syscall.c        | 53 +++++++++++++++++++++++--------------
 6 files changed, 97 insertions(+), 22 deletions(-)

-- 
2.20.1
