Received: from eggs.gnu.org ([2001:4830:134:3::10]:39447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQ704-0002A1-0Z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQ702-00030t-F5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:07:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Jun 2018 16:07:08 +0800
Message-Id: <20180605080710.27035-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

Based-on: <20180601092648.24614-1-famz@redhat.com>
([PATCH v9 00/10] qemu-img convert with copy offloading)

This enhances the backup job to make use of the copy offloading API. It
eliminates the necessity to use the bounce buffer as well as speeding up the
copy operation when the backend supports it.

v2: Use helper functions. [Stefan]

Fam Zheng (2):
  block: Honour BDRV_REQ_NO_SERIALISING in copy range
  backup: Use copy offloading

 block/backup.c        | 151 ++++++++++++++++++++++++++++++------------
 block/io.c            |   6 +-
 block/trace-events    |   1 +
 include/block/block.h |   5 +-
 4 files changed, 118 insertions(+), 45 deletions(-)

-- 
2.17.0
