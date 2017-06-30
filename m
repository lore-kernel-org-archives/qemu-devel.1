Received: from eggs.gnu.org ([2001:4830:134:3::10]:50645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwEQ-0006DJ-RV
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwEN-0007aR-QD
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:45:10 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 30 Jun 2017 15:45:00 +0200
Message-Id: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/2] arm: Extend PAR format determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

These are a couple of patches that implement more details of the
32 vs 64bit PAR format determination for AT operations.
This is due to issues we ran into when running Xen.

Best regards,
Edgar

Edgar E. Iglesias (2):
  target-arm: Move the regime_xxx helpers
  target-arm: Extend PAR format determination

 target/arm/helper.c | 434 ++++++++++++++++++++++++++++------------------------
 1 file changed, 231 insertions(+), 203 deletions(-)

-- 
2.7.4
