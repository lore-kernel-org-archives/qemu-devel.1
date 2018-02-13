Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elPei-0003a6-JL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1elPef-0004O1-MS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:45:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1elPef-0004Mt-BN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:45:09 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1D1iDaZ045620
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:45:07 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3hj7t4sc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:45:07 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 18:45:06 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 19:44:52 -0600
Message-Id: <151848629234.28114.7839843408303313480@sif>
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
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com

Quoting Michael Roth (2018-02-06 13:14:21)
> Hi everyone,                                                             =
                                 =

> =

> The following new patches are queued for QEMU stable v2.11.1:
> =

>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> =

> The release is planned for 2017-02-14:
> =

>   https://wiki.qemu.org/Planning/2.11
> =

> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> =

> Of particular importance would be any feedback on the various QEMU
> patches relating to Spectre/Meltdown mitigation. The current tree has
> what I understand to be the QEMU components required for x86, s390,
> and pseries, but feedback/confirmation from the various authors would
> be greatly appreciated.

Thank you for the responses/suggestions. The following additional
patches have been queued for the release and pushed to:

https://github.com/mdroth/qemu/commits/stable-2.11-staging

spapr: add missing break in h_get_cpu_characteristics() (Greg Kurz)
vga: check the validation of memory addr when draw text (linzhecheng)
input: fix memory leak (linzhecheng)
ui: correctly advance output buffer when writing SASL data (Daniel P.  Berr=
ang=C3=A9)
ui: avoid sign extension using client width/height (Daniel P. Berrange)
ui: mix misleading comments & return types of VNC I/O helper methods (Danie=
l P. Berrange)
ui: add trace events related to VNC client throttling (Daniel P.  Berrange)
ui: place a hard cap on VNC server output buffer size (Daniel P.  Berrange)
ui: fix VNC client throttling when forced update is requested (Daniel P.  B=
errange)
ui: fix VNC client throttling when audio capture is active (Daniel P.  Berr=
ange)
ui: refactor code for determining if an update should be sent to the client=
 (Daniel P. Berrange)
ui: correctly reset framebuffer update state after processing dirty regions=
 (Daniel P. Berrange)
ui: introduce enum to track VNC client framebuffer update request state (Da=
niel P. Berrange)
ui: track how much decoded data we consumed when doing SASL encoding (Danie=
l P. Berrange)
ui: avoid pointless VNC updates if framebuffer isn't dirty (Daniel P.  Berr=
ange)
ui: remove redundant indentation in vnc_client_update (Daniel P.  Berrange)
ui: remove unreachable code in vnc_update_client (Daniel P. Berrange)
ui: remove 'sync' parameter from vnc_update_client (Daniel P. Berrange)
migration: incoming postcopy advise sanity checks (Greg Kurz)
target/sh4: add missing tcg_temp_free() in _decode_opc() (Philippe Mathieu-=
Daud=C3=A9)
migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32 (Daniel Henri=
que Barboza)
migration: Recover block devices if failure in device state (Dr. David Alan=
 Gilbert)
migration: Don't leak IO channels (Ross Lagerwall)
s390x/sclp: fix event mask handling (Christian Borntraeger)
memory: set ioeventfd_update_pending after address_space_update_ioeventfds =
(linzhecheng)

> =

> Thanks!
> =

> ----------------------------------------------------------------
> =

> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a6=
39:
> =

>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
> =

> are available in the git repository at:
> =

>   git://github.com/mdroth/qemu.git stable-2.11-staging
> =

> for you to fetch changes up to ed8b4ecc68d6bfe98000b08d649049d0c1174c11:
> =

>   target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS (2018-02-05 19:0=
7:38 -0600)
> =

> ----------------------------------------------------------------
> Alex Benn=C3=A9e (1):
>       target/sh4: fix TCG leak during gusa sequence
> =

> Alex Williamson (1):
>       vfio: Fix vfio-kvm group registration
> =

> Christian Borntraeger (2):
>       s390x/kvm: Handle bpb feature
>       s390x/kvm: provide stfle.81
> =

> Claudio Imbrenda (1):
>       s390x: fix storage attributes migration for non-small guests
> =

> Cornelia Huck (1):
>       linux-headers: update
> =

> C=C3=A9dric Le Goater (1):
>       target/ppc: introduce the PPC_BIT() macro
> =

> David Gibson (7):
>       spapr: Add pseries-2.12 machine type
>       spapr: Capabilities infrastructure
>       spapr: Treat Hardware Transactional Memory (HTM) as an optional cap=
ability
>       spapr: Validate capabilities on migration
>       target/ppc: Clean up probing of VMX, VSX and DFP availability on KVM
>       spapr: Handle VMX/VSX presence as an spapr capability flag
>       spapr: Handle Decimal Floating Point (DFP) as an optional capability
> =

> Eduardo Habkost (5):
>       i386: Change X86CPUDefinition::model_id to const char*
>       i386: Add spec-ctrl CPUID bit
>       i386: Add FEAT_8000_0008_EBX CPUID feature word
>       i386: Add new -IBRS versions of Intel CPU models
>       i386: Add EPYC-IBPB CPU model
> =

> Eric Auger (1):
>       linux-headers: update to 4.15-rc1
> =

> Fam Zheng (3):
>       block: Open backing image in force share mode for size probe
>       osdep: Retry SETLK upon EINTR
>       usb-storage: Fix share-rw option parsing
> =

> Greg Kurz (2):
>       spapr_pci: fix MSI/MSIX selection
>       spapr: fix device tree properties when using compatibility mode
> =

> Jay Zhou (1):
>       vhost: remove assertion to prevent crash
> =

> Jose Ricardo Ziviani (1):
>       ppc: Change Power9 compat table to support at most 8 threads/core
> =

> Kevin Wolf (2):
>       block: Make bdrv_drain_invoke() recursive
>       block: Call .drain_begin only once in bdrv_drain_all_begin()
> =

> Laurent Vivier (1):
>       spapr: don't initialize PATB entry if max-cpu-compat < power9
> =

> Marcel Apfelbaum (1):
>       hw/pci-bridge: fix QEMU crash because of pcie-root-port
> =

> Markus Armbruster (1):
>       qemu-options: Remove stray colons from output of --help
> =

> Michael S. Tsirkin (1):
>       virtio_error: don't invoke status callbacks
> =

> Murilo Opsfelder Araujo (1):
>       block/nbd: fix segmentation fault when .desc is not null-terminated
> =

> Paolo Bonzini (2):
>       qemu-pr-helper: miscellaneous fixes
>       i386: Add support for SPEC_CTRL MSR
> =

> Peter Lieven (1):
>       block/iscsi: dont leave allocmap in an invalid state on UNMAP failu=
re
> =

> Peter Maydell (8):
>       target/i386: Fix handling of VEX prefixes
>       hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
>       hw/intc/arm_gic: reserved register addresses are RAZ/WI
>       hw/sd/pl181: Reset SD card on controller reset
>       hw/sd/milkymist-memcard: Reset SD card on controller reset
>       hw/sd/ssi-sd: Reset SD card on controller reset
>       linux-user: Fix locking order in fork_start()
>       linux-user/signal.c: Rename MC_* defines
> =

> Stefan Hajnoczi (1):
>       scsi-disk: release AioContext in unaligned WRITE SAME case
> =

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
> =

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
> =

>=20
