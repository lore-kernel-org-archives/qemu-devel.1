Received: from eggs.gnu.org ([2001:4830:134:3::10]:55284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fVkyU-0001YQ-Ca
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fVkyQ-0003U9-75
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:49:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47972
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fVkyQ-0003Ta-0C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:49:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5KLdP5P091688
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 17:49:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jqxwh8gf4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 17:49:05 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 20 Jun 2018 17:49:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 16:48:53 -0500
Message-Id: <152953133362.8870.5068527344743214691@sif>
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
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

Quoting Michael Roth (2018-06-18 20:41:26)
> Hi everyone,
> =

> The following new patches are queued for QEMU stable v2.11.2:
> =

>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> =

> The release is planned for 2018-06-22:
> =

>   https://wiki.qemu.org/Planning/2.11
> =

> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

The following additional patches have been queued for 2.11.2:

  tpm: lookup cancel path under tpm device class (Marc-Andr=C3=A9 Lureau)
  tpm-passthrough: don't save guessed cancel_path in options (Marc-Andr=C3=
=A9 Lureau)
  s390-ccw-virtio: allow for systems larger that 7.999TB (Christian Borntra=
eger)
  crypto: ensure we use a predictable TLS priority setting (Daniel P. Berra=
ng=C3=A9)
  qapi: ensure stable sort ordering when checking QAPI entities (Daniel P. =
Berrange)

  https://github.com/mdroth/qemu/commits/stable-2.11-staging

Thank you everyone for the suggestions.

> =

> Thanks!
> =

> ----------------------------------------------------------------
> =

> The following changes since commit 7c1beb52ed86191d9e965444d934adaa253171=
0f:
> =

>   Update version for 2.11.1 release (2018-02-14 14:41:05 -0600)
> =

> are available in the git repository at:
> =

>   git://github.com/mdroth/qemu.git =

> =

> for you to fetch changes up to acb3571f90885a2e206044b3bdc8d1dd2a0389c0:
> =

>   arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by =
GICR_IPRIORITYR (2018-06-16 07:47:00 -0500)
> =

> ----------------------------------------------------------------
> Alberto Garcia (2):
>       specs/qcow2: Fix documentation of the compressed cluster descriptor
>       throttle: Fix crash on reopen
> =

> Alexandro Sanchez Bach (1):
>       target/i386: Fix andn instruction
> =

> Brijesh Singh (1):
>       tap: set vhostfd passed from qemu cli to non-blocking
> =

> Cornelia Huck (4):
>       s390-ccw: force diag 308 subcode to unsigned long
>       s390x/css: disabled subchannels cannot be status pending
>       virtio-ccw: common reset handler
>       s390x/ccw: make sure all ccw devices are properly reset
> =

> Daniel P. Berrang=C3=A9 (1):
>       i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639)
> =

> David Gibson (3):
>       spapr: Allow some cases where we can't set VSMT mode in the kernel
>       spapr: Adjust default VSMT value for better migration compatibility
>       target/ppc: Clarify compat mode max_threads value
> =

> Eric Blake (4):
>       nbd: Honor server's advertised minimum block size
>       nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
>       qemu-img: Fix assert when mapping unaligned raw file
>       iotests: Add test 221 to catch qemu-img map regression
> =

> Fam Zheng (1):
>       raw: Check byte range uniformly
> =

> Geert Uytterhoeven (1):
>       device_tree: Increase FDT_MAX_SIZE to 1 MiB
> =

> Gerd Hoffmann (3):
>       sdl: workaround bug in sdl 2.0.8 headers
>       qxl: fix local renderer crash
>       vga: fix region calculation
> =

> Greg Kurz (12):
>       spapr: use spapr->vsmt to compute VCPU ids
>       spapr: move VCPU calculation to core machine code
>       spapr: rename spapr_vcpu_id() to spapr_get_vcpu_id()
>       spapr: consolidate the VCPU id numbering logic in a single place
>       spapr: fix missing CPU core nodes in DT when running with TCG
>       spapr: register dummy ICPs later
>       spapr: make pseries-2.11 the default machine type
>       virtio_net: flush uncompleted TX on reset
>       exec: fix memory leak in find_max_supported_pagesize()
>       vfio-ccw: fix memory leaks in vfio_ccw_realize()
>       target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack
>       spapr: don't advertise radix GTSE if max-compat-cpu < power9
> =

