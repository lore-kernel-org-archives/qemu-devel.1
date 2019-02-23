Received: from eggs.gnu.org ([209.51.188.92]:34663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL58-00009W-LR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxL57-0004O1-Si
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:22:18 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:22:05 -0500
Message-Id: <20190223002209.23084-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] bitmaps: add inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Allow QEMU to read in bitmaps that have the in-use bit set, for the
purposes of allowing users to delete those bitmaps.

This is chosen in preference to a hard error on load to minimize
impact for a non-critical error, but to force the user or management
utility to acknowledge that the bitmap is no longer viable.

Requires: [PATCH v3 00/10] dirty-bitmaps: deprecate @status field

John Snow (4):
  block/dirty-bitmaps: add inconsistent bit
  block/dirty-bitmap: add inconsistent status
  block/dirty-bitmaps: add block_dirty_bitmap_check function
  block/dirty-bitmaps: implement inconsistent bit

 block/dirty-bitmap.c           | 65 +++++++++++++++++++++++-----
 block/qcow2-bitmap.c           | 77 ++++++++++++++++++----------------
 blockdev.c                     | 49 ++++------------------
 include/block/dirty-bitmap.h   | 15 ++++++-
 migration/block-dirty-bitmap.c | 12 ++----
 nbd/server.c                   |  3 +-
 qapi/block-core.json           | 15 +++++--
 7 files changed, 133 insertions(+), 103 deletions(-)

-- 
2.17.2
