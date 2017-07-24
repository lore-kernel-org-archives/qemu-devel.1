Received: from eggs.gnu.org ([2001:4830:134:3::10]:55539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoM-0007DG-38
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoL-0001dz-3e
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dZgoK-0001cR-T7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoF-00008e-BU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:06:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 18:06:14 +0100
Message-Id: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue, mostly bug fixes to go into rc0.
The integratorcp and fsl_imx* changes are migration
compat breakers but that's ok for these boards.

thanks
-- PMM


The following changes since commit ce1d20aac8533357650774c2c240e30de87dc122:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-24' into staging (2017-07-24 16:20:47 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170724

for you to fetch changes up to b2d1b0507d1b80f23da12dd8aab56944fe380a09:

  integratorcp: Don't migrate flash using vmstate_register_ram_global() (2017-07-24 17:59:28 +0100)

----------------------------------------------------------------
target-arm queue:
 * fix a TCG temporary leak in aarch64 rev16
 * fsl_imx*: migrate the ROM contents
 * integratorcp: don't use vmstate_register_ram_global for flash
 * mps2: Correctly set parent bus for SCC device

----------------------------------------------------------------
Emilio G. Cota (1):
      target/arm: fix TCG temp leak in aarch64 rev16

Peter Maydell (3):
      fsl_imx*: Migrate ROM contents
      mps2: Correctly set parent bus for SCC device
      integratorcp: Don't migrate flash using vmstate_register_ram_global()

 hw/arm/fsl-imx25.c         | 4 ++--
 hw/arm/fsl-imx31.c         | 4 ++--
 hw/arm/fsl-imx6.c          | 4 ++--
 hw/arm/integratorcp.c      | 3 +--
 hw/arm/mps2.c              | 2 +-
 target/arm/translate-a64.c | 1 +
 6 files changed, 9 insertions(+), 9 deletions(-)
