Received: from eggs.gnu.org ([2001:4830:134:3::10]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGY-0000sQ-9w
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGU-0006cS-V9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 12 Mar 2018 18:21:18 +0300
Message-Id: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/8] nbd block status base:allocation
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

v2 changes are in each patch after "---" line.

Vladimir Sementsov-Ogievskiy (8):
  nbd/server: add nbd_opt_invalid helper
  nbd/server: add nbd_read_opt_name helper
  nbd: BLOCK_STATUS for standard get_block_status function: server part
  block/nbd-client: save first fatal error in nbd_iter_error
  nbd: BLOCK_STATUS for standard get_block_status function: client part
  iotests.py: tiny refactor: move system imports up
  iotests: add file_path helper
  iotests: new test 209 for NBD BLOCK_STATUS

 block/nbd-client.h            |   6 +
 include/block/nbd.h           |   5 +
 block/nbd-client.c            | 148 ++++++++++++++-
 block/nbd.c                   |   3 +
 nbd/client.c                  | 117 ++++++++++++
 nbd/server.c                  | 413 +++++++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/209        |  34 ++++
 tests/qemu-iotests/209.out    |   2 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  37 +++-
 10 files changed, 737 insertions(+), 29 deletions(-)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out

-- 
2.11.1
