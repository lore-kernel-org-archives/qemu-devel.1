Received: from eggs.gnu.org ([2001:4830:134:3::10]:60031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm6-00018R-Ef
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm3-0007nK-Ta
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:50 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 17 Feb 2017 02:51:24 +0200
Message-Id: <20170217005127.21010-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-img raw preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

This series add missing tests for raw image preallocation, refine
preallocation=full and improve documentation.

Create on top of the commit	10ddfe7b6044 (qemu-img: Do not truncate
before preallocation) from Kevin block branch.

Nir Soffer (3):
  qemu-img: Add tests for raw image preallocation
  qemu-img: Truncate before full preallocation
  qemu-img: Improve documentation for PREALLOC_MODE_FALLOC

 block/file-posix.c         | 19 ++++++++++++++-
 tests/qemu-iotests/175     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out | 18 ++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

-- 
2.9.3
