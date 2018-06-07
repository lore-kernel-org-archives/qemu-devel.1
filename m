Received: from eggs.gnu.org ([2001:4830:134:3::10]:35228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY2-0002T8-FT
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyY0-0001kq-J0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:18:06 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 18:17:48 +0100
Message-Id: <20180607171751.11510-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/4] mos6522: fix vmstate_mos6522_timer version
 in vmstate_mos6522
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This was accidentally introduced when extracting the 6522 VIA functionality
from the CUDA device, and prevents loadvm from completing successfully.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mos6522.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 6163cea6ab..dd56c796e4 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -405,7 +405,7 @@ static const VMStateDescription vmstate_mos6522 = {
         VMSTATE_UINT8(ifr, MOS6522State),
         VMSTATE_UINT8(ier, MOS6522State),
         VMSTATE_UINT8(anh, MOS6522State),
-        VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 1,
+        VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
                              vmstate_mos6522_timer, MOS6522Timer),
         VMSTATE_END_OF_LIST()
     }
-- 
2.11.0
