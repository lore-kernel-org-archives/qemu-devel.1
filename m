Received: from eggs.gnu.org ([2001:4830:134:3::10]:33539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdk-0007Bb-R6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdj-0000Vw-PM
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:44 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:52 -0800
Message-Id: <20171106154813.19936-10-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/30] imx_fec: Fix a typo in
 imx_enet_receive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/net/imx_fec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eefb3b2c62..48d012cad6 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1121,7 +1121,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         size += 2;
     }
 
-    /* Huge frames are truncted.  */
+    /* Huge frames are truncated. */
     if (size > s->regs[ENET_FTRL]) {
         size = s->regs[ENET_FTRL];
         flags |= ENET_BD_TR | ENET_BD_LG;
-- 
2.13.6
