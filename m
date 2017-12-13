Received: from eggs.gnu.org ([2001:4830:134:3::10]:60356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLe-0005GG-Vv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLe-0007Jt-0f
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:58 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLd-0007JE-S3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:57 -0500
Received: by mail-qk0-x243.google.com with SMTP id 8so4145405qkj.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:21:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:03 -0300
Message-Id: <20171213232025.24503-5-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/26] sdcard: replace fprintf() ->
 qemu_log_mask()
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
 hw/sd/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9b3745a019..6227a3518b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1557,14 +1557,16 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
     DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
             (unsigned long long) addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
-        fprintf(stderr, "sd_blk_read: read error on host side\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "sd_blk_read: read error on host side\n");
     }
 }
 
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
-        fprintf(stderr, "sd_blk_write: write error on host side\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "sd_blk_write: write error on host side\n");
     }
 }
 
-- 
2.15.1
