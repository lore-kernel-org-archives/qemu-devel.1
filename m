Received: from eggs.gnu.org ([2001:4830:134:3::10]:44146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxS-0003IZ-9z
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxR-0004bZ-8n
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxR-0004Xg-2o
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxL-0000bb-Ms
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:24 +0100
Message-Id: <1507824216-29058-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/13] watchdog/aspeed: fix variable type to
 store reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

Initially from Anton D. Kachalov" <mouse@yandex-team.ru> but the SoB was
missing.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20170920064915.30027-1-clg@kaod.org
[clg: change commit log and subject
      replace UL suffix by ULL ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 22bce36..95f6ad1 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -100,13 +100,13 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
 
 static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
 {
-    uint32_t reload;
+    uint64_t reload;
 
     if (pclk) {
         reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
                           s->pclk_freq);
     } else {
-        reload = s->regs[WDT_RELOAD_VALUE] * 1000;
+        reload = s->regs[WDT_RELOAD_VALUE] * 1000ULL;
     }
 
     if (aspeed_wdt_is_enabled(s)) {
-- 
2.7.4
