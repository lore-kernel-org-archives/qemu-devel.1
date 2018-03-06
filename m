Received: from eggs.gnu.org ([2001:4830:134:3::10]:53283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf8-00007u-3j
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etKf4-0006l7-Ve
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 17:02:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 22:01:53 +0000
Message-Id: <20180306220159.4287-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/6] heathrow/grackle/mac_oldworld board wiring
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

[This is for Old World Machines: there is a corresponding patch for New World Machines]

This patchset is a combination of heathrow/grackle/mac_oldworld cleanup with the final
aim of removing the remaining custom init functions and switching IRQ arrays over
to qdev GPIOs.

Patch 1 removes the heathrow_init() function, switching over to qdev GPIOs in order to
wire up the CPU IRQs.

Patch 2 cleans up and QOMifys the grackle device, allowing the deprecated _init()
function to be subsequently removed in patch 3.

Patch 4 wires up the PCI IO space to the PCI host bridge rather than using the inbuilt
system IO address space.

Finally patches 5 and 6 remove the pics IRQ array and instead wire up the macio_oldworld
device to the PIC directly using the existing object link.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (6):
  heathrow: remove obsolete heathow_init() function
  grackle: general tidy-up and QOMify
  grackle: remove deprecated pci_grackle_init() function
  grackle: move PCI IO (ISA) memory region into the grackle device
  mac_oldworld: remove pics IRQ array and wire up macio to heathrow
    directly
  mac_oldworld: move wiring of macio IRQs to macio_oldworld_realize()

 hw/intc/heathrow_pic.c         |  23 ++-------
 hw/misc/macio/macio.c          |  37 +++++++++------
 hw/pci-host/grackle.c          | 103 ++++++++++++++++++++++-------------------
 hw/ppc/mac.h                   |  15 +++---
 hw/ppc/mac_oldworld.c          |  51 ++++++++++----------
 include/hw/intc/heathrow_pic.h |   2 +-
 include/hw/misc/macio/macio.h  |   1 -
 7 files changed, 118 insertions(+), 114 deletions(-)

-- 
2.11.0
