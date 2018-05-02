Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fDy1Z-0007C6-Az
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fDy1U-0007pQ-Ce
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:49 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1fDy1U-0007pC-4L
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:44 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18-v6so22691874lfb.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 13:06:44 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed,  2 May 2018 22:06:38 +0200
Message-Id: <20180502200640.22635-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] xlnx-zynqmp: Add emulation of the
 ZynqMP GDMA and ADMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, alistair23@gmail.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

Hi,

The ZynqMP Soc contains two separate instances of a generic DMA, one located in
the FPD (full power domain) called GDMA and a second one located in the LPD
(low power domain) called ADMA. This patch series attempts to add emulation
support for these two DMAs on the ZynqMP board. The first patch in the series
adds a model of the ZynqMP generic DMA (the ZDMA). The second patch in the
series connects the two instances of the ZDMA, the GDMA and the ADMA, to the
ZynqMP board.

Best regards,
Francisco Iglesias

Changelog:
v1 -> v2
  * Don't unpause the DMA channel if CONT is zero and clear CONT after
    unpausing.
  * Added 'state' to the vmstate_zdma.
  * Renamed defines and variables in 'xlnx-zynqmp: Connect the ZynqMP GDMA and
    ADMA' to better reflect they are channels variables.

Francisco Iglesias (2):
  xlnx-zdma: Add a model of the Xilinx ZynqMP generic DMA
  xlnx-zynqmp: Connect the ZynqMP GDMA and ADMA

 hw/arm/xlnx-zynqmp.c         |  53 +++
 hw/dma/Makefile.objs         |   1 +
 hw/dma/xlnx-zdma.c           | 835 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |   5 +
 include/hw/dma/xlnx-zdma.h   |  84 +++++
 5 files changed, 978 insertions(+)
 create mode 100644 hw/dma/xlnx-zdma.c
 create mode 100644 include/hw/dma/xlnx-zdma.h

-- 
2.11.0
