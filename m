Received: from eggs.gnu.org ([2001:4830:134:3::10]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen51-00036g-Pm
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fen4w-00064n-Ut
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fen4w-000610-Kd
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:53:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 15 Jul 2018 21:52:38 +0200
Message-Id: <20180715195242.6645-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/4] Linux user for 3.0 patches
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

The following changes since commit 9277d81f5c2c6f4d0b5e47c8476eb7ee7e5c0beb:

  docs: Grammar and spelling fixes (2018-07-13 10:16:04 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to 1d3d1b23e1c8f52ec431ddaa8deea1322bc25cbf:

  Zero out the host's `msg_control` buffer (2018-07-15 16:04:38 +0200)

----------------------------------------------------------------
Some fixes for linux-user:
- workaround for CMSG_NXTHDR bug
- two patches for ppc64/ppc64le host:
  fix fcntl() with *LK64 commands
  (seen when dpkg wants to lock the DB)
  fix reserved_va alignment (ppc64 needs
  a 64kB alignment)
- convert a forgotten fcntl() to safe_fcntl()

----------------------------------------------------------------

Jonas Schievink (1):
  Zero out the host's `msg_control` buffer

Laurent Vivier (2):
  linux-user: convert remaining fcntl() to safe_fcntl()
  linux-user: fix mmap_find_vma_reserved()

Shivaprasad G Bhat (1):
  linux-user: ppc64: use the correct values for F_*LK64s

 linux-user/main.c    |  19 ++++---
 linux-user/syscall.c | 130 +++++++++++++++++++++++++++----------------
 2 files changed, 95 insertions(+), 54 deletions(-)

-- 
2.17.1
