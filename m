Received: from eggs.gnu.org ([2001:4830:134:3::10]:37446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0e-0008Gj-G0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0d-0006HJ-MN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:28 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eGq0d-0006H1-Ep
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:27 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0b-0006MN-Ji
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:37:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:37:19 +0000
Message-Id: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] target-arm queue for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A small set of bugfixes for rc2. (Some are patches I
should have put into rc1 but forgot about; oops.)

thanks
-- PMM


The following changes since commit b11ce33fe0266f8ede18cfcf961536f6a209b02b:

  Revert "cpu-exec: don't overwrite exception_index" (2017-11-20 10:58:27 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171120

for you to fetch changes up to b350ae138fcb062f49904f5115cc5fe188a02906:

  hw/arm: Silence xlnx-ep108 deprecation warning during tests (2017-11-20 13:48:27 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm: Silence xlnx-ep108 deprecation warning during tests
 * hw/arm/aspeed: Unlock SCU when running kernel
 * arm: check regime, not current state, for ATS write PAR format
 * nvic: Fix ARMv7M MPU_RBAR reads
 * target/arm: Report GICv3 sysregs present in ID registers if needed

----------------------------------------------------------------
Joel Stanley (1):
      hw/arm/aspeed: Unlock SCU when running kernel

Peter Maydell (3):
      target/arm: Report GICv3 sysregs present in ID registers if needed
      nvic: Fix ARMv7M MPU_RBAR reads
      arm: check regime, not current state, for ATS write PAR format

Thomas Huth (1):
      hw/arm: Silence xlnx-ep108 deprecation warning during tests

 include/hw/misc/aspeed_scu.h |  3 +++
 hw/arm/aspeed.c              |  9 +++++++++
 hw/arm/aspeed_soc.c          |  2 ++
 hw/arm/xlnx-zcu102.c         |  7 +++++--
 hw/intc/armv7m_nvic.c        |  2 +-
 hw/misc/aspeed_scu.c         |  5 +++--
 target/arm/helper.c          | 46 +++++++++++++++++++++++++++++++++++++++-----
 7 files changed, 64 insertions(+), 10 deletions(-)
