Received: from eggs.gnu.org ([2001:4830:134:3::10]:60303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5q-0001ha-GM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5p-0008Ob-P7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:34 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Mar 2018 16:09:06 +0800
Message-Id: <20180309080910.7274-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Fix permission during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

We write open the whole backing chain during reopen. It is not necessary and
will cause image locking problems if the backing image is shared.

Fam Zheng (4):
  block: Pass "current_flags" in BdrvChildRole.inherit_options
  block: Fix write flags in bdrv_backing_options
  block: Use the actual current_flags during reopen
  iotests: Add regression test for commit base locking

 block.c                    | 52 +++++++++++++++++++++++++++++-----------------
 block/block-backend.c      |  3 ++-
 block/vvfat.c              |  3 ++-
 include/block/block_int.h  |  3 ++-
 tests/qemu-iotests/153     |  6 ++++++
 tests/qemu-iotests/153.out |  4 ++++
 6 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.14.3
