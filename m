Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx70-0005Xk-1N
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx67-0000ih-En
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:13:49 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 12:12:40 -0300
Message-Id: <20171218151244.9975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] QOM'ify PCIDevices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Keith Busch <keith.busch@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, James Hogan <jhogan@kernel.org>

Hi,

In this series we QOM'ify the last few PCI devices still using
PCIDeviceClass->init() by converting this init() to realize(),

Then we finally remove the then PCIDeviceClass->init() method for good.

Regards,

Phil.

v2: addressed review feedbacks from Marcel Apfelbaum

Philippe Mathieu-Daudé (4):
  hw/block/nvme: QOM'ify PCI NVME
  hw/pci-host/piix: QOM'ify the IGD Passthrough host bridge
  hw/pci-host/xilinx: QOM'ify the AXI-PCIe host bridge
  hw/pci: remove obsolete PCIDevice->init()

 include/hw/pci/pci.h      |  1 -
 hw/block/nvme.c           | 32 +++++++++++++++++---------------
 hw/pci-host/piix.c        | 45 ++++++++++++++++++++-------------------------
 hw/pci-host/xilinx-pcie.c | 20 +++++++++-----------
 hw/pci/pci.c              | 14 --------------
 5 files changed, 46 insertions(+), 66 deletions(-)

-- 
2.15.1
