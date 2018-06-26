Received: from eggs.gnu.org ([2001:4830:134:3::10]:52007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHK-00029w-5S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHJ-0007I6-EE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHJ-0007HC-6K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHH-0000Ah-So
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:48 +0100
Message-Id: <20180626165658.31394-23-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/32] hw/arm/stellaris: Use HWADDR_PRIx to
 display register address
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

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180624040609.17572-17-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 42baa768b2d..dc521b4a5a8 100644
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
2.17.1
