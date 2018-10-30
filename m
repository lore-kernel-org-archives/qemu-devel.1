Received: from eggs.gnu.org ([208.118.235.92]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQX-0005en-JW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHMQX-0005PK-0K
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 01:18:53 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 22:18:36 -0700
Message-Id: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/4] nvme: some small fixes
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

Including sanity check and code cleanup.

Li Qiang (4):
  nvme: use TYPE_NVME instead of constant string
  nvme: ensure the num_queues is not zero
  nvme: check msix_init_exclusive_bar return value
  nvme: use pci_dev directly in nvme_realize

 hw/block/nvme.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
1.8.3.1
