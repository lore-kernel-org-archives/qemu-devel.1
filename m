Received: from eggs.gnu.org ([209.51.188.92]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXC-0000Sq-MA
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXB-0001iV-Im
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 01:13:24 -0600
Message-Id: <20190110071330.28136-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] Promote x-nbd-server-add-bitmap to
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

Or rather, move its functionality into nbd-server-add.  And as
a side effect, teach qemu-nbd how to export a persistent bitmap
without having to go through a qemu process and several QMP
commands.

Based-on: <20181221093529.23855-1-jsnow@redhat.com>
[0/11 bitmaps: remove x- prefix from QMP api]

Available at: https://repo.or.cz/qemu/ericb.git nbd-bitmap-add-v2

Since v1:
- add new patch 1 allowing bitmaps with writable exports
- add coverage in iotest 223
- fix logic bug that rendered qemu-nbd -B useless
- drop support for bitmap-export-name remapping

001/6:[down] 'nbd: Only require disabled bitmap for read-only exports'
002/6:[----] [--] 'nbd: Merge nbd_export_set_name into nbd_export_new'
003/6:[0056] [FC] 'nbd: Allow bitmap export during QMP nbd-server-add'
004/6:[----] [--] 'nbd: Remove x-nbd-server-add-bitmap'
005/6:[0042] [FC] 'nbd: Merge nbd_export_bitmap into nbd_export_new'
006/6:[0041] [FC] 'qemu-nbd: Add --bitmap=3DNAME option'

Eric Blake (6):
  nbd: Only require disabled bitmap for read-only exports
  nbd: Merge nbd_export_set_name into nbd_export_new
  nbd: Allow bitmap export during QMP nbd-server-add
  nbd: Remove x-nbd-server-add-bitmap
  nbd: Merge nbd_export_bitmap into nbd_export_new
  qemu-nbd: Add --bitmap=3DNAME option

 qemu-nbd.texi              |   4 ++
 qapi/block.json            |  30 ++-------
 include/block/nbd.h        |  12 ++--
 blockdev-nbd.c             |  31 ++-------
 hmp.c                      |   5 +-
 nbd/server.c               | 129 ++++++++++++++++---------------------
 qemu-nbd.c                 |  15 +++--
 tests/qemu-iotests/223     |  39 ++++++++---
 tests/qemu-iotests/223.out |  19 ++++--
 9 files changed, 132 insertions(+), 152 deletions(-)

--=20
2.20.1
