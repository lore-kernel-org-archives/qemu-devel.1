Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-00038A-Mz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlq-0004Ka-PT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlq-0004Hv-IO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlp-0003ja-5g
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:06 +0100
Message-Id: <20180608124517.29475-21-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/31] hw/mips/boston: Add trailing '\n' to
 qemu_log() calls
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
Message-id: 20180606152128.449-7-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/boston.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 5302e5c8856..52cce197667 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -176,7 +176,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
     uint32_t gic_freq, val;
 
     if (size != 4) {
-        qemu_log_mask(LOG_UNIMP, "%uB platform register read", size);
+        qemu_log_mask(LOG_UNIMP, "%uB platform register read\n", size);
         return 0;
     }
 
@@ -205,7 +205,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
         val |= PLAT_DDR_CFG_MHZ;
         return val;
     default:
-        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx,
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx "\n",
                       addr & 0xffff);
         return 0;
     }
@@ -215,7 +215,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
     if (size != 4) {
-        qemu_log_mask(LOG_UNIMP, "%uB platform register write", size);
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
         return;
     }
 
@@ -237,7 +237,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
-                      " = 0x%" PRIx64, addr & 0xffff, val);
+                      " = 0x%" PRIx64 "\n", addr & 0xffff, val);
         break;
     }
 }
-- 
2.17.1
