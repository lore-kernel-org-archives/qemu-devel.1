Received: from eggs.gnu.org ([2001:4830:134:3::10]:57052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwdG-0004Vx-Gi
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwdD-0001Y7-Au
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQwdD-0001XJ-5R
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 30 Jun 2017 22:10:38 +0800
Message-Id: <20170630141040.15353-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

The following changes since commit 36f87b4513373b3cd79c87c9197d17face95d4ac:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170630' into staging (2017-06-30 11:58:49 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/block-pull-request

for you to fetch changes up to c61e684e44272f2acb2bef34cf2aa234582a73a9:

  block: Exploit BDRV_BLOCK_EOF for larger zero blocks (2017-06-30 21:48:06 +0800)

----------------------------------------------------------------

Hi Peter,

Here are Eric Blake's enhancement to block layer API. Thanks!

----------------------------------------------------------------

Eric Blake (2):
  block: Add BDRV_BLOCK_EOF to bdrv_get_block_status()
  block: Exploit BDRV_BLOCK_EOF for larger zero blocks

 block/io.c                 | 42 +++++++++++++++++++++++++++++++++---------
 include/block/block.h      |  2 ++
 tests/qemu-iotests/154     |  4 ----
 tests/qemu-iotests/154.out | 12 ++++++------
 4 files changed, 41 insertions(+), 19 deletions(-)

-- 
2.9.4
