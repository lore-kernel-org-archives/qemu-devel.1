Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMXFF-0007DY-GK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMXFE-0003Zu-Fd
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:52:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMXFE-0003ZG-6E
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:52:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMXFB-0006t3-MN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:52:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 11:52:30 +0000
Message-Id: <20181113115230.30257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/16] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2: fix compile failure on arm hosts...

thanks
-- PMM

The following changes since commit 6db87aae61bc6ac0a8cd9bc2e05d7ebfbcfd3657:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-12 17:11:22 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181113

for you to fetch changes up to 436c0cbbeb38dd97c02fe921a7cb253a18afdd86:

  target/arm/cpu: Give Cortex-A15 and -A7 the EL2 feature (2018-11-13 10:47:59 +0000)

----------------------------------------------------------------
target/arm queue:
 * Remove no-longer-needed workaround for small SAU regions for v8M
 * Remove antique TODO comment
 * MAINTAINERS: Add an entry for the 'collie' machine
 * hw/arm/sysbus-fdt: Only call match_fn callback if the type matches
 * Fix infinite recursion in tlbi_aa64_vmalle1_write()
 * ARM KVM: fix various bugs in handling of guest debugging
 * Correctly implement handling of HCR_EL2.{VI, VF}
 * Hyp mode R14 is shared with User and System
 * Give Cortex-A15 and -A7 the EL2 feature

----------------------------------------------------------------
Alex Bennée (6):
      target/arm64: properly handle DBGVR RESS bits
      target/arm64: hold BQL when calling do_interrupt()
      target/arm64: kvm debug set target_el when passing exception to guest
      tests/guest-debug: fix scoping of failcount
      arm: use symbolic MDCR_TDE in arm_debug_target_el
      arm: fix aa64_generate_debug_exceptions to work with EL2

Eric Auger (1):
      hw/arm/sysbus-fdt: Only call match_fn callback if the type matches

Peter Maydell (7):
      target/arm: Remove workaround for small SAU regions
      target/arm: Remove antique TODO comment
      Revert "target/arm: Implement HCR.VI and VF"
      target/arm: Track the state of our irq lines from the GIC explicitly
      target/arm: Correctly implement handling of HCR_EL2.{VI, VF}
      target/arm: Hyp mode R14 is shared with User and System
      target/arm/cpu: Give Cortex-A15 and -A7 the EL2 feature

Richard Henderson (1):
      target/arm: Fix typo in tlbi_aa64_vmalle1_write

Thomas Huth (1):
      MAINTAINERS: Add an entry for the 'collie' machine

 target/arm/cpu.h                  |  44 +++++++++++------
 target/arm/internals.h            |  34 +++++++++++++
 hw/arm/sysbus-fdt.c               |  12 +++--
 target/arm/cpu.c                  |  67 ++++++++++++++++++++++++-
 target/arm/helper.c               | 101 +++++++++++++-------------------------
 target/arm/kvm32.c                |   4 +-
 target/arm/kvm64.c                |  20 +++++++-
 target/arm/machine.c              |  51 +++++++++++++++++++
 target/arm/op_helper.c            |   4 +-
 MAINTAINERS                       |   7 +++
 tests/guest-debug/test-gdbstub.py |   1 +
 11 files changed, 249 insertions(+), 96 deletions(-)
