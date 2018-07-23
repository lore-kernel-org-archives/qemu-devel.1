Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI6-0001Ip-1R
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI4-0002CM-AQ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:46 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:09 -0500
Message-Id: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/99] Patch Round-up for stable 2.12.1,
 freeze on 2018-07-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi everyone,

The following new patches are queued for QEMU stable v2.12.1:

  https://github.com/mdroth/qemu/commits/stable-2.12-staging

The release is planned for 2018-08-02:

  https://wiki.qemu.org/Planning/2.12

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Thanks!

----------------------------------------------------------------
Alberto Garcia (1):
      throttle: Fix crash on reopen

Alex Bennée (4):
      target/arm: Implement FCMP for fp16
      target/arm: Implement FCSEL for fp16
      target/arm: Implement FMOV (immediate) for fp16
      target/arm: Fix sqrt_f16 exception raising

Alex Williamson (1):
      vfio/pci: Default display option to "off"

Brijesh Singh (1):
      tap: set vhostfd passed from qemu cli to non-blocking

Cornelia Huck (4):
      s390-ccw: force diag 308 subcode to unsigned long
      s390x/css: disabled subchannels cannot be status pending
      virtio-ccw: common reset handler
      s390x/ccw: make sure all ccw devices are properly reset

Cédric Le Goater (1):
      cpus: tcg: fix never exiting loop on unplug

Daniel P. Berrangé (1):
      i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639)

Emilio G. Cota (1):
      target/ppc: set is_jmp on ppc_tr_breakpoint_check

Eric Blake (6):
      nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
      qemu-img: Fix assert when mapping unaligned raw file
      iotests: Add test 221 to catch qemu-img map regression
      nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply
      nbd/server: Reject 0-length block status request
      iscsi: Avoid potential for get_status overflow

Fam Zheng (1):
      raw: Check byte range uniformly

Geert Uytterhoeven (1):
      device_tree: Increase FDT_MAX_SIZE to 1 MiB

Gerd Hoffmann (2):
      qxl: fix local renderer crash
      vnc: fix use-after-free

Greg Kurz (2):
      target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack
      spapr: don't advertise radix GTSE if max-compat-cpu < power9

Henry Wertz (1):
      tcg/arm: Fix memory barrier encoding

Jan Kiszka (1):
      hw/intc/arm_gicv3: Fix APxR<n> register dispatching

Jason Andryuk (1):
      ccid: Fix dwProtocols advertisement of T=0

John Snow (2):
      ahci: fix PxCI register race
      blockjob: expose error string via query

John Thomson (1):
      Fix libusb-1.0.22 deprecated libusb_set_debug with libusb_set_option

KONRAD Frederic (3):
      riscv: spike: allow base == 0
      riscv: htif: increase the priority of the htif subregion
      riscv: requires libfdt

Kevin Wolf (1):
      nfs: Remove processed options from QDict

Konrad Rzeszutek Wilk (2):
      i386: Define the Virt SSBD MSR and handling of it (CVE-2018-3639)
      i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639)

Laszlo Ersek (1):
      qapi: fill in CpuInfoFast.arch in query-cpus-fast

Marc-André Lureau (2):
      tests: fix tpm-crb tpm-tis tests race
      mux: fix ctrl-a b again

Max Reitz (10):
      qemu-img: Resolve relative backing paths in rebase
      iotests: Add test for rebasing with relative paths
      qemu-io: Use purely string blockdev options
      qemu-img: Use only string options in img_open_opts
      iotests: Add test for -U/force-share conflicts
      block: Make bdrv_is_writable() public
      qcow2: Do not mark inactive images corrupt
      iotests: Add case for a corrupted inactive image
      block/mirror: Make cancel always cancel pre-READY
      iotests: Add test for cancelling a mirror job

Michael Clark (1):
      RISC-V: Minimal QEMU 2.12 fix for sifive_u machine

Michael Walle (1):
      lm32: take BQL before writing IP/IM register

Michal Privoznik (1):
      console: Avoid segfault in screendump

Olaf Hering (2):
      configure: recognize more rpmbuild macros
      replace functions which are only available in glib-2.24

