Received: from eggs.gnu.org ([2001:4830:134:3::10]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0K-0008JJ-Lp
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0G-0002cW-DF
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:36 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33403
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJg0G-0002cK-63
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:32 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 14:00:13 +0100
Message-Id: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/3] sun4u: move fw_cfg/NVRAM devices to ebus
 PCI IO address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

The sun4u ebus is currently attached directly to the PCI host bridge meaning
some access is split between the ebus (ISA) IO space and system IO space. This
patchset moves the remaining fw_cfg/NVRAM devices into the ebus IO space in
preparation for moving the ebus device behind a PCI-PCI bridge.

Note: this patchset is dependent upon the fw_cfg patchset I recently
posted.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland>

Mark Cave-Ayland (3):
  sun4u: switch to using qdev to instantiate fw_cfg interface
  sun4u: expose fw_cfg on ebus PCI IO address space
  sun4u: expose NVRAM on ebus PCI IO address space

 hw/sparc64/sun4u.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
1.7.10.4
