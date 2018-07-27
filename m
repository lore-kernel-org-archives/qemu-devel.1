Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15Q-0006Ii-4v
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15P-00050c-8r
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 12:38:53 +0100
Message-Id: <20180727113854.20283-2-peter.maydell@linaro.org>
In-Reply-To: <20180727113854.20283-1-peter.maydell@linaro.org>
References: <20180727113854.20283-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 1/2] armv7m_nvic: Fix m-security
 subsection name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The vmstate save/load code insists that subsections of a VMState must
have names which include their parent VMState's name as a leading
substring.  Unfortunately it neither documents this nor checks it on
device init or state save, but instead fails state load with a
confusing error message ("Missing section footer for armv7m_nvic").

Fix the name of the m-security subsection of the NVIC, so that
state save/load works correctly for the security-enabled NVIC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
