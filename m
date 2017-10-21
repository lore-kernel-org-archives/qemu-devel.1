Received: from eggs.gnu.org ([2001:4830:134:3::10]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e61ix-0000Nv-Tt
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 17:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e61is-000228-Vk
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 17:54:31 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:50226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e61is-0001sp-Ma
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 17:54:26 -0400
Received: by mail-lf0-x243.google.com with SMTP id a132so16433112lfa.7
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 14:54:25 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sat, 21 Oct 2017 23:54:08 +0200
Message-Id: <20171021215420.19787-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 00/12] Add support for the ZynqMP Generic
 QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Hi,

This patch series starts by adding support in m25p80 for continous
read out of status registers, SST flash READ ID commands, bank address register
accesses, bulk erase (0x60) and two Numonyx flashes (n25q512a11 and
n25q512a13). Thereafter it updates the striping behaviour to be bit big endiann
in the Xilinx QSPI model and adds support for RX discard, endiannes
configuration of TX/RX registers, zero pumping according tranfer register and 4
byte LQSPI addresses. Finally it adds support for the ZynqMP Generic QSPI and 
adds the ZynqMP QSPI to the xlnx-zcu102 board.

Best regards,
Francisco Iglesias

Changelog:
v1 -> v2
  * Reset author on commits (due to mailing issues).


Francisco Iglesias (12):
  m25p80: Add support for continuous read out of RDSR and READ_FSR
  m25p80: Add support for SST READ ID 0x90/0xAB commands
  m25p80: Add support for BRRD/BRWR and BULK_ERASE (0x60)
  m25p80: Add support for n25q512a11 and n25q512a13
  xilinx_spips: Move FlashCMD, XilinxQSPIPS and XilinxSPIPSClass
  xilinx_spips: Update striping to be big-endian bit order
  xilinx_spips: Add support for RX discard and RX drain
  xilinx_spips: Support configured endiannes of TX/RX registers
  xilinx_spips: Add support for zero pumping
  xilinx_spips: Add support for 4 byte addresses in the LQSPI
  xilinx_spips: Add support for the ZynqMP Generic QSPI
  xlnx-zcu102: Add support for the ZynqMP QSPI

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/xlnx-zcu102.c            |  23 ++
 hw/arm/xlnx-zynqmp.c            |  24 ++
 hw/block/m25p80.c               |  50 ++-
 hw/ssi/xilinx_spips.c           | 834 +++++++++++++++++++++++++++++++++-------
 include/hw/arm/xlnx-zynqmp.h    |   5 +
 include/hw/ssi/xilinx_spips.h   |  72 +++-
 7 files changed, 871 insertions(+), 138 deletions(-)

-- 
2.9.3
