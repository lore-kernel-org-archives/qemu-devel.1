Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZB-00042l-6o
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZA-0006VV-9h
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:49 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:35 -0500
Message-Id: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to acf6e5f0962c4be670d4a93ede77423512521876:

  sheepdog: reorganize check for overlapping requests (2017-02-01 00:17:20 -0500)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Paolo Bonzini (5):
  sheepdog: remove unused cancellation support
  sheepdog: reorganize coroutine flow
  sheepdog: do not use BlockAIOCB
  sheepdog: simplify inflight_aio_head management
  sheepdog: reorganize check for overlapping requests

 block/sheepdog.c | 289 ++++++++++++++++---------------------------------------
 1 file changed, 84 insertions(+), 205 deletions(-)

-- 
2.9.3
