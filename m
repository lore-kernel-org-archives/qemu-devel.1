Received: from eggs.gnu.org ([2001:4830:134:3::10]:51065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxR-0001oG-T2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxN-0000w1-2y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:38 +0300
Message-Id: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/9] nbd block status base:allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

Here is minimal realization of base:allocation context of NBD
block-status extension, which allows to get block status through
NBD.

Vladimir Sementsov-Ogievskiy (9):
  nbd/server: add nbd_opt_invalid helper
  nbd: change indenting in nbd.h
  nbd: BLOCK_STATUS for standard get_block_status function: server part
  block/nbd-client: save first fatal error in nbd_iter_error
  nbd/client: fix error messages in nbd_handle_reply_err
  nbd: BLOCK_STATUS for standard get_block_status function: client part
  iotests.py: tiny refactor: move system imports up
  iotests: add file_path helper
  iotests: new test 206 for NBD BLOCK_STATUS

 block/nbd-client.h            |   5 +
 include/block/nbd.h           |  58 +++++--
 block/nbd-client.c            | 143 ++++++++++++++++-
 block/nbd.c                   |   3 +
 nbd/client.c                  | 128 ++++++++++++++-
 nbd/common.c                  |  10 ++
 nbd/server.c                  | 360 ++++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/140.out    |   2 +-
 tests/qemu-iotests/143.out    |   2 +-
 tests/qemu-iotests/205        |   3 +-
 tests/qemu-iotests/206        |  34 ++++
 tests/qemu-iotests/206.out    |   2 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  37 ++++-
 14 files changed, 749 insertions(+), 39 deletions(-)
 create mode 100644 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out

-- 
2.11.1
