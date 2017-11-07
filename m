Received: from eggs.gnu.org ([2001:4830:134:3::10]:36830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41n-0006XL-Dq
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41m-0005zR-8r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41m-0005rx-1n
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:54 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41g-0004SG-Am
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:15 +0000
Message-Id: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 0/7] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A small set of arm bugfixes for rc0.



The following changes since commit 5853e92207193e967abf5e4c25b4a551c7604725:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20171107' into staging (2017-11-07 12:19:48 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171107

for you to fetch changes up to 8a7348b5d62d7ea16807e6bea54b448a0184bb0f:

  hw/intc/arm_gicv3_its: Don't abort on table save failure (2017-11-07 13:03:52 +0000)

----------------------------------------------------------------
target-arm queue:
 * arm_gicv3_its: Don't abort on table save failure
 * arm_gicv3_its: Fix the VM termination in vm_change_state_handler()
 * translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD
 * hw/arm: Mark the "fsl,imx31/25/6" devices with user_creatable = false
 * arm: implement cache/shareability attribute bits for PAR registers

----------------------------------------------------------------
Andrew Baumann (1):
      arm: implement cache/shareability attribute bits for PAR registers

Eric Auger (1):
      hw/intc/arm_gicv3_its: Don't abort on table save failure

Peter Maydell (1):
      translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD

Shanker Donthineni (1):
      hw/intc/arm_gicv3_its: Fix the VM termination in vm_change_state_handler()

Thomas Huth (3):
      hw/arm: Mark the "fsl,imx6" device with user_creatable = false
      hw/arm: Mark the "fsl,imx25" device with user_creatable = false
      hw/arm: Mark the "fsl,imx31" device with user_creatable = false

 hw/arm/fsl-imx25.c          |   6 +-
 hw/arm/fsl-imx31.c          |   6 +-
 hw/arm/fsl-imx6.c           |   3 +-
 hw/intc/arm_gicv3_its_kvm.c |  12 +--
 target/arm/helper.c         | 178 ++++++++++++++++++++++++++++++++++++++++----
 target/arm/translate.c      |  39 ++++++++--
 6 files changed, 214 insertions(+), 30 deletions(-)
