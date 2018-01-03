Received: from eggs.gnu.org ([2001:4830:134:3::10]:51562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXC-000295-14
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXB-0007p2-AU
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:14 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXA-0007oQ-TI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:13 -0500
Received: by mail-qk0-x243.google.com with SMTP id o126so3241472qke.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:17 -0300
Message-Id: <20180103212436.15762-7-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/25] sdcard: let cmd_valid_while_locked()
 returns a bool
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
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7bb5c6fb5e..b0e54f69d8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1549,7 +1549,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static bool cmd_valid_while_locked(SDState *sd, SDRequest *req)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1563,7 +1563,7 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
         return req->cmd == 41 || req->cmd == 42;
     }
     if (req->cmd == 16 || req->cmd == 55) {
-        return 1;
+        return true;
     }
     return sd_cmd_class[req->cmd] == 0
             || sd_cmd_class[req->cmd] == 7;
-- 
2.15.1
