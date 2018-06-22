Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMJV-0006Mf-4w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWMJU-0003j2-Cu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:41:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Jun 2018 10:40:35 -0300
Message-Id: <20180622134036.23182-14-f4bug@amsat.org>
In-Reply-To: <20180622134036.23182-1-f4bug@amsat.org>
References: <20180622134036.23182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/14] hw/net/smc91c111: Use
 qemu_log_mask(UNIMP) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/smc91c111.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 9094c0b47c..d2fd2040e8 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -362,10 +362,14 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
             SET_HIGH(gpr, value);
             return;
         case 12: /* Control */
-            if (value & 1)
-                fprintf(stderr, "smc91c111:EEPROM store not implemented\n");
-            if (value & 2)
-                fprintf(stderr, "smc91c111:EEPROM reload not implemented\n");
+            if (value & 1) {
+                qemu_log_mask(LOG_UNIMP,
+                              "smc91c111: EEPROM store not implemented\n");
+            }
+            if (value & 2) {
+                qemu_log_mask(LOG_UNIMP,
+                              "smc91c111: EEPROM reload not implemented\n");
+            }
             value &= ~3;
             SET_LOW(ctr, value);
             return;
-- 
2.18.0.rc2
