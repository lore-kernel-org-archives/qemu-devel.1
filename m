Received: from eggs.gnu.org ([2001:4830:134:3::10]:39835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR1-0002lS-Ra
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0001bd-KB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeR0-0001aI-Ci
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQz-00036i-Cf
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:14 +0100
Message-Id: <20180426104715.21702-19-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/19] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

commit 1d3e65aa7ac5 ("hw/timer: Add value matching support to
aspeed_timer") increased the vmstate version of aspeed.timer because
the state had changed, but it also bumped the version of the
VMSTATE_STRUCT_ARRAY under the aspeed.timerctrl which did not need to.

Change back this version to fix migration.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180423101433.17759-1-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 50acbf530a..1e31e22b6f 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -504,7 +504,7 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
-                             ASPEED_TIMER_NR_TIMERS, 2, vmstate_aspeed_timer,
+                             ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_timer,
                              AspeedTimer),
         VMSTATE_END_OF_LIST()
     }
-- 
2.17.0
