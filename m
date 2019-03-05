Received: from eggs.gnu.org ([209.51.188.92]:54467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHO-0001Tq-3u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHM-0000cg-VT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHM-0000ad-LY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:50:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id y15so3281608wma.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:50:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.50.52
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:50:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:29 +0000
Message-Id: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue for softfreeze:
This has all the big stuff I want to get in for softfreeze;
there may be one or two smaller patches I pick up later in
the week.

thanks
-- PMM

The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190305

for you to fetch changes up to 566528f823d1a2e9eb2d7b2ed839547cb31bfc34:

  hw/arm/stellaris: Implement watchdog timer (2019-03-05 15:55:09 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix PC test for LDM (exception return)
 * Implement ARMv8.0-SB
 * Implement ARMv8.0-PredInv
 * Implement ARMv8.4-CondM
 * Implement ARMv8.5-CondM
 * Implement ARMv8.5-FRINT
 * hw/arm/stellaris: Implement watchdog timer
 * virt: support more than 255GB of RAM

----------------------------------------------------------------
Eric Auger (9):
      hw/arm/virt: Rename highmem IO regions
      hw/arm/virt: Split the memory map description
      hw/boards: Add a MachineState parameter to kvm_type callback
      kvm: add kvm_arm_get_max_vm_ipa_size
      vl: Set machine ram_size, maxram_size and ram_slots earlier
      hw/arm/virt: Dynamic memory map depending on RAM requirements
      hw/arm/virt: Implement kvm_type function for 4.0 machine
      hw/arm/virt: Check the VCPU PA range in TCG mode
      hw/arm/virt: Bump the 255GB initial RAM limit

Michel Heily (1):
      hw/arm/stellaris: Implement watchdog timer

Richard Henderson (11):
      target/arm: Fix PC test for LDM (exception return)
      target/arm: Split out arm_sctlr
      target/arm: Implement ARMv8.0-SB
      target/arm: Implement ARMv8.0-PredInv
      target/arm: Split helper_msr_i_pstate into 3
      target/arm: Add set/clear_pstate_bits, share gen_ss_advance
      target/arm: Rearrange disas_data_proc_reg
      target/arm: Implement ARMv8.4-CondM
      target/arm: Implement ARMv8.5-CondM
      target/arm: Restructure handle_fp_1src_{single, double}
      target/arm: Implement ARMv8.5-FRINT

Shameer Kolothum (1):
      hw/arm/boot: introduce fdt_add_memory_node helper

 include/hw/arm/virt.h                    |  16 +-
 include/hw/boards.h                      |   5 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h |   8 +
 target/arm/cpu.h                         |  64 ++++-
 target/arm/helper-a64.h                  |   3 +
 target/arm/helper.h                      |   8 +-
 target/arm/internals.h                   |  15 +
 target/arm/kvm_arm.h                     |  13 +
 target/arm/translate.h                   |  34 +++
 accel/kvm/kvm-all.c                      |   2 +-
 hw/arm/boot.c                            |  54 ++--
 hw/arm/stellaris.c                       |  22 +-
 hw/arm/virt-acpi-build.c                 |  10 +-
 hw/arm/virt.c                            | 196 ++++++++++---
 hw/ppc/mac_newworld.c                    |   3 +-
 hw/ppc/mac_oldworld.c                    |   2 +-
 hw/ppc/spapr.c                           |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c         |  74 ++++-
 linux-user/elfload.c                     |   2 +
 target/arm/cpu.c                         |   2 +
 target/arm/cpu64.c                       |   6 +
 target/arm/helper-a64.c                  |  30 ++
 target/arm/helper.c                      |  63 +++-
 target/arm/kvm.c                         |  10 +
 target/arm/op_helper.c                   |  47 ---
 target/arm/translate-a64.c               | 478 +++++++++++++++++++++++--------
 target/arm/translate.c                   |  35 ++-
 target/arm/vfp_helper.c                  |  96 +++++++
 vl.c                                     |   6 +-
 29 files changed, 1032 insertions(+), 274 deletions(-)
