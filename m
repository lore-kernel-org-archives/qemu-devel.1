Received: from eggs.gnu.org ([2001:4830:134:3::10]:51226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDuo-0000gt-0r
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDuj-0003ns-7H
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dpDuj-0003mw-1E
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Sep 2017 14:29:04 +0100
Message-Id: <20170905132908.30931-1-stefanha@redhat.com>
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

The following changes since commit 2b483739791b33c46e6084b51edcf62107058ae1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170904-2' into staging (2017-09-04 17:21:24 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to b461151ff31c7925f271c297e8abed20231ac7d3:

  block: document semantics of bdrv_co_preadv|pwritev (2017-09-05 11:07:02 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  block: document semantics of bdrv_co_preadv|pwritev

Stefan Hajnoczi (3):
  qemu.py: make VM() a context manager
  iotests.py: add FilePath context manager
  qemu-iotests: use context managers for resource cleanup in 194

 include/block/block_int.h     |  31 +++++++++++
 scripts/qemu.py               |  16 +++++-
 tests/qemu-iotests/194        | 117 +++++++++++++++++++++---------------------
 tests/qemu-iotests/iotests.py |  26 ++++++++++
 4 files changed, 130 insertions(+), 60 deletions(-)

-- 
2.13.5
