Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPa-0000HJ-QR
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPZ-0006XI-ST
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  9 Mar 2017 12:38:56 +0100
Message-Id: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] block: More op blocker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (6):
  block: Remove check_new_perm from bdrv_replace_child()
  block: Request block status from *file for BDRV_BLOCK_RAW
  commit: Implement bdrv_commit_top.bdrv_co_get_block_status
  block: Refresh filename after changing backing file
  mirror: Implement .bdrv_refresh_filename
  commit: Implement .bdrv_refresh_filename

 block.c        | 23 ++++++++++++++++-------
 block/commit.c | 28 ++++++++++++++++++++++++----
 block/io.c     |  2 +-
 block/mirror.c |  9 +++++++++
 4 files changed, 50 insertions(+), 12 deletions(-)

-- 
1.8.3.1
