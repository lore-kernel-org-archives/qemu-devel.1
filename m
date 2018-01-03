Received: from eggs.gnu.org ([2001:4830:134:3::10]:51809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXY-0002WX-Rv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXS-00081Z-KX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:36 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXS-00081K-DI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:30 -0500
Received: by mail-qt0-x244.google.com with SMTP id u10so3817481qtg.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:21 -0300
Message-Id: <20180103212436.15762-11-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/25] sdcard: remove unreachable code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d4aa7b4a92..c9fc6f5369 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1188,9 +1188,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            /* Writing in SPI mode not implemented.  */
-            if (sd->spi)
-                break;
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1214,9 +1211,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            /* Writing in SPI mode not implemented.  */
-            if (sd->spi)
-                break;
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
-- 
2.15.1
