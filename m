Received: from eggs.gnu.org ([2001:4830:134:3::10]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYB-0006UH-IF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYA-0007Al-KV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:31 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 20:08:19 -0500
Message-Id: <cover.1485392617.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block: check full backing filename when
 searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

Differences from v1:

Patch 1: set local_error = NULL after freeing (Thanks Eric)
Patch 2: new patch, groundwork for qemu-iotest in patch 3
Patch 3: qemu-iotest, as requested (Thanks Max)


Jeff Cody (3):
  block: check full backing filename when searching protocol filenames
  qemu-iotests: Don't create fifos / pidfiles with protocol paths
  qemu-iotest: test to lookup protocol-based image with relative backing

 block.c                          | 13 ++++++
 tests/qemu-iotests/173           | 97 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/173.out       | 12 +++++
 tests/qemu-iotests/common.config |  6 ++-
 tests/qemu-iotests/common.qemu   | 10 ++---
 tests/qemu-iotests/common.rc     |  6 +--
 tests/qemu-iotests/group         |  1 +
 7 files changed, 135 insertions(+), 10 deletions(-)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

-- 
2.9.3
