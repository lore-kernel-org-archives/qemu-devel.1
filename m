Received: from eggs.gnu.org ([2001:4830:134:3::10]:38468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosih-0004u2-6p
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosig-0001lJ-Ap
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosig-0001ke-3U
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:38 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosif-00024i-6E
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:37 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:54 +0000
Message-Id: <20180222152307.7499-20-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/32] sdcard: fix the 'maximum data transfer
 rate' to 25MHz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

To comply with Spec v1.10 (and 2.00, 3.01):

. TRAN_SPEED

for current SD Memory Cards that field must be always 0_0110_010b (032h) which is
equal to 25MHz - the mandatory maximum operating frequency of SD Memory Card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-4-f4bug@amsat.org
[PMM: fixed comment indent]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 110f2f1d0a..3526269dbe 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -357,7 +357,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-        sd->csd[3] = 0x5a;	/* Max. data transfer rate */
+        sd->csd[3] = 0x32;      /* Max. data transfer rate: 25 MHz */
         sd->csd[4] = 0x5f;	/* Card Command Classes */
         sd->csd[5] = 0x50 |	/* Max. read data block length */
             HWBLOCK_SHIFT;
-- 
2.16.1
