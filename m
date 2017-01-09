Received: from eggs.gnu.org ([2001:4830:134:3::10]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFn-0006h9-KM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFm-0002yS-GV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:22 +0100
Message-Id: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit ffe22bf51065dd33022cf91f77a821d1f11c250d:

  Merge remote-tracking branch 'remotes/gonglei/tags/cryptodev-next-20161224' into staging (2017-01-06 15:18:09 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c1bb86cd8ae67c14f79422b6e544d1e2bf40eeb2:

  block: Rename raw-{posix,win32} to file-*.c (2017-01-09 13:30:53 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Eric Blake (2):
      block: Rename raw_bsd to raw-format.c
      block: Rename raw-{posix,win32} to file-*.c

Kevin Wolf (11):
      coroutine: Introduce qemu_coroutine_enter_if_inactive()
      quorum: Remove s from quorum_aio_get() arguments
      quorum: Implement .bdrv_co_readv/writev
      quorum: Do cleanup in caller coroutine
      quorum: Inline quorum_aio_cb()
      quorum: Avoid bdrv_aio_writev() for rewrites
      quorum: Implement .bdrv_co_preadv/pwritev()
      quorum: Inline quorum_fifo_aio_cb()
      quorum: Clean up quorum_aio_get()
      blkdebug: Implement bdrv_co_preadv/pwritev/flush
      blkverify: Implement bdrv_co_preadv/pwritev/flush

Paolo Bonzini (1):
      qemu-img: fix in-flight count for qemu-img bench

 MAINTAINERS                         |   6 +-
 block/Makefile.objs                 |   6 +-
 block/blkdebug.c                    |  86 ++++----
 block/blkverify.c                   | 201 +++++++++---------
 block/{raw-posix.c => file-posix.c} |   0
 block/{raw-win32.c => file-win32.c} |   0
 block/gluster.c                     |   4 +-
 block/quorum.c                      | 410 +++++++++++++++++++-----------------
 block/{raw_bsd.c => raw-format.c}   |   2 +-
 block/trace-events                  |   4 +-
 configure                           |   2 +-
 include/block/block_int.h           |   2 +-
 include/qemu/coroutine.h            |   6 +
 qemu-img.c                          |  17 +-
 tests/qemu-iotests/071.out          |   8 +-
 util/qemu-coroutine.c               |   7 +
 16 files changed, 392 insertions(+), 369 deletions(-)
 rename block/{raw-posix.c => file-posix.c} (100%)
 rename block/{raw-win32.c => file-win32.c} (100%)
 rename block/{raw_bsd.c => raw-format.c} (99%)
