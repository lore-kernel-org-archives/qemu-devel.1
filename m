Received: from eggs.gnu.org ([2001:4830:134:3::10]:53076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKml-0007fs-1l
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fEKmh-0007Mn-QA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:25:03 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  3 May 2018 21:24:38 +0100
Message-Id: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] uninorth: move wiring of macio IRQs to Mac
 New World machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is the remaining set of patches from my previous uninorth patchset which
moves the uninorth token register to its own separate device, and then moves
the wiring of macio IRQs to the Mac New World machine (similar to as already
has been done with the Old World machine).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Not strictly a v2 but contains the following changes from the original
submission to patch 1:

- Change DEVICE_NATIVE_ENDIAN to DEVICE_BIG_ENDIAN for the Uninorth device
- Add Philippe's R-B tag


Mark Cave-Ayland (3):
  uninorth: create new uninorth device
  mac_newworld: remove pics IRQ array and wire up macio to OpenPIC
    directly
  mac_newworld: move wiring of macio IRQs to macio_newworld_realize()

 hw/misc/macio/macio.c          | 39 ++++++++++++++++------------
 hw/pci-host/trace-events       |  2 ++
 hw/pci-host/uninorth.c         | 58 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/mac.h                   |  9 +++++++
 hw/ppc/mac_newworld.c          | 56 +++++-----------------------------------
 hw/ppc/trace-events            |  4 ---
 include/hw/misc/macio/macio.h  |  1 -
 include/hw/pci-host/uninorth.h | 11 ++++++++
 8 files changed, 110 insertions(+), 70 deletions(-)

-- 
2.11.0
