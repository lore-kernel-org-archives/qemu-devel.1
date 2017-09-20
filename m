Received: from eggs.gnu.org ([2001:4830:134:3::10]:34141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duYMu-0003LT-NI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duYMq-0006Pb-MR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:20:20 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 20 Sep 2017 07:19:59 +0100
Message-Id: <1505888401-10130-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] macio patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Here are the macio patches taken from my previous "ppc: more Mac-related fixups"
patchset with the v2 pmac_ide_ops conversion changes as requested.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Benjamin Herrenschmidt (1):
  ppc/ide/macio: Add missing registers

Mark Cave-Ayland (1):
  macio: convert pmac_ide_ops from old_mmio

 hw/ide/macio.c |  191 +++++++++++++++++++++++++++++---------------------------
 hw/ppc/mac.h   |    6 +-
 2 files changed, 104 insertions(+), 93 deletions(-)

-- 
1.7.10.4
