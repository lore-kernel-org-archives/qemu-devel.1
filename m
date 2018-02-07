Received: from eggs.gnu.org ([2001:4830:134:3::10]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ejMFG-0000zw-Pk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ejMFB-0007Wp-Rk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:42:26 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:59795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ejMFB-0007Vo-HD
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:42:21 -0500
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 86ACD119BDC
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 10:42:18 +0100 (CET)
Date: Wed, 7 Feb 2018 10:42:09 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180207104209.428a4832@bahia.lan>
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/54] Patch Round-up for
 stable 2.11.1, freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

Hi Michael,

On Tue,  6 Feb 2018 13:14:21 -0600
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Hi everyone,                                                             =
                                =20
>=20
> The following new patches are queued for QEMU stable v2.11.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
>=20
> The release is planned for 2017-02-14:
>=20
>   https://wiki.qemu.org/Planning/2.11
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20

Maybe worth to pick the following patch when it gets merged:

http://patchwork.ozlabs.org/patch/869873/

It fixes a 2.11 regression with RAM postcopy.

> Of particular importance would be any feedback on the various QEMU
> patches relating to Spectre/Meltdown mitigation. The current tree has
> what I understand to be the QEMU components required for x86, s390,
> and pseries, but feedback/confirmation from the various authors would
> be greatly appreciated.
>=20

Patch 54 "target/ppc/spapr: Add H-Call  H_GET_CPU_CHARACTERISTICS" has a
trivial but potentially embarrassing bug (QEMU aborts if the host supports
KVM_PPC_CPU_CHAR_BCCTRL_SERIALISED and cap-ibs=3D"fixed" is used).

A patch was sent to the list:

http://patchwork.ozlabs.org/patch/868426/

