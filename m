Received: from eggs.gnu.org ([2001:4830:134:3::10]:53475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIt-0003UD-Bm
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIo-0003HQ-Je
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:39 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 08:38:18 -0400
Message-Id: <cover.1502109078.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/4] VHDX bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com


Some VHDX bug fixes, including:

1. Checking bdrv_getlength(), bdrv_flush(), and bdrv_truncate() return values

Changes from v1->v2:

git-backport-diff -r qemu/master.. -u vhdx-fixes-v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/4:[0013] [FC] 'block/vhdx: check error return of bdrv_getlength()'
       ^^^^
Some code cleanup / movement (Thanks Kevin)

002/4:[0002] [FC] 'block/vhdx: check for offset overflow to bdrv_truncate()'
       ^^^^
Use QEMU_ALIGN_UP (Thanks Eric)

003/4:[down] 'block/vhdx: check error return of bdrv_flush()'

New, suggested by Kevin.

004/4:[down] 'block/vhdx: check error return of bdrv_truncate()'

New.

1. Check for error when calling bdrv_getlength() [Markus]

2. Check for overflow in offset prior to calling bdrv_truncate().

Jeff Cody (4):
  block/vhdx: check error return of bdrv_getlength()
  block/vhdx: check for offset overflow to bdrv_truncate()
  block/vhdx: check error return of bdrv_flush()
  block/vhdx: check error return of bdrv_truncate()

 block/vhdx-log.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 block/vhdx.c     | 12 +++++++++++-
 2 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.9.4
