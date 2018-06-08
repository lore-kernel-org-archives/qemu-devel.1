Received: from eggs.gnu.org ([2001:4830:134:3::10]:50598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-00038V-Us
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-0004Kp-6A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlq-0004K4-UJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlp-0003kC-Rn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:07 +0100
Message-Id: <20180608124517.29475-22-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/31] stellaris: Add trailing '\n' to
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
Message-id: 20180606152128.449-8-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index e886f54976a..502a20842c0 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -203,11 +203,11 @@ static uint64_t gptm_read(void *opaque, hwaddr offset,
             return s->rtc;
         }
         qemu_log_mask(LOG_UNIMP,
-                      "GPTM: read of TAR but timer read not supported");
+                      "GPTM: read of TAR but timer read not supported\n");
         return 0;
     case 0x4c: /* TBR */
         qemu_log_mask(LOG_UNIMP,
-                      "GPTM: read of TBR but timer read not supported");
+                      "GPTM: read of TBR but timer read not supported\n");
         return 0;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -836,11 +836,12 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
         break;
     case 0x20: /* MCR */
         if (value & 1) {
-            qemu_log_mask(LOG_UNIMP, "stellaris_i2c: Loopback not implemented");
+            qemu_log_mask(LOG_UNIMP,
+                          "stellaris_i2c: Loopback not implemented\n");
         }
         if (value & 0x20) {
             qemu_log_mask(LOG_UNIMP,
-                          "stellaris_i2c: Slave mode not implemented");
+                          "stellaris_i2c: Slave mode not implemented\n");
         }
         s->mcr = value & 0x31;
         break;
@@ -1124,7 +1125,7 @@ static void stellaris_adc_write(void *opaque, hwaddr offset,
         s->sspri = value;
         break;
     case 0x28: /* PSSI */
-        qemu_log_mask(LOG_UNIMP, "ADC: sample initiate unimplemented");
+        qemu_log_mask(LOG_UNIMP, "ADC: sample initiate unimplemented\n");
         break;
     case 0x30: /* SAC */
         s->sac = value;
-- 
2.17.1
