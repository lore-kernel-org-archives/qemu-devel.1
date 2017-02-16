Received: from eggs.gnu.org ([2001:4830:134:3::10]:53781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCl-0000hp-BS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCh-0002ME-Qa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:43 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCh-0002LY-DG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:02 +0100
Message-Id: <20170216143816.2384-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/14] Linux user for upstream patches
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

The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:

  Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-upstream-pull-request

for you to fetch changes up to 21992cb6794a5f8edb0cee01bdfe0b03d0438dac:

  linux-user: Add FICLONE and FICLONERANGE ioctls (2017-02-16 15:29:30 +0100)

----------------------------------------------------------------
To help Riku in his maintainer role of linux-user, I've proposed
to help him to manage this pull request.

This series is based on his branch linux-user-for-upstream at:

    https://git.linaro.org/people/riku.voipio/qemu.git

I have added some reviewed patches from the mailing list since
the last pull request.

I have tested this series by creating some containers:

ppc64   fedora-21
ppc     debian-8
aarch64 centos-7.2

All these containers can boot and run as expected
(create an user, log in as this user, install packages with yum/dnf/apt-get
using sudo)

I have tested the LTP-20170116 in the ppc container (big-endian 32bit)
on an x86_64 host (little-endian 64bit). The result is: 

Total Tests: 1111
Total Skipped Tests: 174
Total Failures: 68
Kernel Version: 4.9.5-200.fc25.x86_64
Machine Architecture: ppc
Hostname: debian-8-ppc

v2:
    Fix John Paul Adrian Glaubitz author name
----------------------------------------------------------------

Helge Deller (1):
  linux-user: Add FICLONE and FICLONERANGE ioctls

John Paul Adrian Glaubitz (2):
  linux-user: Update sh4 syscall definitions to match Linux 4.8
  linux-user: Update m68k syscall definitions to match Linux 4.6

Jose Ricardo Ziviani (1):
  linux-user: fill target sigcontext struct accordingly

Laurent Vivier (1):
  linux-user: manage two new IFLA host message types

Lena Djokic (3):
  linux-user: Fix inotify_init1 support
  linux-user: Fix readahead
  linux-user: Fix mq_open

Marc-André Lureau (2):
  linux-user: fix settime old value location
  linux-user: fix tcg/mmap test

Peter Maydell (1):
  linux-user: Use correct types in load_symbols()

Richard Henderson (1):
  linux-user: Fix s390x safe-syscall for z900

Riku Voipio (2):
  linux-user: remove ifdef __USER_MISC
  linux-user: drop __cygwin__ ifdef

 linux-user/elfload.c                     | 22 +++++++++++++++-------
 linux-user/host/s390x/safe-syscall.inc.S |  2 +-
 linux-user/ioctls.h                      |  5 +++++
 linux-user/m68k/syscall_nr.h             |  3 +++
 linux-user/mmap.c                        |  9 +++------
 linux-user/sh4/syscall_nr.h              | 14 ++++++++++++++
 linux-user/signal.c                      |  5 +++++
 linux-user/strace.c                      |  2 --
 linux-user/syscall.c                     | 26 +++++++++++++++++++-------
 linux-user/syscall_defs.h                |  4 ++++
 linux-user/syscall_types.h               |  6 ++++++
 11 files changed, 75 insertions(+), 23 deletions(-)

-- 
2.9.3
