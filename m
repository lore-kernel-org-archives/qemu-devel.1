Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGt-0003O4-M4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGn-0005t2-GD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:23 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 17:59:52 +0100
Message-Id: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] ppc: trivial Mac fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here are some trivial Mac fixes taken from various working branches in my
local git repository. Since they should need minimal review it seems
worthwhile to send them separately.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  ppc: remove obsolete pci_pmac_init() definitions from mac.h
  ppc: remove obsolete macio_init() definition from mac.h
  ppc: add missing FW_CFG_PPC_NVRAM_FLAT definition

 hw/ppc/mac.h         | 9 ---------
 include/hw/ppc/ppc.h | 1 +
 2 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.11.0
