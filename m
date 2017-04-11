Received: from eggs.gnu.org ([2001:4830:134:3::10]:39075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusd-0003zf-8S
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusa-0003jn-5q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusZ-0003ib-Vr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:21 +0800
Message-Id: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Block patches for 2.9-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

The following changes since commit 17fa24b79ceaa8258e415822cf2e2cb23cf3facb:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170411-1' into staging (2017-04-11 10:03:51 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/block-pull-request

for you to fetch changes up to 76296dff97864ebb15fa65cc56a6f890ee0c5a28:

  sheepdog: Use bdrv_coroutine_enter before BDRV_POLL_WHILE (2017-04-11 20:07:15 +0800)

----------------------------------------------------------------

This fixes the known issue 'snapshot_blkdev is broken when using iothreads'.

----------------------------------------------------------------

Fam Zheng (11):
  block: Make bdrv_parent_drained_begin/end public
  block: Quiesce old aio context during bdrv_set_aio_context
  tests/block-job-txn: Don't start block job before adding to txn
  coroutine: Extract qemu_aio_coroutine_enter
  async: Introduce aio_co_enter
  block: Introduce bdrv_coroutine_enter
  blockjob: Use bdrv_coroutine_enter to start coroutine
  qemu-io-cmds: Use bdrv_coroutine_enter
  block: Use bdrv_coroutine_enter to start I/O coroutines
  block: Fix bdrv_co_flush early return
  sheepdog: Use bdrv_coroutine_enter before BDRV_POLL_WHILE

 block.c                    | 12 ++++++++++--
 block/block-backend.c      |  4 ++--
 block/io.c                 | 34 ++++++++++++++++++----------------
 block/sheepdog.c           |  2 +-
 blockjob.c                 |  4 ++--
 include/block/aio.h        |  9 +++++++++
 include/block/block.h      | 21 +++++++++++++++++++++
 include/qemu/coroutine.h   |  5 +++++
 qemu-io-cmds.c             |  2 +-
 tests/qemu-iotests/109.out | 10 +++++-----
 tests/test-blockjob-txn.c  |  6 +++++-
 util/async.c               |  7 ++++++-
 util/qemu-coroutine.c      | 11 ++++++++---
 util/trace-events          |  2 +-
 14 files changed, 94 insertions(+), 35 deletions(-)

-- 
2.9.3
