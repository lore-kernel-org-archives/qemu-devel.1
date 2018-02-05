Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSr-00062E-PA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eieSq-0007BL-R1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:57:33 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Feb 2018 10:57:12 +0000
Message-Id: <20180205105720.14620-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/8] v8m: minor missing regs and bugfixes
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

This patchset is the result of comparing the registers
listed in the v8M Arm ARM against what QEMU was implementing.
It adds a collection of generally unexciting missing registers
(most of which we can simply NOP or make reads-as-written).
There are also a couple of bug fixes in there, of which the
worst is the byte-to-interrupt-number conversions being
completely wrong in several places. I think we didn't notice
that before because if you only deal with the bottom 32
interrupts then they're all in the first register in the
enable/pend/etc banks...

These patches sit on top of the derived-exceptions patchset,
but any conflicts should be purely textual.

Based-on: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>

thanks
-- PMM

Peter Maydell (8):
  hw/intc/armv7m_nvic: Don't hardcode M profile ID registers in NVIC
  hw/intc/armv7m_nvic: Fix ICSR PENDNMISET/CLR handling
  hw/intc/armv7m_nvic: Implement M profile cache maintenance ops
  hw/intc/armv7m_nvic: Implement v8M CPPWR register
  hw/intc/armv7m_nvic: Implement cache ID registers
  hw/intc/armv7m_nvic: Implement SCR
  target/arm: Implement writing to CONTROL_NS for v8M
  hw/intc/armv7m_nvic: Fix byte-to-interrupt number conversions

 target/arm/cpu.h      | 16 +++++++++
 hw/intc/armv7m_nvic.c | 95 +++++++++++++++++++++++++++++++++++++--------------
 target/arm/cpu.c      | 28 +++++++++++++++
 target/arm/helper.c   | 10 ++++++
 target/arm/machine.c  | 48 ++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 25 deletions(-)

-- 
2.16.1
