Received: from eggs.gnu.org ([2001:4830:134:3::10]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyok-0004HF-Ln
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoh-0007vE-Ko
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:38 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoh-0007ux-GT
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:35 -0500
Received: by mail-qk0-x241.google.com with SMTP id a8so16162842qkb.8
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:51:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:28 -0300
Message-Id: <20171229174933.1781-38-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 37/42] sdhci: remove the deprecated
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
index 38f26788df..8087e85589 100644
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
@@ -1341,9 +1339,6 @@ static Property sdhci_properties[] = {
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
