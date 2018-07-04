Received: from eggs.gnu.org ([2001:4830:134:3::10]:53028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMX-0002BT-Pf
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMT-0004Bg-8c
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fabMT-0004AJ-4B
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:57 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  4 Jul 2018 02:33:53 -0400
Message-Id: <20180704063355.25818-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 79c2b203a932db5882a3f328db53e5a448cd47f9:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180703-pull-request' into staging (2018-07-03 21:09:27 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 58f72b965e9e1820d246329461216c4d13140122:

  dirty-bitmap: fix double lock on bitmap enabling (2018-07-04 02:12:49 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Vladimir Sementsov-Ogievskiy (2):
  block/dirty-bitmap: add bdrv_enable_dirty_bitmap_locked
  dirty-bitmap: fix double lock on bitmap enabling

 block/dirty-bitmap.c           | 12 +++++++++---
 include/block/dirty-bitmap.h   |  1 +
 migration/block-dirty-bitmap.c |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.14.4
