Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn1-0007oZ-WA
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pmz-0000s4-DP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f0pmz-0000qy-99
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 27 Mar 2018 15:41:20 +0100
Message-Id: <20180327144124.32533-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit f58d9620aa4a514b1227074ff56eefd1334a6225:

  Merge remote-tracking branch 'remotes/rth/tags/pull-dt-20180326' into staging (2018-03-27 10:27:34 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to f5a53faad4bfbf1b86012a13055d2a1a774a42b6:

  MAINTAINERS: add include/block/aio-wait.h (2018-03-27 13:05:48 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (4):
  queue: add QSIMPLEQ_PREPEND()
  coroutine: avoid co_queue_wakeup recursion
  coroutine: add test-aio coroutine queue chaining test case
  MAINTAINERS: add include/block/aio-wait.h

 MAINTAINERS                  |   1 +
 include/qemu/coroutine_int.h |   1 -
 include/qemu/queue.h         |   8 ++++
 block/io.c                   |   3 +-
 tests/test-aio.c             |  65 ++++++++++++++++++++-----
 util/qemu-coroutine-lock.c   |  34 -------------
 util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------------
 7 files changed, 121 insertions(+), 101 deletions(-)

-- 
2.14.3
