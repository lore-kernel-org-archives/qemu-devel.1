Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAy-0001NR-PZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001eV-Lc
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:03 -0400
Message-Id: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] qemu-img: add bitmap info output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Allow qemu-img to show information about bitmaps stored in qcow2 images.

v2:
- Remove bitmap manipulation command in favor of a part 2 series later
- Responded to much of Vladimir's feedback (Thank you!);
  - In particular, make sure IN_USE bitmaps cannot be remounted RW.
  - Fixed semantics of the extra_data flag

John Snow (10):
  qcow2/bitmap: remove redundant arguments from bitmap_list_load
  qcow2/bitmap: avoid adjusting bm->flags for RO bitmaps
  qcow2/bitmap: cache bm_list
  qcow2/bitmap: cache loaded bitmaps
  qcow2/bitmap: reject IN_USE bitmaps on rw reload
  qcow2/bitmap: load IN_USE bitmaps if disk is RO
  qcow2/bitmap: track bitmap type
  qcow2/bitmap: track extra_data_size
  qapi: add bitmap info
  qcow2/bitmap: add basic bitmaps info

 block/qcow2-bitmap.c | 276 ++++++++++++++++++++++++++++++++++-----------------
 block/qcow2.c        |   9 ++
 block/qcow2.h        |   3 +
 qapi/block-core.json |  64 +++++++++++-
 4 files changed, 260 insertions(+), 92 deletions(-)

-- 
2.14.3
