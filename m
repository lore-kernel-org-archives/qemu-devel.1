Received: from eggs.gnu.org ([2001:4830:134:3::10]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYtt0-00032A-8O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYtsx-0006d1-7H
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:56:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58456
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fYtsx-0006YD-0v
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:56:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 29 Jun 2018 14:56:14 +0100
Message-Id: <20180629135616.16570-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] sysbus/pci: allow better customisation
 of firmware device paths
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

v2:
- Rebase onto master
- Reword patch 1 as suggested by Laszlo (and double-check affected devices)
- Add Philippe's R-B for patch 2


Mark Cave-Ayland (2):
  sysbus: always allow explicit_ofw_unit_address() to override address
    generation
  pci: allow DeviceClass fw_name to override pci_dev_fw_name() if set

 hw/core/sysbus.c | 15 +++++++--------
 hw/pci/pci.c     |  4 +++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.11.0
