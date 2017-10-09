Received: from eggs.gnu.org ([2001:4830:134:3::10]:43115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g1X-0000Ua-WB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1g1X-0000Gh-AC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:55:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Oct 2017 23:55:30 +0200
Message-Id: <20171009215533.12530-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qcow2: Fix preallocated truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

There are (at least...) two bugs in preallocated truncation, which this
series fixes.

Both would have been apparent if the the related iotest had used the
default cluster size in addition to 512 byte clusters, but alas, it did
not.  This is remedied by patch 3 of this series.


Max Reitz (3):
  qcow2: Fix unaligned preallocated truncation
  qcow2: Always execute preallocate() in a coroutine
  iotests: Add cluster_size=64k to 125

 block/qcow2.c              |  42 +++-
 tests/qemu-iotests/125     |   7 +-
 tests/qemu-iotests/125.out | 480 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 472 insertions(+), 57 deletions(-)

-- 
2.13.6