> Henry Wertz (1):
>       tcg/arm: Fix memory barrier encoding
> =

> Jack Schwartz (4):
>       multiboot: bss_end_addr can be zero
>       multiboot: Remove unused variables from multiboot.c
>       multiboot: Use header names when displaying fields
>       multiboot: fprintf(stderr...) -> error_report()
> =

> Jan Kiszka (1):
>       hw/intc/arm_gicv3: Fix APxR<n> register dispatching
> =

> Jason Andryuk (1):
>       ccid: Fix dwProtocols advertisement of T=3D0
> =

> John Snow (1):
>       ahci: fix PxCI register race
> =

> John Thomson (1):
>       Fix libusb-1.0.22 deprecated libusb_set_debug with libusb_set_option
> =

> KONRAD Frederic (1):
>       sparc: fix leon3 casa instruction when MMU is disabled
> =

> Kevin Wolf (7):
>       rbd: Fix use after free in qemu_rbd_set_keypairs() error path
>       multiboot: Reject kernels exceeding the address space
>       multiboot: Check validity of mh_header_addr
>       tests/multiboot: Test exit code for every qemu run
>       tests/multiboot: Add tests for the a.out kludge
>       tests/multiboot: Add .gitignore
>       gluster: Fix blockdev-add with server.N.type=3Dunix
> =

> Konrad Rzeszutek Wilk (2):
>       i386: Define the Virt SSBD MSR and handling of it (CVE-2018-3639)
>       i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639)
> =

> Laszlo Ersek (1):
>       pci-bridge/i82801b11: clear bridge registers on platform reset
> =

> Laurent Vivier (1):
>       spapr: set vsmt to MAX(8, smp_threads)
> =

> Mark Cave-Ayland (1):
>       loader: don't perform overlapping address check for memory region R=
OM images
> =

> Max Filippov (4):
>       target/xtensa: dump correct physical registers
>       linux-user: fix mmap/munmap/mprotect/mremap/shmat
>       linux-user: fix assertion in shmdt
>       linux-user: fix target_mprotect/target_munmap error return values
> =

> Max Reitz (10):
>       block/file-posix: Fix fully preallocated truncate
>       iotests: Test preallocated truncate of 2G image
>       qemu-img: Resolve relative backing paths in rebase
>       iotests: Add test for rebasing with relative paths
>       qemu-io: Use purely string blockdev options
>       qemu-img: Use only string options in img_open_opts
>       iotests: Add test for -U/force-share conflicts
>       block: Make bdrv_is_writable() public
>       qcow2: Do not mark inactive images corrupt
>       iotests: Add case for a corrupted inactive image
> =

> Michael Roth (1):
>       Merge remote-tracking branch 'gkurz/stable-2.11-staging' into stabl=
e-2.11-staging
> =

> Michael Walle (1):
>       lm32: take BQL before writing IP/IM register
> =

> Michal Privoznik (2):
>       qemu-pr-helper: Actually allow users to specify pidfile
>       console: Avoid segfault in screendump
> =

> Murilo Opsfelder Araujo (1):
>       block/ssh: fix possible segmentation fault when .desc is not null-t=
erminated
> =

> Nia Alarie (1):
>       s390x/virtio: Convert virtio-ccw from *_exit to *_unrealize
> =

> Olaf Hering (1):
>       configure: recognize more rpmbuild macros
> =

> Paolo Bonzini (9):
>       memfd: fix configure test
>       openpic_kvm: drop address_space_to_flatview call
>       memory: inline some performance-sensitive accessors
>       address_space_write: address_space_to_flatview needs RCU lock
>       address_space_read: address_space_to_flatview needs RCU lock
>       address_space_access_valid: address_space_to_flatview needs RCU lock
>       address_space_map: address_space_to_flatview needs RCU lock
>       address_space_rw: address_space_to_flatview needs RCU lock
>       memory: fix flatview_access_valid RCU read lock/unlock imbalance
> =

> Peter Lieven (1):
>       migration/block: reset dirty bitmap before read in bulk phase
> =

> Peter Maydell (3):
>       cpus.c: ensure running CPU recalculates icount deadlines on timer e=
xpiry
>       hw/char/cmsdk-apb-uart.c: Correctly clear INTSTATUS bits on writes
>       target/arm: Implement v8M VLLDM and VLSTM
> =

