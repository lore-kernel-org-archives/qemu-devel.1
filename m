Received: from eggs.gnu.org ([2001:4830:134:3::10]:49235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faCHV-0004Pi-ND
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faCHU-0001hj-VP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:47:09 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  2 Jul 2018 23:46:52 -0400
Message-Id: <20180703034655.792039-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)

are available in the Git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 9ded4a0114968e98b41494fc035ba14f84cdf700:

  backup: Use copy offloading (2018-07-02 23:23:45 -0400)

----------------------------------------------------------------
Block backup patches
----------------------------------------------------------------

Fam Zheng (3):
  block: Fix parameter checking in bdrv_co_copy_range_internal
  block: Honour BDRV_REQ_NO_SERIALISING in copy range
  backup: Use copy offloading

 block/backup.c        | 150 ++++++++++++++++++++++++++++++------------
 block/io.c            |  35 +++++-----
 block/trace-events    |   1 +
 include/block/block.h |   5 +-
 4 files changed, 132 insertions(+), 59 deletions(-)

-- 
2.17.1
