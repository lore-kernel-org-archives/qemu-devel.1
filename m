Received: from eggs.gnu.org ([209.51.188.92]:50060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu4HB-0002U3-70
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu4HA-0003cU-Ao
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gu4HA-0003bx-5R
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:49:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:49:04 -0500
Message-Id: <20190213234907.24173-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Bitmaps patches
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

The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to fbe8c2e3b041c682d3d52030b53e1627f285a84b:

  blockdev: acquire aio_context for bitmap add/remove (2019-02-13 18:42:46 -0500)

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
