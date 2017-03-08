Received: from eggs.gnu.org ([2001:4830:134:3::10]:46487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkP-0005gR-LP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkO-0005u8-EM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:41 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  7 Mar 2017 20:54:18 -0600
Message-Id: <20170308025428.1037-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/10] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v6

v5 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03042.html

Since then:
- Rebase to master
- Pull in Dan's patch that splits test 97 for qcow (patch 1)
- Address comments from Kevin (includes creating new patch 2, 6)
- Update patches to reflect that this is now 2.10 material, since it
missed soft freeze and is not fixing a bug

001/10:[down] 'iotests: fix 097 when run with qcow'
002/10:[down] 'iotests: Improve image-clear tests on non-aligned image'
003/10:[0007] [FC] 'qcow2: Assert that cluster operations are aligned'
004/10:[0002] [FC] 'qcow2: Discard/zero clusters by byte count'
005/10:[----] [--] 'blkdebug: Sanity check block layer guarantees'
006/10:[down] 'blkdebug: Refactor error injection'
007/10:[0046] [FC] 'blkdebug: Add pass-through write_zero and discard support'
008/10:[0003] [FC] 'blkdebug: Simplify override logic'
009/10:[0045] [FC] 'blkdebug: Add ability to override unmap geometries'
010/10:[0004] [FC] 'tests: Add coverage for recent block geometry fixes'

Daniel P. Berrange (1):
  iotests: fix 097 when run with qcow

Eric Blake (9):
  iotests: Improve image-clear tests on non-aligned image
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count
  blkdebug: Sanity check block layer guarantees
  blkdebug: Refactor error injection
  blkdebug: Add pass-through write_zero and discard support
  blkdebug: Simplify override logic
  blkdebug: Add ability to override unmap geometries
  tests: Add coverage for recent block geometry fixes

 qapi/block-core.json       |  31 +++++-
 block/qcow2.h              |   9 +-
 block/blkdebug.c           | 264 +++++++++++++++++++++++++++++++++++++--------
 block/qcow2-cluster.c      |  51 +++++----
 block/qcow2-snapshot.c     |   7 +-
 block/qcow2.c              |  21 ++--
 tests/qemu-iotests/097     |  17 +--
 tests/qemu-iotests/097.out | 149 +++----------------------
 tests/qemu-iotests/176     | 127 ++++++++++++++++++++++
 tests/qemu-iotests/176.out | 119 ++++++++++++++++++++
 tests/qemu-iotests/177     | 114 ++++++++++++++++++++
 tests/qemu-iotests/177.out |  49 +++++++++
 tests/qemu-iotests/group   |   2 +
 13 files changed, 724 insertions(+), 236 deletions(-)
 create mode 100755 tests/qemu-iotests/176
 create mode 100644 tests/qemu-iotests/176.out
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out

-- 
2.9.3
