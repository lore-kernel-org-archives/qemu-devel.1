Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIn-0003VU-IS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIm-00081q-NN
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:13 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIm-00081X-JS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:12 -0500
Received: by mail-qt0-x241.google.com with SMTP id c2so26487178qtn.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:26 -0300
Message-Id: <20180123033034.29493-11-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/18] sdcard: handle CMD54 (SDIO)
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

Linux uses it to poll the bus before polling for a card.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 07424aa56e..bbf9496e8a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1378,9 +1378,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 52:
-    case 53:
-        /* CMD52, CMD53: reserved for SDIO cards
+    case 52 ... 54:
+        /* CMD52, CMD53, CMD54: reserved for SDIO cards
          * (see the SDIO Simplified Specification V2.0)
          * Handle as illegal command but do not complain
          * on stderr, as some OSes may use these in their
-- 
2.15.1
