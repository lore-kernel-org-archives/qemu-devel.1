Received: from eggs.gnu.org ([2001:4830:134:3::10]:59368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGmnp-0003f1-4b
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGmnl-0004dw-BH
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:12:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 20 Nov 2017 15:11:39 +0100
Message-Id: <20171120141141.24626-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/2] Fix 'qemu-img info' on mirror
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

There is no reason to forbid 'qemu-img info' for an image that is used
as a mirror target (or intermediate image of a commit job) at the same
time.

This fixes the problem reported on qemu-discuss:
https://lists.gnu.org/archive/html/qemu-discuss/2017-11/msg00039.html

Kevin Wolf (2):
  block: Don't use BLK_PERM_CONSISTENT_READ for format probing
  block: Don't request I/O permission with BDRV_O_NO_IO

 block.c               |  5 ++++-
 block/block-backend.c | 10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.13.6
