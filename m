Received: from eggs.gnu.org ([2001:4830:134:3::10]:44023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhaOW-00051M-Iu
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhaOT-0007eu-Hw
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fhaOT-0007eb-8G
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:56:53 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 23 Jul 2018 14:56:22 +0200
Message-Id: <20180723125624.18863-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] Linux user for 3.0 patches
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

The following changes since commit 5b3ecd3d941a0ae8a8cfbba5ab8139b2bf104822:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180719' into staging (2018-07-20 11:08:33 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to fa97e38eed3bbdbc322d94092ca49450e724fff1:

  linux-user/ppc: Implement swapcontext syscall (2018-07-22 21:33:45 +0200)

----------------------------------------------------------------
Some ppc/ppc64 fixes:
- we can run now most of the targets on a ppc64 host with 64kB pages
- add swapcontext syscall to run tests/test-coroutine in
  debian-powerpc-user-cross

----------------------------------------------------------------

Laurent Vivier (1):
  linux-user: fix ELF load alignment error

Richard Henderson (1):
  linux-user/ppc: Implement swapcontext syscall

 linux-user/elfload.c    | 10 +++++++-
 linux-user/ppc/signal.c | 56 +++++++++++++++++++++++++++++++++++++++++
 linux-user/qemu.h       |  3 +++
 linux-user/syscall.c    |  6 +++++
 4 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.17.1
