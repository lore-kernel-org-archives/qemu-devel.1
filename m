Received: from eggs.gnu.org ([2001:4830:134:3::10]:55988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iq-0001cn-Rc
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9iq-0003gr-3t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dc9ip-0003ax-TB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:22:56 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dc9ij-0000uM-9b
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:22:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 13:22:45 +0100
Message-Id: <1501503765-15639-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] hw/mps2_scc: fix incorrect properties
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
Message-id: 20170729234930.725-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index cc58d26..32be2a9 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -270,9 +270,9 @@ static Property mps2_scc_properties[] = {
     /* Values for various read-only ID registers (which are specific
      * to the board model or FPGA image)
      */
-    DEFINE_PROP_UINT32("scc-cfg4", MPS2SCC, aid, 0),
+    DEFINE_PROP_UINT32("scc-cfg4", MPS2SCC, cfg4, 0),
     DEFINE_PROP_UINT32("scc-aid", MPS2SCC, aid, 0),
-    DEFINE_PROP_UINT32("scc-id", MPS2SCC, aid, 0),
+    DEFINE_PROP_UINT32("scc-id", MPS2SCC, id, 0),
     /* These are the initial settings for the source clocks on the board.
      * In hardware they can be configured via a config file read by the
      * motherboard configuration controller to suit the FPGA image.
-- 
2.7.4