AFAIK David Gibson (Cc'd) is away and I don't know when this patch
will be merged.

Cheers,

--
Greg

> Thanks!
>=20
> ----------------------------------------------------------------
>=20
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a6=
39:
>=20
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>=20
> are available in the git repository at:
>=20
>   git://github.com/mdroth/qemu.git stable-2.11-staging
>=20
> for you to fetch changes up to ed8b4ecc68d6bfe98000b08d649049d0c1174c11:
>=20
>   target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS (2018-02-05 19:0=
7:38 -0600)
>=20
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       target/sh4: fix TCG leak during gusa sequence
>=20
> Alex Williamson (1):
>       vfio: Fix vfio-kvm group registration
>=20
> Christian Borntraeger (2):
>       s390x/kvm: Handle bpb feature
>       s390x/kvm: provide stfle.81
>=20
> Claudio Imbrenda (1):
>       s390x: fix storage attributes migration for non-small guests
>=20
> Cornelia Huck (1):
>       linux-headers: update
>=20
> C=C3=A9dric Le Goater (1):
>       target/ppc: introduce the PPC_BIT() macro
>=20
> David Gibson (7):
>       spapr: Add pseries-2.12 machine type
>       spapr: Capabilities infrastructure
>       spapr: Treat Hardware Transactional Memory (HTM) as an optional cap=
ability
>       spapr: Validate capabilities on migration
>       target/ppc: Clean up probing of VMX, VSX and DFP availability on KVM
>       spapr: Handle VMX/VSX presence as an spapr capability flag
>       spapr: Handle Decimal Floating Point (DFP) as an optional capability
>=20
> Eduardo Habkost (5):
>       i386: Change X86CPUDefinition::model_id to const char*
>       i386: Add spec-ctrl CPUID bit
>       i386: Add FEAT_8000_0008_EBX CPUID feature word
>       i386: Add new -IBRS versions of Intel CPU models
>       i386: Add EPYC-IBPB CPU model
>=20
> Eric Auger (1):
>       linux-headers: update to 4.15-rc1
>=20
> Fam Zheng (3):
>       block: Open backing image in force share mode for size probe
>       osdep: Retry SETLK upon EINTR
>       usb-storage: Fix share-rw option parsing
>=20
> Greg Kurz (2):
>       spapr_pci: fix MSI/MSIX selection
>       spapr: fix device tree properties when using compatibility mode
>=20
> Jay Zhou (1):
>       vhost: remove assertion to prevent crash
>=20
> Jose Ricardo Ziviani (1):
>       ppc: Change Power9 compat table to support at most 8 threads/core
>=20
> Kevin Wolf (2):
>       block: Make bdrv_drain_invoke() recursive
>       block: Call .drain_begin only once in bdrv_drain_all_begin()
>=20
> Laurent Vivier (1):
>       spapr: don't initialize PATB entry if max-cpu-compat < power9
>=20
> Marcel Apfelbaum (1):
>       hw/pci-bridge: fix QEMU crash because of pcie-root-port
>=20
> Markus Armbruster (1):
>       qemu-options: Remove stray colons from output of --help
>=20
> Michael S. Tsirkin (1):
>       virtio_error: don't invoke status callbacks
>=20
> Murilo Opsfelder Araujo (1):
>       block/nbd: fix segmentation fault when .desc is not null-terminated
>=20
> Paolo Bonzini (2):
>       qemu-pr-helper: miscellaneous fixes
>       i386: Add support for SPEC_CTRL MSR
>=20
> Peter Lieven (1):
>       block/iscsi: dont leave allocmap in an invalid state on UNMAP failu=
re
>=20
> Peter Maydell (8):
>       target/i386: Fix handling of VEX prefixes
>       hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
>       hw/intc/arm_gic: reserved register addresses are RAZ/WI
>       hw/sd/pl181: Reset SD card on controller reset
>       hw/sd/milkymist-memcard: Reset SD card on controller reset
>       hw/sd/ssi-sd: Reset SD card on controller reset
>       linux-user: Fix locking order in fork_start()
>       linux-user/signal.c: Rename MC_* defines
>=20
> Stefan Hajnoczi (1):
>       scsi-disk: release AioContext in unaligned WRITE SAME case
>=20
> Suraj Jitindar Singh (8):
>       hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal represen=
tation
>       target/ppc/spapr_caps: Add macro to generate spapr_caps migration v=
mstate
>       target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_branc=
h]
>       target/ppc/spapr_caps: Add support for tristate spapr_capabilities
>       target/ppc/spapr_caps: Add new tristate cap safe_cache
>       target/ppc/spapr_caps: Add new tristate cap safe_bounds_check
>       target/ppc/spapr_caps: Add new tristate cap safe_indirect_branch
>       target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
>=20
>  block.c                                            |   3 +-
>  block/io.c                                         |  13 +-
>  block/iscsi.c                                      |   8 +-
>  block/nbd.c                                        |   1 +
>  hw/intc/arm_gic.c                                  |   5 +-
>  hw/intc/arm_gicv3_dist.c                           |  13 +
>  hw/intc/arm_gicv3_its_common.c                     |   8 +-
>  hw/intc/arm_gicv3_redist.c                         |  13 +
>  hw/pci-bridge/gen_pcie_root_port.c                 |   7 +-
>  hw/ppc/Makefile.objs                               |   2 +-
>  hw/ppc/spapr.c                                     | 130 ++++--
>  hw/ppc/spapr_caps.c                                | 443 +++++++++++++++=
+++++
>  hw/ppc/spapr_cpu_core.c                            |   7 +
>  hw/ppc/spapr_hcall.c                               |  58 +++
>  hw/ppc/spapr_pci.c                                 |  61 ++-
>  hw/s390x/s390-stattrib-kvm.c                       |   4 +-
>  hw/scsi/scsi-bus.c                                 |   9 +-
>  hw/scsi/scsi-disk.c                                |   1 +
>  hw/sd/milkymist-memcard.c                          |   4 +
>  hw/sd/pl181.c                                      |   4 +
>  hw/sd/ssi-sd.c                                     |  25 +-
>  hw/usb/dev-storage.c                               |   3 +-
>  hw/vfio/common.c                                   |   1 +
>  hw/virtio/vhost-user.c                             |   5 +-
>  hw/virtio/virtio.c                                 |   2 +-
>  include/hw/compat.h                                |   2 +
>  include/hw/ppc/spapr.h                             |  74 ++++
>  include/hw/scsi/scsi.h                             |   1 +
>  include/scsi/utils.h                               |   6 +-
>  include/standard-headers/asm-s390/virtio-ccw.h     |   5 +-
>  include/standard-headers/asm-x86/hyperv.h          | 394 +--------------=
---
>  include/standard-headers/linux/input-event-codes.h |   2 +
>  include/standard-headers/linux/input.h             |   1 +
>  include/standard-headers/linux/pci_regs.h          |  45 +-
>  linux-headers/asm-arm/kvm.h                        |   8 +
>  linux-headers/asm-arm/kvm_para.h                   |   1 +
>  linux-headers/asm-arm/unistd.h                     |   2 +
>  linux-headers/asm-arm64/kvm.h                      |   8 +
>  linux-headers/asm-arm64/unistd.h                   |   1 +
>  linux-headers/asm-powerpc/epapr_hcalls.h           |   1 +
>  linux-headers/asm-powerpc/kvm.h                    |  26 ++
>  linux-headers/asm-powerpc/kvm_para.h               |   1 +
>  linux-headers/asm-powerpc/unistd.h                 |   1 +
>  linux-headers/asm-s390/kvm.h                       |  10 +-
>  linux-headers/asm-s390/kvm_para.h                  |   5 +-
>  linux-headers/asm-s390/unistd.h                    |   4 +-
>  linux-headers/asm-x86/kvm.h                        |   1 +
>  linux-headers/asm-x86/kvm_para.h                   |   2 +-
>  linux-headers/asm-x86/unistd.h                     |   1 +
>  linux-headers/linux/kvm.h                          |  10 +-
>  linux-headers/linux/kvm_para.h                     |   1 +
>  linux-headers/linux/psci.h                         |   1 +
>  linux-headers/linux/userfaultfd.h                  |   1 +
>  linux-headers/linux/vfio.h                         |   1 +
>  linux-headers/linux/vfio_ccw.h                     |   1 +
>  linux-headers/linux/vhost.h                        |   1 +
>  linux-user/main.c                                  |   4 +-
>  linux-user/signal.c                                | 118 +++---
>  qemu-options-wrapper.h                             |   2 +-
>  qemu-options.hx                                    |  27 +-
>  scripts/hxtool                                     |   3 +-
>  scsi/qemu-pr-helper.c                              |  30 +-
>  scsi/utils.c                                       |  10 +
>  target/i386/cpu.c                                  | 455 +++++++++++++++=
+++++-
>  target/i386/cpu.h                                  |   7 +
>  target/i386/kvm.c                                  |  14 +
>  target/i386/machine.c                              |  20 +
>  target/i386/translate.c                            |   2 +-
>  target/ppc/compat.c                                |   9 +-
>  target/ppc/cpu.h                                   | 105 ++---
>  target/ppc/kvm.c                                   |  85 +++-
>  target/ppc/kvm_ppc.h                               |  20 +-
>  target/s390x/cpu.c                                 |   1 +
>  target/s390x/cpu.h                                 |   1 +
>  target/s390x/cpu_features.c                        |   2 +
>  target/s390x/cpu_features_def.h                    |   2 +
>  target/s390x/gen-features.c                        |   2 +
>  target/s390x/kvm.c                                 |  14 +
>  target/s390x/machine.c                             |  17 +
>  target/sh4/translate.c                             |   2 +-
>  util/osdep.c                                       |   4 +-
>  81 files changed, 1746 insertions(+), 658 deletions(-)
>  create mode 100644 hw/ppc/spapr_caps.c
>=20
>=20