Pankaj Gupta (1):
      virtio-rng: process pending requests on DRIVER_OK

Peter Lieven (1):
      qemu-img: avoid overflow of min_sparse parameter

Peter Maydell (5):
      target/arm: Implement v8M VLLDM and VLSTM
      tcg/i386: Fix dup_vec in non-AVX2 codepath
      softfloat: Handle default NaN mode after pickNaNMulAdd, not before
      target/arm: Fix fp_status_f16 tininess before rounding
      fpu/softfloat: Don't set Invalid for float-to-int(MAXINT)

Peter Xu (9):
      intel-iommu: send PSI always even if across PDEs
      intel-iommu: remove IntelIOMMUNotifierNode
      intel-iommu: add iommu lock
      intel-iommu: only do page walk for MAP notifiers
      intel-iommu: introduce vtd_page_walk_info
      intel-iommu: pass in address space when page walk
      intel-iommu: trace domain id during page walk
      util: implement simple iova tree
      intel-iommu: rework the page walk logic

Petr Tesarik (1):
      fpu/softfloat: Fix conversion from uint64 to float128

Philippe Mathieu-Daudé (3):
      usb: correctly handle Zero Length Packets
      usb/dev-mtp: Fix use of uninitialized values
      hw/isa/superio: Fix inconsistent use of Chardev->be

Richard Henderson (13):
      tcg: Limit the number of ops in a TB
      target/arm: Implement vector shifted SCVF/UCVF for fp16
      target/arm: Implement vector shifted FCVT for fp16
      target/arm: Fix float16 to/from int16
      target/arm: Clear SVE high bits for FMOV
      target/arm: Implement FMOV (general) for fp16
      target/arm: Implement FCVT (scalar, integer) for fp16
      target/arm: Implement FCVT (scalar, fixed-point) for fp16
      target/arm: Introduce and use read_fp_hreg
      target/arm: Implement FP data-processing (2 source) for fp16
      target/arm: Implement FP data-processing (3 source) for fp16
      tcg: Reduce max TB opcode count
      tcg/i386: Mark xmm registers call-clobbered

Shannon Zhao (3):
      arm_gicv3_kvm: increase clroffset accordingly
      arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR
      arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR

Stefan Hajnoczi (1):
      block/mirror: honor ratelimit again

Thomas Huth (1):
      pc-bios/s390-ccw: struct tpi_info must be declared as aligned(4)

Vladimir Sementsov-Ogievskiy (3):
      nbd/client: fix nbd_negotiate_simple_meta_context
      migration/block-dirty-bitmap: fix memory leak in dirty_bitmap_load_bits
      migration/block-dirty-bitmap: fix dirty_bitmap_load

Yunjian Wang (1):
      tap: fix memory leak on success to create a tap device

