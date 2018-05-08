Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44e-0000Dw-83
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44Z-0001Sd-CM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:40 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  8 May 2018 17:58:07 +0300
Message-Id: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 0/9] qcow2: cluster space preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

hej,
yet another respin of this series :) now as 2.12 is released

v9: - fixed commentary wording in patches 4, 8
    - rebased (no conflicts)

v8: http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg03291.html

Anton Nefedov (9):
  mirror: inherit supported write/zero flags
  blkverify: set supported write/zero flags
  quorum: set supported write/zero flags
  block: introduce BDRV_REQ_ALLOCATE flag
  block: treat BDRV_REQ_ALLOCATE as serialising
  file-posix: support BDRV_REQ_ALLOCATE
  block: support BDRV_REQ_ALLOCATE in passthrough drivers
  qcow2: skip writing zero buffers to empty COW areas
  iotest 134: test cluster-misaligned encrypted write

 qapi/block-core.json       |  4 ++-
 block/qcow2.h              |  6 ++++
 include/block/block.h      |  8 ++++-
 include/block/block_int.h  |  2 +-
 block/blkdebug.c           |  3 +-
 block/blkverify.c          |  9 ++++++
 block/file-posix.c         | 10 +++++-
 block/io.c                 | 50 +++++++++++++++++++++++------
 block/mirror.c             | 11 +++++++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 80 ++++++++++++++++++++++++++++++++++++++++++++--
 block/quorum.c             | 21 ++++++++++++
 block/raw-format.c         |  3 +-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     | 26 +++++++++------
 tests/qemu-iotests/060.out |  5 ++-
 tests/qemu-iotests/134     |  9 ++++++
 tests/qemu-iotests/134.out | 10 ++++++
 18 files changed, 231 insertions(+), 29 deletions(-)

-- 
2.7.4
