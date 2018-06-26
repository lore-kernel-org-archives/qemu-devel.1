Received: from eggs.gnu.org ([2001:4830:134:3::10]:34536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoNh-0004lg-1o
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoNd-0006oS-SK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:51:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 26 Jun 2018 16:50:29 +0300
Message-Id: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

To continue talk about correct loading of persistent bitmaps here is
a patch (04), with some surrounding.

Patch 04 contains new (and I hope, more clean) logic of bitmaps
loading/inactivation/invalidation/migration, with the whole description.
Let me not duplicate it here, you can safely start reading from 04
commit message and internal big comment.

Vladimir Sementsov-Ogievskiy (6):
  iotests: 169: drop deprecated 'autoload' parameter
  block/qcow2: improve error message in qcow2_inactivate
  bloc/qcow2: drop dirty_bitmaps_loaded state variable
  dirty-bitmaps: clean-up bitmaps loading and migration logic
  iotests: improve 169
  iotests: 169: add cases for source vm resuming

 block/qcow2.h                  |  1 -
 include/block/dirty-bitmap.h   |  2 +-
 block.c                        | 11 ++++--
 block/dirty-bitmap.c           | 36 +++++++-----------
 block/qcow2-bitmap.c           | 16 ++++++++
 block/qcow2.c                  | 86 ++++++++++++++++++++++++++++++++----------
 migration/block-dirty-bitmap.c | 10 ++++-
 tests/qemu-iotests/169         | 70 +++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out     |  4 +-
 9 files changed, 182 insertions(+), 54 deletions(-)

-- 
2.11.1
