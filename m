Received: from eggs.gnu.org ([209.51.188.92]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz2-0004J1-MC
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIuz1-0004x9-ML
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:57:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 15:57:03 +0300
Message-Id: <20190423125706.26989-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/3] Fix overflow bug in qcow2 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, eblake@redhat.com

v5: by Kevin's comments
02: add check for invalid @bytes parameter, drop r-b
03: move from qemu-img info to qemu-img map -f raw, drop r-b and t-b

Vladimir Sementsov-Ogievskiy (3):
  block/qcow2-refcount: add trace-point to qcow2_process_discards
  block/io: bdrv_pdiscard: support int64_t bytes parameter
  iotests: test big qcow2 shrink

 include/block/block.h      |  4 +--
 block/io.c                 | 16 ++++-----
 block/qcow2-refcount.c     |  7 +++-
 block/trace-events         |  3 ++
 tests/qemu-iotests/250     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 23 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 7 files changed, 116 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

-- 
2.18.0
