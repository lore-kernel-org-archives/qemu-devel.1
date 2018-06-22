Received: from eggs.gnu.org ([2001:4830:134:3::10]:43542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGzZ-0000N2-73
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWGzV-0001KY-E3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:00:25 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 22 Jun 2018 09:00:07 +0100
Message-Id: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] ppc: minor Mac fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here are a couple of minor fixes for things discovered during further
testing of the recent Mac changes.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  mac_dbdma: only dump commands for debug enabled channels
  mac_newworld: always enable disable_direct_reg3_writes for ADB
    machines

 hw/misc/macio/mac_dbdma.c | 21 +++++++++++----------
 hw/ppc/mac_newworld.c     |  4 ++--
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.11.0
