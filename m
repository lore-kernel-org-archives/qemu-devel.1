Received: from eggs.gnu.org ([2001:4830:134:3::10]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0X-0003zD-4Y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0S-0002bN-BF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:17 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fXw0S-0002Wp-5a
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:12 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Tue, 26 Jun 2018 23:59:55 +0200
Message-Id: <20180626215955.18933-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH 0/3] i.mx7d fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Small fixes in the i.mx7d code.

Jean-Christophe Dubois (3):
  i.mx7d: Remove unused header files
  i.mx7d: Change SRC unimpleted device name from sdma to src
  i.mx7d: Change IRQ number type from hwaddr to int

 hw/arm/fsl-imx7.c      | 8 ++++----
 hw/arm/mcimx7d-sabre.c | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.17.1
