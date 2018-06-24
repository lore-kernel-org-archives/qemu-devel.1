Received: from eggs.gnu.org ([2001:4830:134:3::10]:42767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIz-0004Ok-FI
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIv-0004P6-3Y
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:07:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:06:09 -0300
Message-Id: <20180624040609.17572-17-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/16] hw/arm/stellaris: Use HWADDR_PRIx to
 display register address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stellaris.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 42baa768b2..dc521b4a5a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -212,7 +212,8 @@ static uint64_t gptm_read(void *opaque, hwaddr offset,
         return 0;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "GPTM: read at bad offset 0x%x\n", (int)offset);
+                      "GPTM: read at bad offset 0x02%" HWADDR_PRIx "\n",
+                      offset);
         return 0;
     }
 }
@@ -294,7 +295,8 @@ static void gptm_write(void *opaque, hwaddr offset,
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "GPTM: write at bad offset 0x%x\n", (int)offset);
+                      "GPTM: write at bad offset 0x02%" HWADDR_PRIx "\n",
+                      offset);
     }
     gptm_update_irq(s);
 }
-- 
2.18.0
