Received: from eggs.gnu.org ([209.51.188.92]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSaq-00010a-3N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSap-0002AG-5T
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSao-000292-TT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id k16so20992005wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 14:14:35 +0100
Message-Id: <20190430131439.25251-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] target/arm: four minor M-profile bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

These patches are fixes for some minor bugs that I noticed while
writing and testing the M-profile FPU support. They're not FPU
related, so I didn't want to mix them up with that large patchset...

thanks
-- PMM

Peter Maydell (4):
  hw/arm/armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
  hw/intc/armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
  hw/intc/armv7m_nvic: Don't enable ARMV7M_EXCP_DEBUG from reset
  target/arm: Implement XPSR GE bits

 target/arm/cpu.h      |  4 ++++
 hw/intc/armv7m_nvic.c | 40 ++++++++++++++++++++++++++++++++++------
 target/arm/helper.c   | 12 ++++++++++--
 3 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.20.1
