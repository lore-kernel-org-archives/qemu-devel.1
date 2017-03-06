Received: from eggs.gnu.org ([2001:4830:134:3::10]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP1-0002RA-EY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP0-00017e-KA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:27 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:21:52 +0100
Message-Id: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 00/10] block: Op blocker fixes
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

This series fixes a few problems introduced recently with the op blocker
series. It includes mainly fix for cases where qemu would abort()
instead of doing proper error handling previously. These changes also
happen to result in more complete and correct permission checking.

Kevin Wolf (10):
  commit: Fix error handling
  mirror: Fix permission problem with 'replaces'
  mirror: Fix permissions for removing mirror_top_bs
  mirror: Fix error path for dirty bitmap creation
  block: Fix blockdev-snapshot error handling
  block: Factor out should_update_child()
  block: Factor out bdrv_replace_child_noperm()
  block: Ignore multiple children in bdrv_check_update_perm()
  block: Handle permission errors in change_parent_backing_link()
  block: Fix error handling in bdrv_replace_in_backing_chain()

 block.c                   | 182 ++++++++++++++++++++++++++++++----------------
 block/commit.c            |   2 +-
 block/mirror.c            |  35 +++++----
 blockdev.c                |   6 +-
 include/block/block.h     |   4 +-
 include/block/block_int.h |   6 +-
 6 files changed, 152 insertions(+), 83 deletions(-)

-- 
1.8.3.1
