Received: from eggs.gnu.org ([2001:4830:134:3::10]:52900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIvp-000388-BZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faIvl-0004lI-Fh
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:53:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  3 Jul 2018 13:53:03 +0300
Message-Id: <20180703105305.45398-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] transaction support for bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This is a last brick, necessary to play with nbd bitmap export in
conjunction with image fleecing.

Vladimir Sementsov-Ogievskiy (2):
  drity-bitmap: refactor merge: separte can_merge
  qapi: add transaction support for x-block-dirty-bitmap-merge

 qapi/transaction.json        |  2 ++
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       |  8 ++++++
 block/dirty-bitmap.c         | 32 ++++++++++++++++++----
 blockdev.c                   | 63 ++++++++++++++++++++++++++++++++++++--------
 util/hbitmap.c               |  6 ++++-
 6 files changed, 97 insertions(+), 17 deletions(-)

-- 
2.11.1
