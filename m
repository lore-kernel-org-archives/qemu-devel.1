Received: from eggs.gnu.org ([2001:4830:134:3::10]:51997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXo-0002kq-9b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXb-000877-P8
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:52 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXb-00086n-Gt
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:39 -0500
Received: by mail-qt0-x242.google.com with SMTP id r39so3779613qtr.13
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:23 -0300
Message-Id: <20180103212436.15762-13-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/25] sdcard: use a 16-bit integer for the
 16-bit RCA register
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
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e0550cd174..e6a6e0b2ad 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -854,7 +854,7 @@ static void sd_lock_command(SDState *sd)
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint32_t rca = 0x0000;
+    uint16_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     if (req.cmd != 55 || sd->expecting_acmd) {
-- 
2.15.1
