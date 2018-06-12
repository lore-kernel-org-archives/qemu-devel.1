Received: from eggs.gnu.org ([2001:4830:134:3::10]:58956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3p-0002mK-7n
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3n-0001v0-05
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:48 +1000
Message-Id: <20180612064503.14282-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/33] mos6522: fix vmstate_mos6522_timer
 version in vmstate_mos6522
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This was accidentally introduced when extracting the 6522 VIA functionality
from the CUDA device, and prevents loadvm from completing successfully.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/mos6522.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 49166cb8ad..bcb306d357 100644
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
2.17.1
