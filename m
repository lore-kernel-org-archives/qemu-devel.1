Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA7-0008RK-U3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA7-0005PK-59
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA7-0005Oy-0Q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:15 -0400
Received: by mail-qk0-x242.google.com with SMTP id c64so1793596qkf.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 23:01:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 03:01:01 -0300
Message-Id: <20180509060104.4458-2-f4bug@amsat.org>
In-Reply-To: <20180509060104.4458-1-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] sdcard: Update the SDState documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Add more descriptive comments to keep a clear separation
between static property vs runtime changeable.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..5fb4787671 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -90,12 +90,15 @@ struct SDState {
     uint32_t card_status;
     uint8_t sd_status[64];
 
-    /* Configurable properties */
+    /* Static properties */
+
     BlockBackend *blk;
     bool spi;
 
-    uint32_t mode;    /* current card mode, one of SDCardModes */
-    int32_t state;    /* current card state, one of SDCardStates */
+    /* Runtime changeables */
+
+    uint32_t mode;    /** current card mode, one of #SDCardModes */
+    int32_t state;    /** current card state, one of #SDCardStates */
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_groups;
@@ -109,8 +112,9 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
     uint8_t current_cmd;
-    /* True if we will handle the next command as an ACMD. Note that this does
-     * *not* track the APP_CMD status bit!
+    /**
+     * #True if we will handle the next command as an ACMD.
+     * Note that this does *not* track the APP_CMD status bit!
      */
     bool expecting_acmd;
     uint32_t blk_written;
-- 
2.17.0
