Received: from eggs.gnu.org ([2001:4830:134:3::10]:50598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4PxA-0002As-Iu
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px5-0003i4-L0
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:16 -0400
Received: from m12-12.163.com ([220.181.12.12]:42592)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1d4Px4-0003dK-Sz
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:50:11 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 29 Apr 2017 18:49:28 +0800
Message-Id: <20170429104937.31341-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2 0/9] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au, pbonzini@redhat.com, atar4qemu@gmail.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com

This patch set aims for QOM'ifying code relate with sparc.
It is part of my QOM'ify work of qemu code base.

changes since v1: 
* rebased on the latest master

xiaoqiang zhao (9):
  hw/misc: QOM'ify eccmemctl.c
  hw/dma: QOM'ify sparc32_dma.c
  hw/dma: QOM'ify sun4m_iommu.c
  hw/misc: QOM'ify slavio_misc.c
  hw/timer: QOM'ify m48txx_sysbus (pass 1)
  hw/timer: QOM'ify m48txx_sysbus (pass 2)
  hw/timer: QOM'ify slavio_timer
  hw/sparc: QOM'ify sun4m.c
  hw/sparc64: QOM'ify sun4u.c

 hw/dma/sparc32_dma.c    | 25 ++++++++++++++---------
 hw/dma/sun4m_iommu.c    | 12 +++++------
 hw/misc/eccmemctl.c     | 25 ++++++++++++++---------
 hw/misc/slavio_misc.c   | 43 ++++++++++++++++-----------------------
 hw/sparc/sun4m.c        | 54 +++++++++++++++++--------------------------------
 hw/sparc64/sun4u.c      | 20 +++++++++---------
 hw/timer/m48t59.c       | 38 +++++++++++++++++-----------------
 hw/timer/slavio_timer.c | 12 +++++------
 8 files changed, 105 insertions(+), 124 deletions(-)

-- 
2.11.0
