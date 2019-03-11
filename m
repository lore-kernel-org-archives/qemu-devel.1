Received: from eggs.gnu.org ([209.51.188.92]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1h-0004rC-1D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1g-0005N6-4L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 21:51:43 +0300
Message-Id: <20190311185147.52309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/4] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com

Hi!

This is my counter-propasal on
"[PATCH 0/5] block/qcow2-bitmap: Enable resize with persistent bitmaps" by John.

It does bitmap resize, but don't flush bitmaps during resize, postponing this
controversial thing.

Based-on: https://github.com/jnsnow/qemu bitmaps

John Snow (2):
  block/qcow2-bitmap: Allow resizes with persistent bitmaps
  tests/qemu-iotests: add bitmap resize test 246

Vladimir Sementsov-Ogievskiy (2):
  docs/interop/qcow2: Improve bitmap flag in_use specification
  block/qcow2-bitmap: Don't check size for IN_USE bitmap

 docs/interop/qcow2.txt     |  18 ++-
 block/qcow2.h              |   1 +
 block/qcow2-bitmap.c       |  67 ++++++++-
 block/qcow2.c              |   4 +-
 tests/qemu-iotests/246     | 114 ++++++++++++++
 tests/qemu-iotests/246.out | 295 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 7 files changed, 491 insertions(+), 9 deletions(-)
 create mode 100755 tests/qemu-iotests/246
 create mode 100644 tests/qemu-iotests/246.out

-- 
2.18.0
