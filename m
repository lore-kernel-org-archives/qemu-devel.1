Received: from eggs.gnu.org ([2001:4830:134:3::10]:33408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNw1-0000Jj-33
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNvx-0008Ph-W1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:54680
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTNvx-0008NX-Oi
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Jul 2017 08:43:59 +0100
Message-Id: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] pci: allow PCI bus slots to be marked as
 reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

For some machines it is impossible to plug devices into a particular PCI bus
slot, e.g. for a real Ultra 5 there are 2 PCI bridges attached to the root
bus behind which all devices must be plugged. Ignoring this rule will cause
problems with interrupt routing since the interrupt numbers are calculated
based upon PCI bridge id and secondary PCI bus slot id.

This patchset adds a new dev_reserved_mask property to PCIBus which is a
bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
be used for hot or cold plugging on a particular PCI bus.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  pci: move check for existing devfn into new pci_bus_devfn_available()
    helper
  pci: add dev_reserved_mask property to PCIBus
  pci: add reserved slot check to do_pci_register_device()

 hw/pci/pci.c             |   34 ++++++++++++++++++++++++++++++----
 include/hw/pci/pci_bus.h |    1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.10.4
