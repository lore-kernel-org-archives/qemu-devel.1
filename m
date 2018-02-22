Received: from eggs.gnu.org ([2001:4830:134:3::10]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eozMC-0000Rg-9J
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eozM9-0001L8-49
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:52 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eozM8-0001K7-SZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:28:49 -0500
Received: by mail-lf0-x242.google.com with SMTP id 70so9675111lfw.2
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 14:28:48 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Thu, 22 Feb 2018 23:28:42 +0100
Message-Id: <20180222222844.7109-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] xilinx_spips: Update CS assertion when
 striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

Hi,

The first patch in this series attempts to correct the slave selection when
using the striping functionality in the QSPI. The second patch in the series
updates the QIOR/QIOR4 commands to use 8 dummy cycles in the QSPI for matching
Micron (Numonyx) flashes (the default target flash type of the QSPI).

Best regards,
Francisco Iglesias

Francisco Iglesias (2):
  xilinx_spips: Enable only two slaves when reading/writing with stripe
  xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands

 hw/ssi/xilinx_spips.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

-- 
2.11.0
