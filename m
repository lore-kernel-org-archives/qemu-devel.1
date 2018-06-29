Received: from eggs.gnu.org ([2001:4830:134:3::10]:35109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVW-00014H-JO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fYmVV-0007Dg-SB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:03:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Jun 2018 14:03:25 +0800
Message-Id: <20180629060328.4423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: A few more copy offloading fixes
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

These are unfortunately more serious than the previous two fixes but the
patches are not complicated.

Fam Zheng (3):
  qcow2: Fix src_offset in copy offloading
  iscsi: Don't blindly use designator length in response for memcpy
  file-posix: Fix EINTR handling

 block/file-posix.c         | 17 +++++++++--------
 block/iscsi.c              |  2 +-
 block/qcow2.c              |  1 +
 tests/qemu-iotests/063     |  9 +++++++++
 tests/qemu-iotests/063.out | 12 ++++++++++++
 5 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.17.1
