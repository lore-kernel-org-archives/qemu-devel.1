Received: from eggs.gnu.org ([2001:4830:134:3::10]:37318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNs-0008AL-Sk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNs-0002nt-2r
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNr-0002my-Sq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNq-0002uA-TQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:07 +0000
Message-Id: <1516109659-1557-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/24] sdhci: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180115182436.2066-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h | 2 --
 hw/sd/sdhci.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 1335373..dacd726 100644
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
index b7d2a20..365bc80 100644
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
2.7.4
