Received: from eggs.gnu.org ([2001:4830:134:3::10]:33998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4c-0000X3-0g
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chi4Z-0007oM-Aw
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 14:32:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 22:31:51 +0300
Message-Id: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/4] some migration bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Hi all!

Here are some migration related bugs, two about INACTIVE bdses and one
use-after-free.

I'm absolutely not sure, that these bugs should be fixed like I'm fixing,
but problem definitely exists.

Reset in stopped state is strange case, may be such usage should be
restricted.
About INACTIVE - looks like it should be a separate run-state, not only
bdrv-flag.
Situation with migration state, which is global, but is set/reset/changed
in not controlled manner is not very good too..

Vladimir Sementsov-Ogievskiy (4):
  iotests: add migration corner cases test
  qmp-cont: invalidate on RUN_STATE_PRELAUNCH
  savevm: fix savevm after migration
  migration: fix use-after-free of to_dst_file

 block/snapshot.c           |  3 +-
 migration/savevm.c         | 16 +++++++++++
 qmp.c                      |  3 +-
 tests/qemu-iotests/175     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

-- 
2.11.1
