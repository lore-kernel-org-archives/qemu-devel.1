Received: from eggs.gnu.org ([2001:4830:134:3::10]:39327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG8-0004mA-9Q
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG6-0003hx-K0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:24 -0300
Message-Id: <20180606152128.449-8-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] stellaris: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stellaris.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index e886f54976..502a20842c 100644
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
