Received: from eggs.gnu.org ([2001:4830:134:3::10]:42230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3F-0001Dn-Nn
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3F-0001cI-2V
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:58:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Jul 2018 10:58:32 +0800
Message-Id: <20180702025836.20957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Trivial fixes in offloading code
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

These are the low priority ones spotted by Kevin and Max last week.

Fam Zheng (4):
  qcow2: Drop unused cluster_data
  file-posix: Fix fd_open check in raw_co_copy_range_to
  qcow2: Drop unreachable break
  raw: Drop superfluous semicolon

 block/file-posix.c | 2 +-
 block/qcow2.c      | 3 ---
 block/raw-format.c | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.17.1
