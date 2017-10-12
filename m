Received: from eggs.gnu.org ([2001:4830:134:3::10]:44050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxO-0003HO-D3
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxN-0004Yj-Iz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxN-0004Xg-Aq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxL-0000bN-49
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:23 +0100
Message-Id: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue:
 * mostly my latest v8M stuff, plus a couple of minor patches

The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2017-10-12 10:02:09 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171012

for you to fetch changes up to cf5f7937b05c84d5565134f058c00cd48304a117:

  nvic: Fix miscalculation of offsets into ITNS array (2017-10-12 16:33:16 +0100)

----------------------------------------------------------------
target-arm queue:
 * v8M: SG, BLXNS, secure-return
 * v8M: fixes for coverity issues in previous patches
 * arm: fix armv7m_init() declaration to match definition
 * watchdog/aspeed: fix variable type to store reload value

----------------------------------------------------------------
Cédric Le Goater (1):
      watchdog/aspeed: fix variable type to store reload value

Igor Mammedov (1):
      arm: fix armv7m_init() declaration to match definition

Peter Maydell (11):
      target/arm: Add M profile secure MMU index values to get_a32_user_mem_index()
      target/arm: Implement SG instruction
      target/arm: Implement BLXNS
      target/arm: Implement secure function return
      target-arm: Don't check for "Thumb2 or M profile" for not-Thumb1
      target/arm: Pull Thumb insn word loads up to top level
      target-arm: Simplify insn_crosses_page()
      target/arm: Support some Thumb insns being always unconditional
      target/arm: Implement SG instruction corner cases
      nvic: Add missing 'break'
      nvic: Fix miscalculation of offsets into ITNS array

 include/hw/arm/arm.h     |   2 +-
 target/arm/helper.h      |   1 +
 target/arm/internals.h   |   8 ++
 hw/intc/armv7m_nvic.c    |   5 +-
 hw/watchdog/wdt_aspeed.c |   4 +-
 target/arm/helper.c      | 306 ++++++++++++++++++++++++++++++++++++++++++++--
 target/arm/translate.c   | 310 ++++++++++++++++++++++++++++++++---------------
 7 files changed, 521 insertions(+), 115 deletions(-)
