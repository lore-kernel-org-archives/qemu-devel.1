Received: from eggs.gnu.org ([2001:4830:134:3::10]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1feoOe-0007H9-GH
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1feoOb-0004sC-Hs
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:17:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:25834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1feoOb-0004qb-Ad
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:17:33 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 15 Jul 2018 22:59:21 +0200
Message-Id: <20180715211731.311B67456B5@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH for 3.0] sm501: Fix warning about unreachable
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

Coverity warned that the false arm of conditional expression is
unreachable when it is inside an if with the same condition.
Remove the unreachable code to avoid the warning.

Fixes: CID 1394215
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9ab29d3..874260a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1024,7 +1024,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                         if (res) {
                             SM501_DPRINTF("sm501 i2c : transfer failed"
                                           " i=%d, res=%d\n", i, res);
-                            s->i2c_status |= (res ? SM501_I2C_STATUS_ERROR : 0);
+                            s->i2c_status |= SM501_I2C_STATUS_ERROR;
                             return;
                         }
                     }
-- 
2.7.6
