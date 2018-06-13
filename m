Received: from eggs.gnu.org ([2001:4830:134:3::10]:52948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT1Am-00013r-2P
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fT1Ah-0003cK-Pu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:30:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 13 Jun 2018 09:30:12 +0100
Message-Id: <20180613083015.15749-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] mos6522: allow IRQs from external port pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, david@gibson.dropbear.id.au

Whilst testing a conversion of Laurent's q800 patchset over to use mos6522
I discovered some issues which prevented IRQs being generated from inputs to
external port pins.

This is a requirement for the q800 patchset which uses external clocks to
generate periodic interrupts.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  mos6522: only clear the shift register interrupt upon write
  mos6522: remove additional interrupt flag filter from
    mos6522_update_irq()
  mos6522: expose mos6522_update_irq() through MOS6522DeviceClass

 hw/misc/mos6522.c         | 5 +++--
 include/hw/misc/mos6522.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.11.0
