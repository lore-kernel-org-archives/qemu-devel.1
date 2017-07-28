Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db570-0001SL-Po
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db56z-0007hF-UJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:15:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Jul 2017 15:14:45 +0200
Message-Id: <20170728131452.15316-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/7] qemu-iotests: Fix leaked
 temporary file fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This fixes leaked temporary files that are created during successful
runs of qemu-iotests for qcow2, raw and vmdk. More file leaks exist for
failing or interrupted tests, but this is something for another day.

Kevin Wolf (7):
  qemu-iotests/041: Fix leaked scratch images
  qemu-iotests: Remove blkdebug.conf after tests
  qemu-iotests/141: Fix image cleanup
  qemu-iotests/153: Fix leaked scratch images
  qemu-iotests/162: Fix leaked temporary files
  qemu-iotests/063: Fix leaked image
  qemu-iotests/059: Fix leaked image files

 tests/qemu-iotests/041       |  4 +++-
 tests/qemu-iotests/059       |  9 +++++++++
 tests/qemu-iotests/059.out   | 22 +++++++++++-----------
 tests/qemu-iotests/063       |  4 +---
 tests/qemu-iotests/074       |  1 +
 tests/qemu-iotests/141       |  2 +-
 tests/qemu-iotests/153       |  1 +
 tests/qemu-iotests/162       |  7 +++++++
 tests/qemu-iotests/179       |  1 +
 tests/qemu-iotests/common.rc |  3 +++
 10 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.13.3
