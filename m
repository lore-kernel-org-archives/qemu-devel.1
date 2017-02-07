Received: from eggs.gnu.org ([2001:4830:134:3::10]:60977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe0-0007W3-C6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdz-0002is-1Q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAdy-0002gg-QJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdq-0005RZ-C4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:12 +0000
Message-Id: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
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

A random mix of items here, nothing very major.

thanks
-- PMM


The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170207

for you to fetch changes up to 7727b832886fafbdec7299eb7773dc9071bf4cdd:

  stellaris: Use the 'unimplemented' device for parts we don't implement (2017-02-07 18:30:00 +0000)

----------------------------------------------------------------
target-arm:
 * new "unimplemented" device for stubbing out devices in a
   system model so accesses can be logged
 * stellaris: document the SoC memory map
 * arm: create instruction syndromes for AArch32 data aborts
 * arm: Correctly handle watchpoints for BE32 CPUs
 * Fix Thumb-1 BE32 execution and disassembly
 * arm: Add cfgend parameter for ARM CPU selection
 * sd: sdhci: check data length during dma_memory_read
 * aspeed: add a watchdog controller
 * integratorcp: adding vmstate for save/restore

----------------------------------------------------------------
Cédric Le Goater (2):
      wdt: Add Aspeed watchdog device model
      aspeed: add a watchdog controller

Julian Brown (4):
      hw/arm/integratorcp: Support specifying features via -cpu
      target/arm: Add cfgend parameter for ARM CPU selection.
      Fix Thumb-1 BE32 execution and disassembly.
      arm: Correctly handle watchpoints for BE32 CPUs

Pavel Dovgalyuk (1):
      integratorcp: adding vmstate for save/restore

Peter Maydell (5):
      target/arm: Abstract out pbit/wbit tests in ARM ldr/str decode
      target/arm: A32, T32: Create Instruction Syndromes for Data Aborts
      stellaris: Document memory map and which SoC devices are unimplemented
      hw/misc: New "unimplemented" sysbus device
      stellaris: Use the 'unimplemented' device for parts we don't implement

Prasad J Pandit (1):
      sd: sdhci: check data length during dma_memory_read

 hw/misc/Makefile.objs            |   2 +
 hw/watchdog/Makefile.objs        |   1 +
 include/disas/bfd.h              |   7 ++
 include/hw/arm/aspeed_soc.h      |   2 +
 include/hw/misc/unimp.h          |  39 +++++++
 include/hw/watchdog/wdt_aspeed.h |  32 ++++++
 include/qom/cpu.h                |   3 +
 target/arm/arm_ldst.h            |  10 +-
 target/arm/cpu.h                 |   7 ++
 target/arm/internals.h           |   5 +
 target/arm/translate.h           |  14 +++
 disas.c                          |   1 +
 exec.c                           |   1 +
 hw/arm/aspeed_soc.c              |  13 +++
 hw/arm/integratorcp.c            |  78 +++++++++++++-
 hw/arm/stellaris.c               |  48 +++++++++
 hw/misc/unimp.c                  | 107 +++++++++++++++++++
 hw/sd/sdhci.c                    |   2 +-
 hw/watchdog/wdt_aspeed.c         | 225 +++++++++++++++++++++++++++++++++++++++
 qom/cpu.c                        |   6 ++
 target/arm/cpu.c                 |  39 +++++++
 target/arm/op_helper.c           |  22 ++++
 target/arm/translate-a64.c       |  14 ---
 target/arm/translate.c           | 193 ++++++++++++++++++++++++---------
 24 files changed, 801 insertions(+), 70 deletions(-)
 create mode 100644 include/hw/misc/unimp.h
 create mode 100644 include/hw/watchdog/wdt_aspeed.h
 create mode 100644 hw/misc/unimp.c
 create mode 100644 hw/watchdog/wdt_aspeed.c
