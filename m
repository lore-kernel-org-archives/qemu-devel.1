Received: from eggs.gnu.org ([2001:4830:134:3::10]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMJ-0005qU-5j
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGME-00082P-FH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:39 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGME-00081r-B0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:34 -0500
Received: by mail-qt0-x243.google.com with SMTP id d4so5880792qtj.5
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:10 -0300
Message-Id: <20171213232025.24503-12-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/26] sdcard: use warn_report() instead of
 fprintf()
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
index c1ed7b59f1..2fa05f42b7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -725,7 +725,7 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
         sd->pwd_len = 0;
         /* Erasing the entire card here! */
-        fprintf(stderr, "SD: Card force-erased by CMD42\n");
+        warn_report("SD: Card force-erased by CMD42");
         return;
     }
 
-- 
2.15.1
