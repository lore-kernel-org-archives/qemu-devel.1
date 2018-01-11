Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYf-0002c0-D6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYe-0005DI-L3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:37 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYe-0005Cr-GV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:36 -0500
Received: by mail-qk0-x242.google.com with SMTP id a5so2942685qkg.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:30:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 16:30:10 -0300
Message-Id: <20180111193021.17466-3-f4bug@amsat.org>
In-Reply-To: <20180111193021.17466-1-f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/13] sdhci: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/sd/sdhci.h | 2 --
 hw/sd/sdhci.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 1335373d3c..dacd726537 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -44,8 +44,6 @@ typedef struct SDHCIState {
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
-    qemu_irq eject_cb;
-    qemu_irq ro_cb;
     qemu_irq irq;
 
     /* Registers cleared on reset */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b7d2a20985..365bc80009 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1200,8 +1200,6 @@ static void sdhci_uninitfn(SDHCIState *s)
     timer_free(s->insert_timer);
     timer_del(s->transfer_timer);
     timer_free(s->transfer_timer);
-    qemu_free_irq(s->eject_cb);
-    qemu_free_irq(s->ro_cb);
 
     g_free(s->fifo_buffer);
     s->fifo_buffer = NULL;
-- 
2.15.1
