Received: from eggs.gnu.org ([2001:4830:134:3::10]:57274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFt-0007Id-Rn
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWeFq-0001mQ-Q2
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:44523
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fWeFq-0001kW-JQ
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 04:50:46 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 23 Jun 2018 09:50:26 +0100
Message-Id: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] sysbus/pci: allow better customisation of
 firmware device paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

Here are a couple of patches coming out of my work to add bootindex support
to OpenBIOS.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  sysbus: always allow explicit_ofw_unit_address() to override address
    generation
  pci: allow DeviceClass fw_name to override pci_dev_fw_name() if set

 hw/core/sysbus.c | 15 +++++++--------
 hw/pci/pci.c     |  4 +++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.11.0
