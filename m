Received: from eggs.gnu.org ([2001:4830:134:3::10]:54258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV2xf-0006HY-Em
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV2xc-00006w-6u
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35087
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV2xc-000065-07
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:44:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:44:31 +0100
Message-Id: <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 0/2] pci: allow PCI bus slots to be marked as
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

This patchset adds a new slot_reserved_mask property to PCIBus which is a
bitmask used to indicate whether PCI bus slots are reserved, i.e. they cannot
be used for hot or cold plugging on a particular PCI bus.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rename dev_reserved_mask to slot_reserved_mask as suggested by Marcel
- Squash patches 2 and 3 together


Mark Cave-Ayland (2):
  pci: move check for existing devfn into new pci_bus_devfn_available()
    helper
  pci: add reserved slot check to do_pci_register_device()

 hw/pci/pci.c             |   34 ++++++++++++++++++++++++++++++----
 include/hw/pci/pci_bus.h |    1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.10.4
