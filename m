Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1gT-0002xm-5C
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1gS-00070M-Cg
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:54:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 31 Mar 2017 13:53:53 -0500
Message-Id: <20170331185356.2479-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v8 0/3] Fix wipe of unaligned qcow2
 image [was add blkdebug tests]
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
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v8

(which is somewhat of a misnomer for this current version of the
series, but historically correct)

v6 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01562.html
v7 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg06175.html

Since then: reorder patches 2 and 3, and update commit messages to match

001/3:[----] [--] 'iotests: fix 097 when run with qcow'
002/3:[0002] [FC] 'qcow2: Discard unaligned tail when wiping image'
003/3:[0002] [FC] 'iotests: Improve image-clear tests on non-aligned image'

Daniel P. Berrange (1):
  iotests: fix 097 when run with qcow

Eric Blake (2):
  qcow2: Discard unaligned tail when wiping image
  iotests: Improve image-clear tests on non-aligned image

 block/qcow2-cluster.c      |  10 +--
 tests/qemu-iotests/097     |  27 +++----
 tests/qemu-iotests/097.out | 180 ++++++++++++---------------------------------
 tests/qemu-iotests/176     | 131 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/176.out | 150 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 345 insertions(+), 154 deletions(-)
 create mode 100755 tests/qemu-iotests/176
 create mode 100644 tests/qemu-iotests/176.out

-- 
2.9.3
