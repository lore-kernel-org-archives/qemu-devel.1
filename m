Received: from eggs.gnu.org ([2001:4830:134:3::10]:33670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000An-2U
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003HB-Ty
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60838)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Ej-A9
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:18 +0800
Message-Id: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 0/9] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

Rebased on the latest master.

This patch set aims for QOM'ifying code relate with sparc.
It is part of my QOM'ify work of qemu code base.

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

 hw/dma/sparc32_dma.c    | 25 ++++++++++++--------
 hw/dma/sun4m_iommu.c    | 12 ++++------
 hw/misc/eccmemctl.c     | 25 ++++++++++++--------
 hw/misc/slavio_misc.c   | 43 ++++++++++++++--------------------
 hw/sparc/sun4m.c        | 54 +++++++++++++++----------------------------
 hw/sparc64/sun4u.c      | 20 ++++++++--------
 hw/timer/m48t59.c       | 61 ++++++++++++++++++++++++++++++++++---------------
 hw/timer/slavio_timer.c | 12 ++++------
 8 files changed, 128 insertions(+), 124 deletions(-)

-- 
2.11.0
