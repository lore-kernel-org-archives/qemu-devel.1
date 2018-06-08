Received: from eggs.gnu.org ([2001:4830:134:3::10]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGll-000316-GP
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlk-0004E4-Q6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlk-0004D2-IC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlj-0003fb-7r
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:58 +0100
Message-Id: <20180608124517.29475-13-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/31] ftgmac100: remove check on runt messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

This is a ethernet wire limitation not needed in emulation. It breaks
U-Boot n/w stack also.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180530061711.23673-5-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 8a7f274dc11..909c1182eeb 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -822,12 +822,6 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         return size;
     }
 
-    if (size < 64 && !(s->maccr & FTGMAC100_MACCR_RX_RUNT)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped runt frame of %zd bytes\n",
-                      __func__, size);
-        return size;
-    }
-
     if (!ftgmac100_filter(s, buf, size)) {
         return size;
     }
-- 
2.17.1
