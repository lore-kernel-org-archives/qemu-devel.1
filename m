Received: from eggs.gnu.org ([209.51.188.92]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwWBY-0008AP-Dh
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwWBM-0004aS-H5
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:01:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gwWBK-0004Yu-Fy
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:01:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 20 Feb 2019 13:01:09 -0500
Message-Id: <20190220180112.28250-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/3] Bitmaps patches
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

The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to 0a6c86d024c52b1e66d4f7ec01a3bb8ea2600145:

  blockdev: acquire aio_context for bitmap add/remove (2019-02-19 17:49:43 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Eric Blake (1):
  dirty-bitmap: Expose persistent flag to 'query-block'

John Snow (2):
  block/dirty-bitmap: Documentation and Comment fixups
  blockdev: acquire aio_context for bitmap add/remove

 block/dirty-bitmap.c       | 21 +++++++++++++++------
 blockdev.c                 | 26 ++++++++++++++++++++------
 qapi/block-core.json       | 37 ++++++++++++++++++++++++++++---------
 tests/qemu-iotests/124     |  1 +
 tests/qemu-iotests/236.out | 14 ++++++++++++++
 5 files changed, 78 insertions(+), 21 deletions(-)

-- 
2.17.2
