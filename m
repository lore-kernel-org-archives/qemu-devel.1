Received: from eggs.gnu.org ([209.51.188.92]:57919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaQ-0002t8-4Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaF-0004at-9Z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa4-0004QJ-PE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:24 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:00:58 -0500
Message-Id: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319dbc:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-15 17:24:00 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 19c021e1948a81c4ba19b3ff735432b45b6aebee:

  Revert "hbitmap: Add @advance param to hbitmap_iter_next()" (2019-01-15 18:26:50 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (8):
  dirty-bitmap: improve bdrv_dirty_bitmap_next_zero
  tests: add tests for hbitmap_next_zero with specified end parameter
  dirty-bitmap: add bdrv_dirty_bitmap_next_dirty_area
  tests: add tests for hbitmap_next_dirty_area
  block/mirror: fix and improve do_sync_target_write
  Revert "block/dirty-bitmap: Add bdrv_dirty_iter_next_area"
  Revert "test-hbitmap: Add non-advancing iter_next tests"
  Revert "hbitmap: Add @advance param to hbitmap_iter_next()"

 block/backup.c               |   5 +-
 block/dirty-bitmap.c         |  68 ++------------
 block/mirror.c               |  17 ++--
 include/block/dirty-bitmap.h |   7 +-
 include/qemu/hbitmap.h       |  29 ++++--
 nbd/server.c                 |   2 +-
 tests/test-hbitmap.c         | 177 +++++++++++++++++++++++++++++------
 util/hbitmap.c               |  76 ++++++++++++---
 8 files changed, 261 insertions(+), 120 deletions(-)

-- 
2.17.2