> Peter Xu (9):
>       intel-iommu: send PSI always even if across PDEs
>       intel-iommu: remove IntelIOMMUNotifierNode
>       intel-iommu: add iommu lock
>       intel-iommu: only do page walk for MAP notifiers
>       intel-iommu: introduce vtd_page_walk_info
>       intel-iommu: pass in address space when page walk
>       intel-iommu: trace domain id during page walk
>       util: implement simple iova tree
>       intel-iommu: rework the page walk logic
> =

> Philippe Mathieu-Daud=C3=A9 (3):
>       hw/block/pflash_cfi: fix off-by-one error
>       qdev: rename typedef qdev_resetfn() -> DeviceReset()
>       qdev: add helpers to be more explicit when using abstract QOM paren=
t functions
> =

> Prasad Singamsetty (2):
>       intel-iommu: Redefine macros to enable supporting 48 bit address wi=
dth
>       intel-iommu: Extend address width to 48 bits
> =

> Richard Henderson (2):
>       tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops
>       tcg: Introduce tcg_set_insn_start_param
> =

> Shannon Zhao (3):
>       arm_gicv3_kvm: increase clroffset accordingly
>       arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR
>       arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked=
 by GICR_IPRIORITYR
> =

> Stefan Berger (1):
>       tpm: Set the flags of the CMD_INIT command to 0
> =

> Thomas Huth (1):
>       pc-bios/s390-ccw: struct tpi_info must be declared as aligned(4)
> =

> Tiwei Bie (1):
>       virtio-balloon: unref the memory region before continuing
> =

> Victor Kamensky (1):
>       arm/translate-a64: treat DISAS_UPDATE as variant of DISAS_EXIT
> =

> Viktor Mihajlovski (1):
>       s390: Do not pass inofficial IPL type to the guest
> =

> linzhecheng (1):
>       vhost-user: delete net client if necessary
> =

