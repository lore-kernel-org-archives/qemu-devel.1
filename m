Received: from eggs.gnu.org ([2001:4830:134:3::10]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQBv9-0006sN-Jt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQBv4-0002Lj-2n
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:54:59 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 23 Nov 2018 14:54:49 +0100
Message-Id: <20181123135450.24829-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This fixes an issue with the GEM models reported by Bilal.
If a GEM's receiver is disabled, we shouldn't be asserting on
descriptor processing.

Cheers,
Edgar

Edgar E. Iglesias (1):
  net: cadence_gem: Remove incorrect assert()

 hw/net/cadence_gem.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.17.1
