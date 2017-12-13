Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLk-0005KG-2x
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLi-0007Q8-3i
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:04 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGLh-0007PZ-Vs
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:02 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so5823261qtr.13
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:04 -0300
Message-Id: <20171213232025.24503-6-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/26] sdcard: rename sd_set_mode() ->
 sd_update_mode()
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

This will ease to trace mode changes (in the following patchs).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6227a3518b..f63459d2c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -128,7 +128,7 @@ struct SDState {
     bool enable;
 };
 
-static void sd_set_mode(SDState *sd)
+static void sd_update_mode(SDState *sd)
 {
     switch (sd->state) {
     case sd_inactive_state:
@@ -1470,7 +1470,7 @@ int sd_do_command(SDState *sd, SDRequest *req, uint8_t *response)
     }
 
     last_state = sd->state;
-    sd_set_mode(sd);
+    sd_update_mode(sd);
 
     if (sd->expecting_acmd) {
         sd->expecting_acmd = false;
-- 
2.15.1
