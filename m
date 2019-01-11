Received: from eggs.gnu.org ([209.51.188.92]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mM-0006Pd-UV
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mL-0004xv-Uq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:42 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 13:47:12 -0600
Message-Id: <20190111194720.15671-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] Promote x-nbd-server-add-bitmap to
 stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

Or rather, move its functionality into nbd-server-add.  And as
a side effect, teach qemu-nbd how to export a persistent bitmap
without having to go through a qemu process and several QMP
commands.

Based-on: <20181221093529.23855-1-jsnow@redhat.com>
[jsnow: 0/11 bitmaps: remove x- prefix from QMP api]
Based-on: <20190111163519.11457-1-philmd@redhat.com>
[philmd: qemu-nbd: Rename 'exp' variable clashing with math::exp() symbol=
]

Available at: https://repo.or.cz/qemu/ericb.git nbd-bitmap-add-v3

Since v2:
- split old patch 1 into 3 parts
- add even more tests of expected error messages
- rebase on top of 'exp' rename
- improve commit messages
- add some R-b where it made sense

001/8:[down] 'nbd: Add some error case testing to iotests 223'
002/8:[down] 'nbd: Forbid nbd-server-stop when server is not running'
003/8:[0011] [FC] 'nbd: Only require disabled bitmap for read-only export=
s'
004/8:[0020] [FC] 'nbd: Merge nbd_export_set_name into nbd_export_new'
005/8:[0008] [FC] 'nbd: Allow bitmap export during QMP nbd-server-add'
006/8:[----] [--] 'nbd: Remove x-nbd-server-add-bitmap'
007/8:[0009] [FC] 'nbd: Merge nbd_export_bitmap into nbd_export_new'
008/8:[0004] [FC] 'qemu-nbd: Add --bitmap=3DNAME option'

Eric Blake (8):
  nbd: Add some error case testing to iotests 223
  nbd: Forbid nbd-server-stop when server is not running
  nbd: Only require disabled bitmap for read-only exports
  nbd: Merge nbd_export_set_name into nbd_export_new
  nbd: Allow bitmap export during QMP nbd-server-add
  nbd: Remove x-nbd-server-add-bitmap
  nbd: Merge nbd_export_bitmap into nbd_export_new
  qemu-nbd: Add --bitmap=3DNAME option

 qemu-nbd.texi              |   4 ++
 qapi/block.json            |  30 ++------
 include/block/nbd.h        |  12 ++--
 blockdev-nbd.c             |  36 +++-------
 hmp.c                      |   5 +-
 nbd/server.c               | 136 +++++++++++++++++--------------------
 qemu-nbd.c                 |  17 +++--
 tests/qemu-iotests/223     |  50 +++++++++++---
 tests/qemu-iotests/223.out |  23 +++++--
 9 files changed, 160 insertions(+), 153 deletions(-)

--=20
2.20.1
