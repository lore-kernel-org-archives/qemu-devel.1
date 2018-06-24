Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIi-00046A-G9
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIh-0004EC-Li
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:06:04 -0300
Message-Id: <20180624040609.17572-12-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/16] hw/net/stellaris_enet: Fix a typo
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

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/stellaris_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 04bd10ada3..1e7329517c 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -340,7 +340,7 @@ static uint64_t stellaris_enet_read(void *opaque, hwaddr offset,
         return s->np;
     case 0x38: /* TR */
         return 0;
-    case 0x3c: /* Undocuented: Timestamp? */
+    case 0x3c: /* Undocumented: Timestamp? */
         return 0;
     default:
         hw_error("stellaris_enet_read: Bad offset %x\n", (int)offset);
-- 
2.18.0