linzhecheng (1):
      vhost-user: delete net client if necessary

 MAINTAINERS                        |   6 +
 block.c                            |  17 +-
 block/iscsi.c                      |   2 +-
 block/mirror.c                     |  12 +-
 block/nbd-client.c                 |  10 +-
 block/nfs.c                        |   7 +
 block/qcow2.c                      |   2 +-
 block/raw-format.c                 |  64 +++--
 block/throttle.c                   |  54 ++--
 blockjob.c                         |   2 +
 chardev/char-mux.c                 |   1 +
 configure                          |   4 +-
 cpus.c                             |  18 +-
 device_tree.c                      |   2 +-
 fpu/softfloat.c                    |  54 ++--
 hw/display/qxl-render.c            |   3 +-
 hw/i386/intel_iommu.c              | 396 ++++++++++++++++++++-------
 hw/i386/trace-events               |   5 +-
 hw/ide/ahci.c                      |  13 +-
 hw/intc/arm_gicv3_common.c         |  79 ++++++
 hw/intc/arm_gicv3_cpuif.c          |  12 +-
 hw/intc/arm_gicv3_kvm.c            |  57 +++-
 hw/isa/isa-superio.c               |   6 +-
 hw/ppc/spapr.c                     |  15 +-
 hw/riscv/riscv_htif.c              |  12 +-
 hw/riscv/sifive_u.c                |   7 +-
 hw/s390x/ccw-device.c              |   8 +
 hw/s390x/css.c                     |   8 +
 hw/s390x/virtio-ccw.c              |  20 +-
 hw/s390x/virtio-ccw.h              |   1 +
 hw/usb/dev-mtp.c                   |   6 +-
 hw/usb/dev-smartcard-reader.c      |   4 +-
 hw/usb/host-libusb.c               |   4 +
 hw/usb/redirect.c                  |   2 +-
 hw/vfio/pci.c                      |   2 +-
 hw/virtio/virtio-rng.c             |  14 +
 include/block/block.h              |   1 +
 include/hw/i386/intel_iommu.h      |  19 +-
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/qemu/iova-tree.h           | 134 ++++++++++
 migration/block-dirty-bitmap.c     |   4 +
 nbd/client.c                       |  18 +-
 nbd/server.c                       |   4 +
 net/tap.c                          |  18 +-
 net/vhost-user.c                   |  11 +-
 pc-bios/s390-ccw/cio.h             |   2 +-
 pc-bios/s390-ccw/iplb.h            |   3 +-
 qapi/block-core.json               |   6 +-
 qapi/misc.json                     |   2 +-
 qemu-img.c                         |  45 +++-
 qemu-io.c                          |   4 +-
 target/arm/cpu.c                   |   2 +
 target/arm/helper-a64.c            |  10 +
 target/arm/helper-a64.h            |   2 +
 target/arm/helper.c                |  87 +++++-
 target/arm/helper.h                |   6 +
 target/arm/translate-a64.c         | 532 +++++++++++++++++++++++++++++--------
 target/arm/translate.c             |  17 +-
 target/i386/cpu.c                  |   4 +-
 target/i386/cpu.h                  |   3 +
 target/i386/kvm.c                  |  16 +-
 target/i386/machine.c              |  20 ++
 target/lm32/op_helper.c            |   4 +
 target/ppc/machine.c               |   5 +
 target/ppc/translate.c             |   1 +
 tcg/aarch64/tcg-target.inc.c       |   2 +-
 tcg/arm/tcg-target.inc.c           |   6 +-
 tcg/i386/tcg-target.inc.c          |  10 +-
 tcg/mips/tcg-target.inc.c          |   2 +-
 tcg/ppc/tcg-target.inc.c           |   4 +-
 tcg/s390/tcg-target.inc.c          |   2 +-
 tcg/sparc/tcg-target.inc.c         |   4 +-
 tcg/tcg.c                          |  16 +-
 tcg/tcg.h                          |  10 +-
 tcg/tci/tcg-target.inc.c           |   2 +-
 tests/qemu-iotests/024             |  82 +++++-
 tests/qemu-iotests/024.out         |  30 +++
 tests/qemu-iotests/060             |  30 +++
 tests/qemu-iotests/060.out         |  14 +
 tests/qemu-iotests/153             |  17 ++
 tests/qemu-iotests/153.out         |  16 ++
 tests/qemu-iotests/185.out         |   2 +-
 tests/qemu-iotests/218             | 138 ++++++++++
 tests/qemu-iotests/218.out         |  30 +++
 tests/qemu-iotests/221             |  60 +++++
 tests/qemu-iotests/221.out         |  16 ++
 tests/qemu-iotests/group           |   2 +
 tests/test-char.c                  |   8 +
 tests/tpm-emu.c                    |   2 +-
 ui/console.c                       |   5 +
 ui/vnc.c                           |   5 +-
 util/Makefile.objs                 |   1 +
 util/iova-tree.c                   | 114 ++++++++
 util/vfio-helpers.c                |   6 +-
 94 files changed, 2133 insertions(+), 413 deletions(-)
 create mode 100644 include/qemu/iova-tree.h
 create mode 100644 tests/qemu-iotests/218
 create mode 100644 tests/qemu-iotests/218.out
 create mode 100755 tests/qemu-iotests/221
 create mode 100644 tests/qemu-iotests/221.out
 create mode 100644 util/iova-tree.c
