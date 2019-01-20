Received: from eggs.gnu.org ([209.51.188.92]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl672-00060E-GY
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl671-0004P3-RY
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 00:57:40 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 19 Jan 2019 21:55:55 -0800
Message-Id: <20190120055558.32984-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/3] nvme small fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com, philmd@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

This patchset contains small fix.

Change since v2:
For patch 2:
1. add nvme command
2. check num_queues first

Change since v1: 

1. drop the patch of checking return value of msix_init_exclusive_bar
2. return when nvme's num_queues configuration is 0

Li Qiang (3):
  nvme: use TYPE_NVME instead of constant string
  nvme: ensure the num_queues is not zero
  nvme: use pci_dev directly in nvme_realize

 hw/block/nvme.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.17.1
