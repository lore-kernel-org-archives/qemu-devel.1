Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zq-00011O-HQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zp-0002QD-Nn
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fk8zp-00029y-FZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zg-0004Fw-5Q
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:17:52 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:17:45 +0100
Message-Id: <20180730141748.430-4-peter.maydell@linaro.org>
In-Reply-To: <20180730141748.430-1-peter.maydell@linaro.org>
References: <20180730141748.430-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 3/6] armv7m_nvic: Fix m-security subsection name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The vmstate save/load code insists that subsections of a VMState must
have names which include their parent VMState's name as a leading
substring.  Unfortunately it neither documents this nor checks it on
device init or state save, but instead fails state load with a
confusing error message ("Missing section footer for armv7m_nvic").

Fix the name of the m-security subsection of the NVIC, so that
state save/load works correctly for the security-enabled NVIC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180727113854.20283-2-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6be7fc5266d..cd1e7f17299 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2064,7 +2064,7 @@ static int nvic_security_post_load(void *opaque, int version_id)
 }
 
 static const VMStateDescription vmstate_nvic_security = {
-    .name = "nvic/m-security",
+    .name = "armv7m_nvic/m-security",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = nvic_security_needed,
-- 
2.17.1
