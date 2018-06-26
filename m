Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHG-00025s-Dn
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-0007Fd-II
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHF-0007Ej-Ad
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-00007x-9W
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:43 +0100
Message-Id: <20180626165658.31394-18-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/32] hw/net/stellaris_enet: Fix a typo
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
Message-id: 20180624040609.17572-12-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/stellaris_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 04bd10ada3f..1e7329517cf 100644
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
2.17.1
