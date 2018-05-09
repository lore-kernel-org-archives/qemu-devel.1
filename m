Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4Q-0004MQ-Dq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4P-0002O6-Ks
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4P-0002NJ-Fv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:13 -0400
Received: by mail-qk0-x243.google.com with SMTP id c11so2817309qkm.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:46 -0300
Message-Id: <20180509034658.26455-3-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/14] sdcard: Constify sd_crc*()'s message
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..eb6dd5482e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -236,11 +236,11 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
 };
 
-static uint8_t sd_crc7(void *message, size_t width)
+static uint8_t sd_crc7(const void *message, size_t width)
 {
     int i, bit;
     uint8_t shift_reg = 0x00;
-    uint8_t *msg = (uint8_t *) message;
+    const uint8_t *msg = (const uint8_t *)message;
 
     for (i = 0; i < width; i ++, msg ++)
         for (bit = 7; bit >= 0; bit --) {
@@ -252,11 +252,11 @@ static uint8_t sd_crc7(void *message, size_t width)
     return shift_reg;
 }
 
-static uint16_t sd_crc16(void *message, size_t width)
+static uint16_t sd_crc16(const void *message, size_t width)
 {
     int i, bit;
     uint16_t shift_reg = 0x0000;
-    uint16_t *msg = (uint16_t *) message;
+    const uint16_t *msg = (const uint16_t *)message;
     width <<= 1;
 
     for (i = 0; i < width; i ++, msg ++)
-- 
2.17.0
