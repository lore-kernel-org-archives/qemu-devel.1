Received: from eggs.gnu.org ([2001:4830:134:3::10]:33828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOca-0004w8-6F
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOcZ-0002yV-BU
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:16 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:50777
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eCOcZ-0002xZ-4d
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:15 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed,  8 Nov 2017 12:32:41 +0100
Message-Id: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/2] Add the TTC to the xlnx-zynqmp
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, edgar.iglesias@gmail.com, peter.maydell@linaro.org, frederic.konrad@adacore.com

Hi,

This serie adds the TTC timers to the xlnx-zynqmp board required to boot some
os. It seems that the waveform feature is not implemented but since that's not
directly software visible it is not an issue. An other limitation is that the
frequency is fixed and should be configurable through the zynqmp clock
controllers.

Thanks,
Fred

KONRAD Frederic (2):
  cadence_ttc: extract CadenceTTCState to a new header file
  xlnx-zynqmp: add the timers

 hw/arm/xlnx-zynqmp.c           | 25 +++++++++++++++++
 hw/timer/cadence_ttc.c         | 35 +-----------------------
 include/hw/arm/xlnx-zynqmp.h   |  3 +++
 include/hw/timer/cadence_ttc.h | 61 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/timer/cadence_ttc.h

-- 
1.8.3.1
