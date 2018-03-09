Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnt-0000wn-2M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLns-0006ff-9l
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:07 +0100
Message-Id: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] luks: Implement .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This series implements the .bdrv_co_create callback for luks, adds an
image creation test for it and contains some bonus fixes for bugs that
the test triggered.

Kevin Wolf (6):
  luks: Separate image file creation from formatting
  luks: Create block_crypto_co_create_generic()
  luks: Support .bdrv_co_create
  luks: Turn invalid assertion into check
  luks: Catch integer overflow for huge sizes
  qemu-iotests: Test luks QMP image creation

 qapi/block-core.json         |  17 +++-
 block/crypto.c               | 150 +++++++++++++++++++++---------
 tests/qemu-iotests/208       | 211 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/208.out   | 136 ++++++++++++++++++++++++++++
 tests/qemu-iotests/common.rc |   2 +-
 tests/qemu-iotests/group     |   1 +
 6 files changed, 473 insertions(+), 44 deletions(-)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out

-- 
2.13.6
