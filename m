Received: from eggs.gnu.org ([2001:4830:134:3::10]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAy-00065K-LU
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAt-0006AU-QG
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:40 +0100
Message-Id: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/8] ppc: more Mac-related fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Here is the latest set of Mac-related PPC patches based upon Ben's earlier
work to improve MacOS compatibility, with various fixups and other odds and
ends from me.

Note this patch bumps the vmstate_openpic_timer version as it includes extra
fields, however I don't see this currently being an issue since migration of
the Mac machines is fairly unreliable right now.

With many thanks to Howard Spoelstra over at emaculation for helping test
against a larger set of images than I currently have available myself.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Benjamin Herrenschmidt (5):
  ppc/mac: Advertise a high clock frequency for NewWorld Macs
  ppc/ide/macio: Add missing registers
  ppc/mac: More rework of the DBDMA emulation
  ppc: Fix OpenPIC model
  openpic: Fix problem when IRQ transitions from edge to level

Mark Cave-Ayland (3):
  ppc: QOMify g3beige machine
  macio: convert pmac_ide_ops from old_mmio
  openpic: add missing timer fields to vmstate_openpic_timer

 hw/ide/macio.c            |  170 ++++++++++++++++++++--------------------
 hw/intc/openpic.c         |   76 ++++++++++++++++--
 hw/misc/macio/mac_dbdma.c |  191 +++++++++++++++++++++++++++++++++------------
 hw/ppc/mac.h              |    6 +-
 hw/ppc/mac_newworld.c     |    4 +-
 hw/ppc/mac_oldworld.c     |   17 +++-
 include/hw/ppc/openpic.h  |    1 +
 7 files changed, 313 insertions(+), 152 deletions(-)

-- 
1.7.10.4
