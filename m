Received: from eggs.gnu.org ([209.51.188.92]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20S1-0000Jc-Bv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20Rz-0002V9-Dz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:21:13 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 21:20:56 +0000
Message-Id: <20190307212058.4890-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] mac: fix booting from hd device with
 -drive syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, david@gibson.dropbear.id.au

These two patches correct a mistake in the original FWPathProvider
implementation for Old World and New World Macs whereby the alias name is
used instead of the node name.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  mac_oldworld: use node name instead of alias name for hd device in
    FWPathProvider
  mac_newworld: use node name instead of alias name for hd device in
    FWPathProvider

 hw/ppc/mac_newworld.c | 4 ++--
 hw/ppc/mac_oldworld.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.11.0
