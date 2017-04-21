Received: from eggs.gnu.org ([2001:4830:134:3::10]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V66-0007sc-J5
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V62-0000V1-81
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1V62-0000Ul-1o
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:43:10 +0100
Message-Id: <20170421094316.19361-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/6] Block patches
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

The following changes since commit fa54abb8c298f892639ffc4bc2f61448ac3be4a1:

  Drop QEMU_GNUC_PREREQ() checks for gcc older than 4.1 (2017-04-20 18:33:33 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 3ccc0a0163b932fe980dce8d26db4bf98b1900e9:

  MAINTAINERS: update my email address (2017-04-21 10:36:12 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Changlong Xie (1):
  MAINTAINERS: update Wen's email address

Lidong Chen (1):
  migration/block: use blk_pwrite_zeroes for each zero cluster

Stefan Hajnoczi (3):
  qemu-options: explain disk I/O throttling options
  throttle: do not use invalid config in test
  throttle: make throttle_config(throttle_get_config()) symmetric

Zhang Chen (1):
  MAINTAINERS: update my email address

 MAINTAINERS           |  4 ++--
 migration/block.c     | 35 +++++++++++++++++++++++++++++++++--
 tests/test-throttle.c |  8 ++++----
 util/throttle.c       | 14 ++++++++++++++
 qemu-options.hx       | 24 ++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 8 deletions(-)

-- 
2.9.3
