Received: from eggs.gnu.org ([209.51.188.92]:44767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7D-0000nE-RN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M79-0006nP-Jt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M78-0006hE-4t
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:41 -0500
Message-Id: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 00/17] Bitmaps patches
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

The following changes since commit 234afe78281b10a798fb97c584e1b677844aaab8:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-03-08' into staging (2019-03-08 16:31:34 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to fc91aa3d937e56d512c702d9b966fcea0e499f0e:

  block/dirty-bitmaps: implement inconsistent bit (2019-03-08 14:07:29 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

John Snow (17):
  block/dirty-bitmap: add recording and busy properties
  block/dirty-bitmaps: rename frozen predicate helper
  block/dirty-bitmap: remove set/reset assertions against enabled bit
  block/dirty-bitmap: change semantics of enabled predicate
  nbd: change error checking order for bitmaps
  block/dirty-bitmap: explicitly lock bitmaps with successors
  block/dirty-bitmaps: unify qmp_locked and user_locked calls
  block/dirty-bitmaps: move comment block
  blockdev: remove unused paio parameter documentation
  iotests: add busy/recording bit test to 124
  block/dirty-bitmaps: add inconsistent bit
  block/dirty-bitmap: add inconsistent status
  block/dirty-bitmaps: add block_dirty_bitmap_check function
  block/dirty-bitmaps: prohibit readonly bitmaps for backups
  block/dirty-bitmaps: prohibit removing readonly bitmaps
  block/dirty-bitmaps: disallow busy bitmaps as merge source
  block/dirty-bitmaps: implement inconsistent bit

 qemu-deprecated.texi           |   6 ++
 qapi/block-core.json           |  28 +++++-
 include/block/dirty-bitmap.h   |  20 +++-
 block/dirty-bitmap.c           | 169 ++++++++++++++++++++++-----------
 block/qcow2-bitmap.c           | 103 ++++++++++----------
 blockdev.c                     |  51 ++--------
 migration/block-dirty-bitmap.c |  18 ++--
 nbd/server.c                   |  13 ++-
 tests/qemu-iotests/124         | 113 ++++++++++++++++++++++
 tests/qemu-iotests/124.out     |   4 +-
 tests/qemu-iotests/236.out     |  28 ++++++
 11 files changed, 377 insertions(+), 176 deletions(-)

-- 
2.17.2
