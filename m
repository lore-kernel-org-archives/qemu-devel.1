Received: from eggs.gnu.org ([2001:4830:134:3::10]:58325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmf-0004jR-Vn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmf-00053c-2q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:41 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRme-00053E-UJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id g14so1640739qti.2
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:08 -0300
Message-Id: <20180215221325.7611-4-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/20] sdcard: fix the 'maximum data
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

To comply with Spec v1.10 (and 2.00, 3.01):

. TRAN_SPEED

for current SD Memory Cards that field must be always 0_0110_010b (032h) which is
equal to 25MHz - the mandatory maximum operating frequency of SD Memory Card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c1ba098d86..14c1cb1332 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -358,7 +358,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-        sd->csd[3] = 0x5a;	/* Max. data transfer rate */
+        sd->csd[3] = 0x32;  /* Max. data transfer rate: 25 MHz */
         sd->csd[4] = 0x5f;	/* Card Command Classes */
         sd->csd[5] = 0x50 |	/* Max. read data block length */
             HWBLOCK_SHIFT;
-- 
2.16.1
