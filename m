Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljEE-0004a5-T3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljED-0000CP-JA
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:34:38 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  8 Mar 2017 15:34:26 -0600
Message-Id: <20170308213429.29244-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/3] Fix bdrv_is_allocated usage bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

bdrv_is_allocated() returns tri-state, not just bool, although
there were several callers using it as a bool.  Fix them to
either propagate the error or to document why treatment of
failure like allocation is okay.

[Found during a larger effort to convert bdrv_get_block_status
to be byte-based for 2.10]

Eric Blake (3):
  backup: React to bdrv_is_allocated() errors
  vvfat: React to bdrv_is_allocated() errors
  migration: Document handling of bdrv_is_allocated() errors

 block/backup.c    | 14 ++++++++++----
 block/vvfat.c     | 22 +++++++++++++++++++---
 migration/block.c |  2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.9.3
