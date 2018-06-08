Received: from eggs.gnu.org ([2001:4830:134:3::10]:50496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlo-00034E-HC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-0004GC-J3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGln-00046X-8Y
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlm-0003hD-2f
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:02 +0100
Message-Id: <20180608124517.29475-17-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/31] hw/digic: Add trailing '\n' to qemu_log()
 calls
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
Message-id: 20180606152128.449-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/digic-uart.c   | 4 ++--
 hw/timer/digic-timer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 6ebcb87a40d..ccc75eaa4df 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -60,7 +60,7 @@ static uint64_t digic_uart_read(void *opaque, hwaddr addr,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-uart: read access to unknown register 0x"
-                      TARGET_FMT_plx, addr << 2);
+                      TARGET_FMT_plx "\n", addr << 2);
     }
 
     return ret;
@@ -98,7 +98,7 @@ static void digic_uart_write(void *opaque, hwaddr addr, uint64_t value,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-uart: write access to unknown register 0x"
-                      TARGET_FMT_plx, addr << 2);
+                      TARGET_FMT_plx "\n", addr << 2);
     }
 }
 
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index e1fcf73c3e8..4d73077207b 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -73,7 +73,7 @@ static uint64_t digic_timer_read(void *opaque, hwaddr offset, unsigned size)
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-timer: read access to unknown register 0x"
-                      TARGET_FMT_plx, offset);
+                      TARGET_FMT_plx "\n", offset);
     }
 
     return ret;
@@ -109,7 +109,7 @@ static void digic_timer_write(void *opaque, hwaddr offset,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-timer: read access to unknown register 0x"
-                      TARGET_FMT_plx, offset);
+                      TARGET_FMT_plx "\n", offset);
     }
 }
 
-- 
2.17.1
