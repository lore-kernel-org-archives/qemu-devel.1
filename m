Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd45-0007Wz-VW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-00008X-Si
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd41-00007C-MA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-0005hC-GH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:36 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:11 +0000
Message-Id: <1515677902-23436-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/26] imx_fec: Use MIN instead of explicit
 ternary operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 50da91b..6feda18 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1076,7 +1076,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
                           TYPE_IMX_FEC, __func__);
             break;
         }
-        buf_len = (size <= s->regs[ENET_MRBR]) ? size : s->regs[ENET_MRBR];
+        buf_len = MIN(size, s->regs[ENET_MRBR]);
         bd.length = buf_len;
         size -= buf_len;
 
-- 
2.7.4
