Received: from eggs.gnu.org ([2001:4830:134:3::10]:49061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80R-0005Dv-Fa
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=65150b487=Paul.Durrant@citrix.com>)
	id 1fD80Q-0000jU-Ma
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:34:11 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 30 Apr 2018 13:01:35 +0100
Message-ID: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] block/xen_disk: legacy code removal and
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The grant copy operation was added to libxengnttab in Xen 4.8.0 (released
nearly 18 months ago) but the xen_disk PV backend QEMU is still carrying
a significant amount of code purely to remain compatible with older
versions of Xen.

As can be inferred from the diff stats below, removing this support for
older versions of Xen from QEMU reduces the size of the xen_disk source by
more than 350 lines (~25%). The majority of this is done in patches #1
and #2. Further simplifications are made in patch #3 and then some cosmetic
work is done in patch #4.

Paul Durrant (4):
  block/xen_disk: remove persistent grant code
  block/xen_disk: remove use of grant map/unmap
  block/xen_disk: use a single entry iovec
  block/xen_disk: be consistent with use of xendev and blkdev->xendev

 hw/block/xen_disk.c | 590 ++++++++++------------------------------------------
 1 file changed, 109 insertions(+), 481 deletions(-)
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

-- 
2.1.4
