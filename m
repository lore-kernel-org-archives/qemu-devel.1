Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDP-0007uQ-Gr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDO-0000i1-Bx
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDO-0000er-4h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDG-0007Z1-CK
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:12 +0100
Message-Id: <20180410121724.8549-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/12] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm patch queue for 2.12 -- a miscellaneous collection
of bug fixes.

thanks
-- PMM


The following changes since commit fb4fe32d5b6290deabe752b51cc1cc2a9e8573db:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180409-xtensa' into staging (2018-04-10 10:22:45 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180410

for you to fetch changes up to bd49e6027cbc207c87633c7add3ebd7d3474cd35:

  fpu: Fix rounding mode for floatN_to_uintM_round_to_zero (2018-04-10 13:02:26 +0100)

----------------------------------------------------------------
target-arm queue:
 * fpu: Fix rounding mode for floatN_to_uintM_round_to_zero
 * tcg: Fix guest state corruption when running 64-bit Arm
   guests on a 32-bit host (especially when using icount)
 * linux-user/signal.c: Ensure AArch64 signal frame isn't too small
 * cpus.c: ensure running CPU recalculates icount deadlines on timer expiry
 * target/arm: Report unsupported MPU region sizes more clearly
 * hw/arm/fsl-imx: Fix introspection problem with fsl-imx6 and fsl-imx7
 * hw/arm/allwinner-a10: Do not use nd_table in instance_init function
 * hw/sd/bcm2835_sdhost: Don't raise spurious interrupts
 * hw/sd/bcm2835_sdhost: Add tracepoints
 * target-arm: Check undefined opcodes for SWP in A32 decoder
 * hw/arm/integratorcp: Don't do things that could be fatal in the instance_init
 * hw/arm: Allow manually specified /psci node

----------------------------------------------------------------
Andrey Smirnov (1):
      hw/arm: Allow manually specified /psci node

Onur Sahin (1):
      target-arm: Check undefined opcodes for SWP in A32 decoder

Peter Maydell (5):
      hw/sd/bcm2835_sdhost: Add tracepoints
      hw/sd/bcm2835_sdhost: Don't raise spurious interrupts
      target/arm: Report unsupported MPU region sizes more clearly
      cpus.c: ensure running CPU recalculates icount deadlines on timer expiry
      linux-user/signal.c: Ensure AArch64 signal frame isn't too small

Richard Henderson (2):
      tcg: Introduce tcg_set_insn_start_param
      fpu: Fix rounding mode for floatN_to_uintM_round_to_zero

Thomas Huth (3):
      hw/arm/integratorcp: Don't do things that could be fatal in the instance_init
      hw/arm/allwinner-a10: Do not use nd_table in instance_init function
      hw/arm/fsl-imx: Fix introspection problem with fsl-imx6 and fsl-imx7

 target/arm/translate.h |  2 +-
 tcg/tcg.h              | 10 ++++++++++
 cpus.c                 | 10 +++++++++-
 fpu/softfloat.c        |  4 ++--
 hw/arm/allwinner-a10.c | 12 +++++------
 hw/arm/boot.c          | 10 ++++++++++
 hw/arm/fsl-imx6.c      | 14 ++++++-------
 hw/arm/fsl-imx7.c      | 13 ++++++------
 hw/arm/integratorcp.c  | 23 +++++++++++++--------
 hw/sd/bcm2835_sdhost.c | 54 ++++++++++++++++++++++++++++++++------------------
 linux-user/signal.c    |  6 ++++++
 target/arm/helper.c    |  6 +++---
 target/arm/translate.c |  9 +++++++--
 hw/sd/trace-events     |  6 ++++++
 14 files changed, 124 insertions(+), 55 deletions(-)
