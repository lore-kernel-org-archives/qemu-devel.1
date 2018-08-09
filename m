Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjj-0000KX-R6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjT-0006Q2-NY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:47 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu,  9 Aug 2018 22:40:08 +0200
Message-Id: <20180809204010.3579-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] ppc: deprecate 'prep' machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hello,

These two small patches deprecate the PPC 'prep' machine in favor of the
'40p' machine.

This is already flagged as 'Future candidate' for removal in
https://wiki.qemu.org/Features/LegacyRemoval

Herv√

Herv√© Poussineau (2):
  hw/ppc: on 40p machine, change default firmware to OpenBIOS
  hw/ppc: deprecate the machine type 'prep', replaced by '40p'

 hw/ppc/prep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.11.0
