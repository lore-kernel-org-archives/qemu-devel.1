Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo4eY-0004Jt-9o
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo4eT-0002Lu-AD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:28:18 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Aug 2018 11:27:55 +0100
Message-Id: <20180810102757.21010-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] mac: don't use legacy fw_cfg_init_mem()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here are a couple of patches to switch the fw_cfg initialisation for
the Mac Old World and New World machines over to use qdev rather than
using the legacy fw_cfg_init_mem() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  mac_oldworld: don't use legacy fw_cfg_init_mem() function
  mac_newworld: don't use legacy fw_cfg_init_mem() function

 hw/ppc/mac_newworld.c | 12 +++++++++++-
 hw/ppc/mac_oldworld.c | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.11.0
