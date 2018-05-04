Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanL-0006ti-EY
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanI-0003AT-8s
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 May 2018 08:30:30 -0500
Message-Id: <20180504133034.1328397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] 2.12 post-release NBD fixes, 2018-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-05-04

for you to fetch changes up to acfd8f7a5f92e703d2d046cbe3d510008a697194:

  nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply (2018-05-04 08:23:39 -0500)

Fix various issues with NBD in 2.12, some found by Coverity, and some by
implementation interoperability testing.

And May the Fourth be with you

----------------------------------------------------------------
nbd patches for 2018-05-04

- Vladimir Sementsov-Ogievskiy: 0/2 fix coverity bugs
- Eric Blake: nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
- Eric Blake: nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply

----------------------------------------------------------------
Eric Blake (2):
      nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
      nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply

Vladimir Sementsov-Ogievskiy (2):
      nbd/client: fix nbd_negotiate_simple_meta_context
      migration/block-dirty-bitmap: fix memory leak in dirty_bitmap_load_bits

 block/nbd-client.c             | 10 +++++++---
 migration/block-dirty-bitmap.c |  1 +
 nbd/client.c                   | 18 ++++++++++++------
 3 files changed, 20 insertions(+), 9 deletions(-)

Eric Blake (2):
  nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
  nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply

Vladimir Sementsov-Ogievskiy (2):
  nbd/client: fix nbd_negotiate_simple_meta_context
  migration/block-dirty-bitmap: fix memory leak in
    dirty_bitmap_load_bits

 block/nbd-client.c             | 10 +++++++---
 migration/block-dirty-bitmap.c |  1 +
 nbd/client.c                   | 18 ++++++++++++------
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.14.3
