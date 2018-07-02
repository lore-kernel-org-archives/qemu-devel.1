Received: from eggs.gnu.org ([2001:4830:134:3::10]:60700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fa11R-0007jN-5r
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fa11N-0000Cn-VX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:49 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fa11N-0000CX-LP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:45:45 -0400
Received: by mail-wm0-x233.google.com with SMTP id 69-v6so9189477wmf.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:45:45 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	q17-v6sm19087521wrr.7.2018.07.02.08.45.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Jul 2018 08:45:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  2 Jul 2018 17:45:36 +0200
Message-Id: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/50] More misc patches for 3.0 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:

  tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to c40d479207b1bb6569ffde06e9a58e85cd529de0:

  tcg: simplify !CONFIG_TCG handling of tb_invalidate_* (2018-07-02 15:41:18 +0200)

----------------------------------------------------------------
* IEC units series (Philippe)
* Hyper-V PV TLB flush (Vitaly)
* git archive detection (Daniel)
* host serial passthrough fix (David)
* NPT support for SVM emulation (Jan)
* x86 "info mem" and "info tlb" fix (Doug)

----------------------------------------------------------------
Daniel P. Berrangé (1):
      configure: add sanity check to catch builds from "git archive"

Doug Gale (1):
      i386/monitor.c: make addresses canonical for "info mem" and "info tlb"

Dr. David Alan Gilbert (1):
      serial: Open non-block

Jan Kiszka (1):
      target-i386: Add NPT support

Paolo Bonzini (2):
      hw/i386: Use the IEC binary prefix definitions
      tcg: simplify !CONFIG_TCG handling of tb_invalidate_*

Philippe Mathieu-Daudé (43):
      include: Add IEC binary prefixes in "qemu/units.h"
      vdi: Use definitions from "qemu/units.h"
      x86/cpu: Use definitions from "qemu/units.h"
      checkpatch: Recognize IEC binary prefix definitions
      hw: Use IEC binary prefix definitions from "qemu/units.h"
      hw: Directly use "qemu/units.h" instead of "qemu/cutils.h"
      hw/ivshmem: Use the IEC binary prefix definitions
      hw/ipack: Use the IEC binary prefix definitions
      hw/scsi: Use the IEC binary prefix definitions
      hw/smbios: Use the IEC binary prefix definitions
      hw/xen: Use the IEC binary prefix definitions
      hw/tpm: Use the IEC binary prefix definitions
      hw/block: Use the IEC binary prefix definitions
      hw/display: Use the IEC binary prefix definitions
      hw/misc: Use the IEC binary prefix definitions
      hw/riscv: Use the IEC binary prefix definitions
      hw/m68k: Use the IEC binary prefix definitions
      hw/sparc: Use the IEC binary prefix definitions
      hw/s390x: Use the IEC binary prefix definitions
      hw/hppa: Use the IEC binary prefix definitions
      hw/xtensa: Use the IEC binary prefix definitions
      hw/alpha: Use the IEC binary prefix definitions
      hw/tricore: Use the IEC binary prefix definitions
      hw/microblaze: Use the IEC binary prefix definitions
      hw/nios2: Use the IEC binary prefix definitions
      hw/cris: Use the IEC binary prefix definitions
      hw/lm32: Use the IEC binary prefix definitions
      hw/sh4: Use the IEC binary prefix definitions
      hw/mips/r4k: Constify params_size
      hw/mips: Use the IEC binary prefix definitions
      hw/ppc: Use the IEC binary prefix definitions
      hw/net: Use the IEC binary prefix definitions
      hw/usb: Use the IEC binary prefix definitions
      hw/sd: Use the IEC binary prefix definitions
      hw/vfio: Use the IEC binary prefix definitions
      hw/virtio: Use the IEC binary prefix definitions
      hw/rdma: Use the IEC binary prefix definitions
      cutils: Do not include "qemu/units.h" directly
      monitor: Use the IEC binary prefix definitions
      vl: Use the IEC binary prefix definitions
      tests/crypto: Use the IEC binary prefix definitions
      linux-user: Use the IEC binary prefix definitions
      bsd-user: Use the IEC binary prefix definitions

