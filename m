Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlC-0003ci-RC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlC-0004oo-1b
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:38 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:51 +0100
Message-Id: <1501692241-23310-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/15] hw/intc/armv7m_nvic.c: Remove out of
 date comment
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

Remove an out of date comment which says there's only one
item in the NVIC container region -- we put systick into its
own device object a while back and so now there are two
things in the container.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 323e2d4..2e8166a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1036,10 +1036,6 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
      *  0xd00..0xd3c - SCS registers
      *  0xd40..0xeff - Reserved or Not implemented
      *  0xf00 - STIR
-     *
-     * At the moment there is only one thing in the container region,
-     * but we leave it in place to allow us to pull systick out into
-     * its own device object later.
      */
     memory_region_init(&s->container, OBJECT(s), "nvic", 0x1000);
     /* The system register region goes at the bottom of the priority
-- 
2.7.4
