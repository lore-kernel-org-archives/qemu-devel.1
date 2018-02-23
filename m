Received: from eggs.gnu.org ([2001:4830:134:3::10]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1epMfq-0006KY-PF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1epMfl-00025U-RQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:42 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1epMfl-00023m-HK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:22:37 -0500
Received: by mail-lf0-x243.google.com with SMTP id f75so9555574lfg.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 15:22:37 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Sat, 24 Feb 2018 00:22:31 +0100
Message-Id: <20180223232233.31482-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] xilinx_spips: Update CS assertion when
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

Changelog:
v1 -> v2
  * Attempted to improve readability in the patch 'xilinx_spips: Enable only
    two slaves when reading/writing with stripe' when selecting chip selects.


Francisco Iglesias (2):
  xilinx_spips: Enable only two slaves when reading/writing with stripe
  xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands

 hw/ssi/xilinx_spips.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.11.0