Vitaly Kuznetsov (1):
      i386/kvm: add support for Hyper-V TLB flush

 accel/stubs/tcg-stub.c                   |   6 -
 block/vdi.c                              |   7 +-
 bsd-user/main.c                          |   5 +-
 chardev/char-serial.c                    |   3 +-
 configure                                |  18 +++
 exec.c                                   |   6 +-
 hw/alpha/typhoon.c                       |  17 ++-
 hw/arm/msf2-soc.c                        |   6 +-
 hw/arm/msf2-som.c                        |   8 +-
 hw/block/m25p80.c                        |   5 +-
 hw/block/nvme.c                          |   3 +-
 hw/block/tc58128.c                       |   3 +-
 hw/block/xen_disk.c                      |   3 +-
 hw/core/loader-fit.c                     |   3 +-
 hw/core/machine.c                        |   4 +-
 hw/cris/axis_dev88.c                     |   3 +-
 hw/display/bochs-display.c               |   9 +-
 hw/display/cirrus_vga.c                  |  10 +-
 hw/display/g364fb.c                      |   4 +-
 hw/display/qxl.c                         |  30 ++---
 hw/display/sm501.c                       |  16 +--
 hw/display/vga-isa-mm.c                  |   5 +-
 hw/display/vga.c                         |   5 +-
 hw/display/virtio-gpu.c                  |   4 +-
 hw/display/vmware_vga.c                  |   3 +-
 hw/display/xenfb.c                       |   3 +-
 hw/hppa/dino.c                           |   3 +-
 hw/hppa/machine.c                        |  12 +-
 hw/i386/acpi-build.c                     |   4 +-
 hw/i386/pc.c                             |  23 ++--
 hw/i386/pc_piix.c                        |   3 +-
 hw/i386/pc_q35.c                         |   3 +-
 hw/i386/pc_sysfw.c                       |  10 +-
 hw/i386/xen/xen-mapcache.c               |   3 +-
 hw/ipack/tpci200.c                       |   5 +-
 hw/lm32/lm32_boards.c                    |  13 +-
 hw/lm32/milkymist.c                      |  10 +-
 hw/m68k/mcf5208.c                        |   3 +-
 hw/microblaze/petalogix_ml605_mmu.c      |   7 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   7 +-
 hw/mips/boston.c                         |  30 ++---
 hw/mips/mips_fulong2e.c                  |   7 +-
 hw/mips/mips_malta.c                     |  25 ++--
 hw/mips/mips_r4k.c                       |  15 ++-
 hw/misc/auxbus.c                         |   3 +-
 hw/misc/edu.c                            |   3 +-
 hw/misc/ivshmem.c                        |   3 +-
 hw/misc/mips_itu.c                       |   3 +-
 hw/net/e1000e.c                          |   7 +-
 hw/net/e1000x_common.c                   |   3 +-
 hw/net/eepro100.c                        |   3 +-
 hw/net/ne2000.h                          |   5 +-
 hw/nios2/boot.c                          |   6 +-
 hw/nvram/spapr_nvram.c                   |  11 +-
 hw/pci-host/prep.c                       |   3 +-
 hw/pci-host/xilinx-pcie.c                |   5 +-
 hw/ppc/e500.c                            |  13 +-
 hw/ppc/e500plat.c                        |   3 +-
 hw/ppc/mac.h                             |   3 +-
 hw/ppc/mac_newworld.c                    |   1 -
 hw/ppc/mac_oldworld.c                    |   9 +-
 hw/ppc/pnv.c                             |   6 +-
 hw/ppc/ppc405_boards.c                   |   9 +-
 hw/ppc/ppc405_uc.c                       |   7 +-
 hw/ppc/ppc440_bamboo.c                   |   5 +-
 hw/ppc/ppc440_uc.c                       |  28 ++--
 hw/ppc/ppc4xx_devs.c                     |  22 ++--
 hw/ppc/ppce500_spin.c                    |   3 +-
 hw/ppc/prep.c                            |   6 +-
 hw/ppc/rs6000_mc.c                       |  13 +-
 hw/ppc/sam460ex.c                        |  18 +--
 hw/ppc/spapr.c                           |  18 +--
 hw/ppc/spapr_rtas.c                      |   4 +-
 hw/ppc/virtex_ml507.c                    |   7 +-
 hw/rdma/vmw/pvrdma.h                     |   3 +-
 hw/riscv/virt.c                          |   3 +-
 hw/s390x/s390-skeys.c                    |   3 +-
 hw/s390x/s390-stattrib.c                 |   3 +-
 hw/s390x/sclp.c                          |   3 +-
 hw/scsi/scsi-disk.c                      |   9 +-
 hw/sd/sd.c                               |   8 +-
 hw/sd/sdhci.c                            |   8 +-
 hw/sh4/r2d.c                             |   3 +-
 hw/smbios/smbios.c                       |  15 +--
 hw/sparc/leon3.c                         |  10 +-
 hw/sparc/sun4m.c                         |  10 +-
 hw/sparc64/niagara.c                     |   3 +-
 hw/sparc64/sun4u.c                       |   4 +-
 hw/tricore/tricore_testboard.c           |  13 +-
 hw/usb/ccid-card-passthru.c              |   9 +-
 hw/usb/combined-packet.c                 |   3 +-
 hw/usb/dev-smartcard-reader.c            |   3 +-
 hw/usb/redirect.c                        |   3 +-
 hw/vfio/pci-quirks.c                     |   9 +-
 hw/vfio/pci.c                            |   3 +-
 hw/xenpv/xen_domainbuild.c               |  13 +-
 hw/xtensa/xtfpga.c                       |   9 +-
 include/exec/exec-all.h                  |   8 +-
 include/hw/acpi/tpm.h                    |   3 +-
 include/hw/display/xlnx_dp.h             |   5 +-
 include/hw/intc/mips_gic.h               |   3 +-
 include/hw/mips/bios.h                   |   3 +-
 include/hw/net/allwinner_emac.h          |   5 +-
 include/hw/ppc/spapr.h                   |   5 +-
 include/hw/virtio/virtio-net.h           |   3 +-
 include/qemu/cutils.h                    |   7 -
 include/qemu/units.h                     |  20 +++
 linux-user/main.c                        |   5 +-
 monitor.c                                |   3 +-
 scripts/checkpatch.pl                    |   1 +
 target/i386/cpu.c                        |   7 +-
 target/i386/cpu.h                        |   7 +
 target/i386/excp_helper.c                | 216 ++++++++++++++++++++++++++++++-
 target/i386/hyperv-proto.h               |   1 +
 target/i386/kvm.c                        |  15 ++-
 target/i386/machine.c                    |  21 +++
 target/i386/mem_helper.c                 |   6 +-
 target/i386/monitor.c                    |  76 ++++++-----
 target/i386/svm.h                        |  14 ++
 target/i386/svm_helper.c                 |  22 ++++
 target/ppc/mmu_helper.c                  |   8 +-
 target/xtensa/helper.c                   |   5 +-
 tests/benchmark-crypto-cipher.c          |   6 +-
 tests/benchmark-crypto-hash.c            |   5 +-
 tests/benchmark-crypto-hmac.c            |   6 +-
 tests/test-cutils.c                      |  21 +--
 tests/test-keyval.c                      |   7 +-
 tests/test-qemu-opts.c                   |   9 +-
 vl.c                                     |   5 +-
 129 files changed, 840 insertions(+), 440 deletions(-)
 create mode 100644 include/qemu/units.h
-- 
1.8.3.1
