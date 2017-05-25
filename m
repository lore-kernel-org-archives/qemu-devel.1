Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvO-0004EY-Ry
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvO-0005Qq-2d
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:34 -0400
Received: from m12-15.163.com ([220.181.12.15]:36025)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1dDsvN-0005QG-D6
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:35:34 -0400
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Thu, 25 May 2017 21:34:43 +0800
Message-Id: <20170525133451.22459-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/8] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au, f4bug@amsat.org

This patch set aims for QOM'ifying code relate with sparc.
It is part of my QOM'ify work of qemu code base.

Changes:

v2 -> v3:
* rebased on the latest master
* squash two patches about m48txx_sysbus into one

v1 ->  v2: 
* rebased on the latest master

xiaoqiang zhao (8):
  hw/misc: QOM'ify eccmemctl.c
  hw/dma: QOM'ify sparc32_dma.c
  hw/dma: QOM'ify sun4m_iommu.c
  hw/misc: QOM'ify slavio_misc.c
  hw/timer: QOM'ify m48txx_sysbus
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
2.13.0.rc2.115.g10c78a162
