Received: from eggs.gnu.org ([2001:4830:134:3::10]:39303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijF-0000ub-MT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijE-0005HJ-BX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Feb 2017 13:25:18 -0600
Message-Id: <20170214192525.18624-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/7] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v5

v4 was:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg02834.html

Since then:
- Rebase to master
- Address comments from Max

001/7:[----] [--] 'qcow2: Assert that cluster operations are aligned'
002/7:[0035] [FC] 'qcow2: Discard/zero clusters by byte count'
003/7:[----] [--] 'blkdebug: Sanity check block layer guarantees'
004/7:[0002] [FC] 'blkdebug: Add pass-through write_zero and discard support'
005/7:[----] [--] 'blkdebug: Simplify override logic'
006/7:[0005] [FC] 'blkdebug: Add ability to override unmap geometries'
007/7:[0006] [FC] 'tests: Add coverage for recent block geometry fixes'

Eric Blake (7):
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count
  blkdebug: Sanity check block layer guarantees
  blkdebug: Add pass-through write_zero and discard support
  blkdebug: Simplify override logic
  blkdebug: Add ability to override unmap geometries
  tests: Add coverage for recent block geometry fixes

 qapi/block-core.json       |  25 +++++-
 block/qcow2.h              |   9 +-
 block/blkdebug.c           | 204 +++++++++++++++++++++++++++++++++++++++++++--
 block/qcow2-cluster.c      |  50 ++++++-----
 block/qcow2-snapshot.c     |   7 +-
 block/qcow2.c              |  21 ++---
 tests/qemu-iotests/175     | 114 +++++++++++++++++++++++++
 tests/qemu-iotests/175.out |  49 +++++++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 427 insertions(+), 53 deletions(-)
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

-- 
2.9.3
