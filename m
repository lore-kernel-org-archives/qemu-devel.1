Received: from eggs.gnu.org ([2001:4830:134:3::10]:37668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIU-0003EX-0h
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIQ-0007ix-V1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:54 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIQ-0007id-R5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:50 -0500
Received: by mail-qt0-x244.google.com with SMTP id c2so26485530qtn.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:19 -0300
Message-Id: <20180123033034.29493-4-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/18] sdcard: fix the 'maximum data
 transfer rate' to 25MHz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

To comply with Spec v1.10 (and 2.00, 3.01):

. TRAN_SPEED

for current SD Memory Cards that field must be always 0_0110_010b (032h) which is
equal to 25MHz - the mandatory maximum operating frequency of SD Memory Card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f6318c6fdb..56df5b660a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -356,7 +356,7 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-        sd->csd[3] = 0x5a;	/* Max. data transfer rate */
+        sd->csd[3] = 0x32;  /* Max. data transfer rate: 25 MHz */
         sd->csd[4] = 0x5f;	/* Card Command Classes */
         sd->csd[5] = 0x50 |	/* Max. read data block length */
             HWBLOCK_SHIFT;
-- 
2.15.1
