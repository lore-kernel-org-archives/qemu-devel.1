Received: from eggs.gnu.org ([208.118.235.92]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfN1A-0003tT-Bz
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gfN17-0000Am-N3
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 05:47:56 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri,  4 Jan 2019 11:47:48 +0100
Message-Id: <20190104104749.5314-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/1] hw/arm: versal: Fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series fixes the memory leaks in versal board creation
reported by Peter Maydell.

Best regards,
Edgar

Edgar E. Iglesias (1):
  hw/arm: versal: Plug memory leaks

 hw/arm/xlnx-versal-virt.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1
