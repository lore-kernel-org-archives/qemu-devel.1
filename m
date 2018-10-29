Received: from eggs.gnu.org ([2001:4830:134:3::10]:41735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13i-0003QZ-IE
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gH13i-0008M4-25
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:29:54 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 28 Oct 2018 23:29:39 -0700
Message-Id: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] nvme: fix two issues in nvme unhotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

The first corrent the refcount and second fix a memory leak.

Li Qiang (2):
  nvme: don't unref ctrl_mem when device unrealized
  nvme: free cmbuf in nvme_exit

 hw/block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.11.0
