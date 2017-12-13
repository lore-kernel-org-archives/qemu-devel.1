Received: from eggs.gnu.org ([2001:4830:134:3::10]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN7-0006fe-Qq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN6-0000Ws-Om
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:29 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN6-0000WM-I1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:28 -0500
Received: by mail-qk0-x244.google.com with SMTP id z203so4157663qkb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:23 -0300
Message-Id: <20171213232025.24503-25-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 24/26] sdcard: use a 16-bit type for the 16-bit
 RCA register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b8a5a344f5..9b90987d7f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -844,7 +844,7 @@ static void sd_lock_command(SDState *sd)
 static sd_rsp_type_t sd_normal_command(SDState *sd,
                                        SDRequest req)
 {
-    uint32_t rca = 0x0000;
+    uint16_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     if (req.cmd != 55 || sd->expecting_acmd) {
-- 
2.15.1
