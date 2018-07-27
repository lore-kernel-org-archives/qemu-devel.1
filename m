Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15N-0006Gu-UB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fj15N-0004ya-6p
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:39:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 12:38:52 +0100
Message-Id: <20180727113854.20283-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 0/2] MPS/v8M bug fixes
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

This patchset fixes a couple of bugs I found in the v8M
and MPS board code:
 * migration wasn't working because of an incorrect
   subsection name in the NVIC vmstate
 * the timer1 IRQ line was miswired in the iotkit

Neither of these are strictly speaking regressions
from 2.12, but because they're so simple they seem
worth getting into 3.0 (especially the first one,
which means migration of any v8M system won't work
at all.)

thanks
-- PMM

Peter Maydell (2):
  armv7m_nvic: Fix m-security subsection name
  hw/arm/iotkit: Fix IRQ number for timer1

 hw/arm/iotkit.c       | 2 +-
 hw/intc/armv7m_nvic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1
