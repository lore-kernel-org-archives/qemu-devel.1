Received: from eggs.gnu.org ([2001:4830:134:3::10]:40084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7U-0001G5-QD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7R-0006AX-Ef
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 29 Jun 2018 18:15:21 +0300
Message-Id: <20180629151524.138542-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/3] image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Image fleecing, or external (or pull) backup scheme is near to complete.
Here is forgotten test, written by Fam in far 2014, with two my necessary
patches, previously sent separately, so the series are called "v2"

v2:
 01: add transaction support
 02: rebase on master, drop "'fleecing-filter': 'BlockdevCreateNotSupported'"
     add empty .bdrv_close
     add default .bdrv_child_perm
 03: comparing to [PATCH v20 15/15] qemu-iotests: Image fleecing test case 08:
     add -f iotests.imgfmt to qemu_io
     fix target_img to be always qcow2
     add -r to qemu_io for nbd
     add fleecing-filter layer
     wrap long lines

Fam Zheng (1):
  qemu-iotests: Image fleecing test case 222

Vladimir Sementsov-Ogievskiy (2):
  blockdev-backup: enable non-root nodes for backup source
  block/fleecing-filter: new filter driver for fleecing

 qapi/block-core.json       |   6 ++-
 block/fleecing-filter.c    |  80 ++++++++++++++++++++++++++++++++
 blockdev.c                 |   4 +-
 block/Makefile.objs        |   1 +
 tests/qemu-iotests/222     | 112 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 7 files changed, 205 insertions(+), 4 deletions(-)
 create mode 100644 block/fleecing-filter.c
 create mode 100755 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out

-- 
2.11.1
