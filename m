Received: from eggs.gnu.org ([209.51.188.92]:43991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0006Ru-U5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007nf-4r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:34 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:38:57 -0700
Message-Id: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] Various i.MX7 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Everyone:

I recently revisited my i.MX7 work and this series contains all of the
fixes I had to make to get it to work with latest (5.1-rc1) Linux
kernel again as well as fixes for genuine bugs that I somehow missed
during original submission ("pci: designware" patches). Hopefully each
patch is self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (5):
  i.mx7d: Add no-op/unimplemented APBH DMA module
  i.mx7d: Add no-op/unimplemented PCIE PHY IP block
  pci: designware: Update MSI mapping unconditionally
  pci: designware: Update MSI mapping when MSI address changes
  i.mx7d: pci: Update PCI IRQ mapping to match HW

 include/hw/arm/fsl-imx7.h | 14 ++++++++++----
 hw/arm/fsl-imx7.c         | 11 +++++++++++
 hw/pci-host/designware.c  | 18 ++++++++----------
 3 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.20.1
