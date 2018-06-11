Received: from eggs.gnu.org ([2001:4830:134:3::10]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaO-0001uV-Ip
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaK-0003Uh-KJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaK-0003TX-Fa
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:36 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:27 -0400
Message-Id: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Bitmaps patches
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

The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to a6e2ca5f6521553681ae136578ec1cb67e1a7973:

  qapi: add disabled parameter to block-dirty-bitmap-add (2018-06-11 14:53:32 -0400)

----------------------------------------------------------------

bitmaps pull request

----------------------------------------------------------------

Paolo Bonzini (2):
  block: remove bdrv_dirty_bitmap_make_anon
  block: simplify code around releasing bitmaps

Vladimir Sementsov-Ogievskiy (5):
  block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
  qapi: add x-block-dirty-bitmap-enable/disable
  qmp: transaction support for x-block-dirty-bitmap-enable/disable
  qapi: add x-block-dirty-bitmap-merge
  qapi: add disabled parameter to block-dirty-bitmap-add

 block/dirty-bitmap.c         | 117 ++++++++++++++----------------
 blockdev.c                   | 164 ++++++++++++++++++++++++++++++++++++++++++-
 include/block/dirty-bitmap.h |   4 +-
 qapi/block-core.json         |  86 ++++++++++++++++++++++-
 qapi/transaction.json        |   4 ++
 5 files changed, 307 insertions(+), 68 deletions(-)

-- 
2.14.3
