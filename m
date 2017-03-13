Received: from eggs.gnu.org ([2001:4830:134:3::10]:35032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNa-0005eD-GO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNZ-0002rM-QO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:54:56 +0100
Message-Id: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] Block layer fixes for 2.9.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to dcbf37ce41a52698550f8f8b2f14b5e6fee22d2d:

  commit: Implement .bdrv_refresh_filename (2017-03-13 12:49:33 +0100)

----------------------------------------------------------------
Block layer fixes for 2.9.0-rc1

----------------------------------------------------------------
Eric Blake (4):
      block: Drop unmaintained 'archipelago' driver
      backup: React to bdrv_is_allocated() errors
      vvfat: React to bdrv_is_allocated() errors
      migration: Document handling of bdrv_is_allocated() errors

Fam Zheng (1):
      file-posix: Consider max_segments for BlockLimits.max_transfer

Kevin Wolf (6):
      block: Remove check_new_perm from bdrv_replace_child()
      block: Request block status from *file for BDRV_BLOCK_RAW
      commit: Implement bdrv_commit_top.bdrv_co_get_block_status
      block: Refresh filename after changing backing file
      mirror: Implement .bdrv_refresh_filename
      commit: Implement .bdrv_refresh_filename

Vladimir Sementsov-Ogievskiy (1):
      backup: allow target without .bdrv_get_info

 MAINTAINERS                      |    8 -
 block.c                          |   23 +-
 block/Makefile.objs              |    2 -
 block/archipelago.c              | 1079 --------------------------------------
 block/backup.c                   |   26 +-
 block/commit.c                   |   28 +-
 block/file-posix.c               |   47 ++
 block/io.c                       |    2 +-
 block/mirror.c                   |    9 +
 block/vvfat.c                    |   22 +-
 configure                        |   43 --
 migration/block.c                |    2 +
 qapi/block-core.json             |   33 +-
 tests/qemu-iotests/025           |    2 +-
 tests/qemu-iotests/common        |    6 -
 tests/qemu-iotests/common.filter |    4 +-
 tests/qemu-iotests/common.rc     |    8 -
 17 files changed, 143 insertions(+), 1201 deletions(-)
 delete mode 100644 block/archipelago.c