>  MAINTAINERS                        |   6 +
>  block.c                            |  17 +-
>  block/file-posix.c                 |   5 +-
>  block/gluster.c                    |  21 +-
>  block/nbd-client.c                 |   3 -
>  block/nbd.c                        |   2 +
>  block/qcow2.c                      |   2 +-
>  block/raw-format.c                 |  64 +++--
>  block/rbd.c                        |   3 +-
>  block/ssh.c                        |   1 +
>  block/throttle.c                   |  54 ++--
>  configure                          |   5 +-
>  cpus.c                             |  10 +-
>  device_tree.c                      |   2 +-
>  docs/interop/qcow2.txt             |  16 +-
>  exec.c                             |  92 ++++---
>  hw/block/pflash_cfi01.c            |  10 +-
>  hw/block/pflash_cfi02.c            |   9 +-
>  hw/char/cmsdk-apb-uart.c           |   1 +
>  hw/core/loader.c                   |  20 +-
>  hw/core/qdev.c                     |  24 ++
>  hw/display/qxl-render.c            |   3 +-
>  hw/display/vga.c                   |   2 +
>  hw/i386/acpi-build.c               |   3 +-
>  hw/i386/intel_iommu.c              | 489 +++++++++++++++++++++++++++----=
------
>  hw/i386/intel_iommu_internal.h     |  43 ++--
>  hw/i386/multiboot.c                |  85 ++++---
>  hw/i386/trace-events               |   5 +-
>  hw/ide/ahci.c                      |  13 +-
>  hw/intc/arm_gicv3_common.c         |  79 ++++++
>  hw/intc/arm_gicv3_cpuif.c          |  12 +-
>  hw/intc/arm_gicv3_kvm.c            |  57 ++++-
>  hw/intc/openpic_kvm.c              |   4 -
>  hw/net/virtio-net.c                |  11 +
>  hw/pci-bridge/i82801b11.c          |   1 +
>  hw/ppc/spapr.c                     | 161 +++++++-----
>  hw/ppc/spapr_caps.c                |   5 +
>  hw/ppc/spapr_cpu_core.c            |   9 +-
>  hw/s390x/ccw-device.c              |   8 +
>  hw/s390x/css.c                     |   8 +
>  hw/s390x/virtio-ccw.c              |  54 ++--
>  hw/s390x/virtio-ccw.h              |   3 +-
>  hw/tpm/tpm_emulator.c              |   4 +-
>  hw/usb/dev-smartcard-reader.c      |   4 +-
>  hw/usb/host-libusb.c               |   4 +
>  hw/vfio/ccw.c                      |   2 +
>  hw/virtio/virtio-balloon.c         |   1 +
>  include/block/block.h              |   1 +
>  include/exec/cpu-all.h             |   6 +-
>  include/exec/cpu_ldst.h            |  16 +-
>  include/exec/memory-internal.h     |  13 +-
>  include/exec/memory.h              |  45 ++--
>  include/hw/i386/intel_iommu.h      |  26 +-
>  include/hw/intc/arm_gicv3_common.h |   1 +
>  include/hw/ppc/spapr.h             |   3 +-
>  include/hw/qdev-core.h             |  14 +-
>  include/net/net.h                  |   1 +
>  include/qemu/iova-tree.h           | 134 ++++++++++
>  linux-user/mmap.c                  |  26 +-
>  linux-user/syscall.c               |  13 +-
>  memory.c                           |  30 ---
>  migration/block.c                  |   5 +-
>  nbd/client.c                       |  14 +-
>  net/net.c                          |   1 -
>  net/tap.c                          |   2 +
>  net/vhost-user.c                   |  11 +-
>  pc-bios/s390-ccw/bootmap.c         |   7 +
>  pc-bios/s390-ccw/cio.h             |   2 +-
>  pc-bios/s390-ccw/iplb.h            |  16 +-
>  qemu-img.c                         |  29 ++-
>  qemu-io.c                          |   4 +-
>  scsi/qemu-pr-helper.c              |   7 +-
>  target/arm/translate-a64.c         |   6 +-
>  target/arm/translate.c             |  17 +-
>  target/arm/translate.h             |   2 +-
>  target/i386/cpu.c                  |   4 +-
>  target/i386/cpu.h                  |   3 +
>  target/i386/kvm.c                  |  16 +-
>  target/i386/machine.c              |  20 ++
>  target/i386/translate.c            |   2 +-
>  target/lm32/op_helper.c            |   4 +
>  target/ppc/compat.c                |  25 +-
>  target/ppc/cpu.h                   |   2 +-
>  target/ppc/machine.c               |   5 +
>  target/sparc/translate.c           |   5 +
>  target/xtensa/translate.c          |   1 +
>  tcg/arm/tcg-target.inc.c           |   4 +-
>  tcg/tcg-opc.h                      |   4 +-
>  tcg/tcg.h                          |  10 +
>  tests/multiboot/.gitignore         |   3 +
>  tests/multiboot/Makefile           |  22 +-
>  tests/multiboot/aout_kludge.S      | 138 +++++++++++
>  tests/multiboot/aout_kludge.out    |  42 ++++
>  tests/multiboot/run_test.sh        |  34 +--
>  tests/qemu-iotests/024             |  82 ++++++-
>  tests/qemu-iotests/024.out         |  30 +++
>  tests/qemu-iotests/060             |  30 +++
>  tests/qemu-iotests/060.out         |  14 ++
>  tests/qemu-iotests/106             |  24 ++
>  tests/qemu-iotests/106.out         |  10 +
>  tests/qemu-iotests/153             |  17 ++
>  tests/qemu-iotests/153.out         |  16 ++
>  tests/qemu-iotests/221             |  60 +++++
>  tests/qemu-iotests/221.out         |  16 ++
>  tests/qemu-iotests/group           |   1 +
>  ui/console.c                       |   5 +
>  util/Makefile.objs                 |   1 +
>  util/iova-tree.c                   | 114 +++++++++
>  util/memfd.c                       |   4 +-
>  109 files changed, 2072 insertions(+), 585 deletions(-)
>  create mode 100644 include/qemu/iova-tree.h
>  create mode 100644 tests/multiboot/.gitignore
>  create mode 100644 tests/multiboot/aout_kludge.S
>  create mode 100644 tests/multiboot/aout_kludge.out
>  create mode 100755 tests/qemu-iotests/221
>  create mode 100644 tests/qemu-iotests/221.out
>  create mode 100644 util/iova-tree.c
>=20
