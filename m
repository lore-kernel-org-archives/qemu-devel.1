Received: from eggs.gnu.org ([209.51.188.92]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdJ-0000Xv-Mt
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdI-0006zz-T0
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:13 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Wed, 17 Apr 2019 22:53:50 +0300
Message-Id: <20190417195355.16123-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Few fixes for userspace NVME driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Hi!
These are few assorted fixes and features for the userspace
nvme driver.

Tested that on my laptop with my Samsung X5 thunderbolt drive, which
happens to have 4K sectors, support for discard and write zeros.

Also bunch of fixes sitting in my queue from the period when I developed
the nvme-mdev driver.

Best regards,
        Maxim Levitsky

Maxim Levitsky (5):
  block/nvme: don't flip CQ phase bits
  block/nvme: fix doorbell stride
  block/nvme: support larger that 512 bytes sector devices
  block/nvme: add support for write zeros
  block/nvme: add support for discard

 block/nvme.c         | 193 +++++++++++++++++++++++++++++++++++++++++--
 block/trace-events   |   3 +
 include/block/nvme.h |  19 ++++-
 3 files changed, 205 insertions(+), 10 deletions(-)

-- 
2.17.2
