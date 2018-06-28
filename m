Received: from eggs.gnu.org ([2001:4830:134:3::10]:40948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKI-0007tJ-MR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKH-0007Yf-EI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:17 -0500
Message-Id: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/8] block: more byte-based cleanups:
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

My quest continues.  I spent some time pruning sector-based usage
out of qcow as far as possible (and was dismayed at how long it
took to prove no iotests regressions); so for the other drivers, I
did the bare minimum to get rid of an interface, but will leave it
to those file owners if they want to get rid of further pointless
sector manipulations in their files.

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07265.html

v3:
- add R-b, no other changes needed

001/8:[----] [--] 'parallels: Switch to byte-based calls'
002/8:[----] [--] 'qcow: Switch get_cluster_offset to be byte-based'
003/8:[----] [--] 'qcow: Switch qcow_co_readv to byte-based calls'
004/8:[----] [--] 'qcow: Switch qcow_co_writev to byte-based calls'
005/8:[----] [--] 'qcow: Switch to a byte-based driver'
006/8:[----] [--] 'replication: Switch to byte-based calls'
007/8:[----] [--] 'vhdx: Switch to byte-based calls'
008/8:[----] [--] 'block: Remove unused sector-based vectored I/O'

Eric Blake (8):
  parallels: Switch to byte-based calls
  qcow: Switch get_cluster_offset to be byte-based
  qcow: Switch qcow_co_readv to byte-based calls
  qcow: Switch qcow_co_writev to byte-based calls
  qcow: Switch to a byte-based driver
  replication: Switch to byte-based calls
  vhdx: Switch to byte-based calls
  block: Remove unused sector-based vectored I/O

 include/block/block.h |   4 --
 block/io.c            |  36 --------------
 block/parallels.c     |  16 ++++---
 block/qcow.c          | 130 +++++++++++++++++++++++++-------------------------
 block/replication.c   |  14 +++---
 block/vhdx.c          |  12 ++---
 6 files changed, 90 insertions(+), 122 deletions(-)

-- 
2.14.4
