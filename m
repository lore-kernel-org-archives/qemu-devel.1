Received: from eggs.gnu.org ([2001:4830:134:3::10]:43926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnP2-0005Wx-6u
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGnP1-000596-34
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:50:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 20 Nov 2017 15:50:03 +0100
Message-Id: <20171120145006.551-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/3] block: Error out on load_vm with
 active dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

Following the discussing at
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03572.html
this implements the error return for loading a snapshot while dirty
bitmaps are active.

Kevin Wolf (3):
  block: Add errp to bdrv_snapshot_goto()
  block: Add errp to bdrv_all_goto_snapshot()
  block: Error out on load_vm with active dirty bitmaps

 include/block/snapshot.h |  6 ++++--
 block/snapshot.c         | 43 +++++++++++++++++++++++--------------------
 migration/savevm.c       |  6 +++---
 qemu-img.c               |  6 +++---
 4 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.13.6
