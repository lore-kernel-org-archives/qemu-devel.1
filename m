Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fLizA-00041g-Oz
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fLiz7-0004pn-MC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 01:40:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 24 May 2018 06:39:58 +0100
Message-Id: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] prep: fix keyboard for the 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, f4bug@amsat.org, david@gibson.dropbear.id.au

Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (8042)"
added an 8042 keyboard device to the PC87312 superio device to replace that
being used by the prep machine.

Unfortunately this commit didn't do the same for the 40p machine which broke
the keyboard by registering two 8042 keyboard devices at the same address.

Resolve this by similarly removing the 8042 keyboard from the 40p machine as
done for the prep machine in commit 72d3d8f052.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index a1e7219db6..be4db6a687 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -770,7 +770,6 @@ static void ibm_40p_init(MachineState *machine)
 
     /* add some more devices */
     if (defaults_enabled()) {
-        isa_create_simple(isa_bus, TYPE_I8042);
         m48t59 = NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
 
         dev = DEVICE(isa_create(isa_bus, "cs4231a"));
-- 
2.11.0
