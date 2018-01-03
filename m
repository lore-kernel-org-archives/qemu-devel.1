Received: from eggs.gnu.org ([2001:4830:134:3::10]:34196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnss-0003ka-Bk
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsr-0007ux-L1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:26 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsr-0007uW-2X
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:25 -0500
Received: by mail-qt0-x241.google.com with SMTP id k19so3221805qtj.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:35:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:13 -0300
Message-Id: <20180103183418.23730-21-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 20/25] sdhci: remove the deprecated
 'capareg' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

All SDHCI consumers have been upgraded to set correct properties.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2bd3c5a4b9..2b63ff1891 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1195,9 +1195,7 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
         s->cap.sdma = s->cap.adma1 = s->cap.adma2 = false;
     }
 
-    if (s->capareg == UINT64_MAX) {
-        sdhci_init_capareg(s, errp);
-    }
+    sdhci_init_capareg(s, errp);
 }
 
 static void sdhci_initfn(SDHCIState *s)
@@ -1347,9 +1345,6 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_UINT8("bus-speed", SDHCIState, cap.sdr, 0),
     DEFINE_PROP_UINT8("driver-strength", SDHCIState, cap.strength, 0),
 
-    /* capareg: deprecated */
-    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
-
     DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.15.1
