Received: from eggs.gnu.org ([2001:4830:134:3::10]:58101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zm-00010N-MQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zl-0002Kf-SY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:17:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fk8zl-00029y-Kn
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:17:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8ze-0004Ei-1Q
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:17:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:17:42 +0100
Message-Id: <20180730141748.430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A set of small bugfixes for arm for 3.0; the "migration was
broken" fixes for SMMUv3 and v7M NVIC with security extensions
are the most significant.

thanks
-- PMM

The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180730

for you to fetch changes up to 0261fb805c00a6f97d143235e7b06b0906bdf898:

  target/arm: Remove duplicate 'host' entry in '-cpu ?' output (2018-07-30 15:07:08 +0100)

----------------------------------------------------------------
target-arm queue:
 * arm/smmuv3: Fix broken VM state migration
 * armv7m_nvic: Fix broken VM state migration
 * hw/arm/sysbus-fdt: Fix assertion in copy_properties_from_host()
 * hw/arm/iotkit: Fix IRQ number for timer1
 * hw/misc/tz-mpc: Zero the LUT on initialization, not just reset
 * target/arm: Remove duplicate 'host' entry in '-cpu ?' output

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      arm/smmuv3: Fix missing VMSD terminator

Geert Uytterhoeven (1):
      hw/arm/sysbus-fdt: Fix assertion in copy_properties_from_host()

Peter Maydell (3):
      armv7m_nvic: Fix m-security subsection name
      hw/arm/iotkit: Fix IRQ number for timer1
      hw/misc/tz-mpc: Zero the LUT on initialization, not just reset

Philippe Mathieu-Daudé (1):
      target/arm: Remove duplicate 'host' entry in '-cpu ?' output

 hw/arm/iotkit.c       | 2 +-
 hw/arm/smmuv3.c       | 1 +
 hw/arm/sysbus-fdt.c   | 1 +
 hw/intc/armv7m_nvic.c | 2 +-
 hw/misc/tz-mpc.c      | 2 +-
 target/arm/helper.c   | 6 ------
 6 files changed, 5 insertions(+), 9 deletions(-)
