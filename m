Received: from eggs.gnu.org ([2001:4830:134:3::10]:41702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHtO-000809-7n
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duHtK-00079i-Vr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duHtK-000793-Ns
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C94C5C05A1BE
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:44:41 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-61.ams2.redhat.com
	[10.36.117.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 208935D982
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:44:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:44:38 +0200
Message-Id: <20170919124440.30017-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/50] Misc patches for 2017-09-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ec=
c8:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' int=
o staging (2017-09-19 10:13:51 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 793d286eab5c6eedf68667a081f676a0323210b2:

  docker: fix creation of archives (2017-09-19 14:43:11 +0200)

----------------------------------------------------------------
* warning improvements (Alistair)
* KVM code cleanup (David)
* scsi-block support for rerror/werror (Fam)
* support for >64 vCPUs in Windows (Gonglei)
* SCSI fix (Hannes)
* SSE bugfixes (Joseph)
* SmartOS compilation fixes (Kamil)
* Hyper-V frequency MSR support (Ladi)
* move more files to accel/tcg (Philippe, Thomas)
* multiboot validation (PJP)
* virtqueue size configuration for virtio-scsi (Richard)
* Hyper-V header cleanup (Roman)
* Maintainer email update (Guangrong)
* checkpatch.pl --branch (Daniel), fixes (Greg)
* introducing scsi/ (me)

----------------------------------------------------------------
Alistair Francis (8):
      hw/i386: Improve some of the warning messages
      Convert remaining error_report() to warn_report()
      Convert single line fprintf(.../n) to warn_report()
      Convert multi-line fprintf() to warn_report()
      General warn report fixups
      target/mips: Convert VM clock update prints to warn_report
      Makefile: Remove libqemustub.a
      Convert remaining single line fprintf() to warn_report()

Daniel P. Berrange (1):
      scripts: let checkpatch.pl process an entire GIT branch

David Hildenbrand (6):
      kvm: require JOIN_MEMORY_REGIONS_WORKS
      kvm: factor out alignment of memory section
      kvm: use start + size for memory ranges
      kvm: we never have overlapping slots in kvm_set_phys_mem()
      kvm: kvm_log_start/stop are only called with known sections
      kvm: kvm_log_sync() is only called with known memory sections

Eric Blake (1):
      osdep.h: Prohibit disabling assert() in supported builds

Fam Zheng (4):
      scsi: Refactor scsi sense interpreting code
      scsi: Improve scsi_sense_to_errno
      scsi: Introduce scsi_sense_buf_to_errno
      scsi-block: Support rerror/werror

Gonglei (1):
      i386/cpu/hyperv: support over 64 vcpus for windows guests

Greg Kurz (1):
      checkpatch: add hwaddr to @typeList

Hannes Reinecke (1):
      scsi-bus: correct responses for INQUIRY and REQUEST SENSE

Joseph Myers (5):
      target/i386: fix pmovsx/pmovzx in-place operations
      target/i386: set rip_offset for further SSE instructions
      target/i386: fix packusdw in-place operation
      target/i386: fix pcmpxstrx substring search
      target/i386: fix phminposuw in-place operation

Kamil Rytarowski (2):
      memory: Rename queue to mrqueue (memory region queue)
      scsi/esp: Rename the ESP macro to ESP_STATE

Ladi Prosek (4):
      i386/kvm: use a switch statement for MSR detection
      i386/kvm: set tsc_khz before configuring Hyper-V CPUID
      i386/kvm: introduce tsc_is_stable_and_known()
      i386/kvm: advertise Hyper-V frequency MSRs

Paolo Bonzini (7):
      scsi: rename scsi_build_sense to scsi_convert_sense
      scsi: move non-emulation specific code to scsi/
      scsi: introduce scsi_build_sense
      scsi: introduce sg_io_sense_from_errno
      scsi: move block/scsi.h to include/scsi/constants.h
      target/i386: fix "info mem" for LA57 mode
      docker: fix creation of archives

Philippe Mathieu-Daud=C3=A9 (3):
      MAINTAINERS: update email, add missing test entry for megasas
      test-qga: add missing qemu-ga tool dependency
      accel/hax: move hax-stub.c to accel/stubs/

Prasad J Pandit (1):
      multiboot: validate multiboot header address values

Richard W.M. Jones (1):
      virtio-scsi: Add virtqueue_size parameter allowing virtqueue size t=
o be set.

Roman Kagan (2):
      hyperv: add header with protocol definitions
      update-linux-headers: prepare for hyperv.h removal

Thomas Huth (1):
      default-configs: Replace $(and ...) with $(call land, ...)

Xiao Guangrong (1):
      MAINTAINERS: update mail address for NVDIMM

 MAINTAINERS                                |  14 +-
 Makefile                                   |   7 +-
 Makefile.objs                              |   2 +-
 Makefile.target                            |   3 +-
 accel/kvm/kvm-all.c                        | 242 ++++---------
 accel/stubs/Makefile.objs                  |   1 +
 hax-stub.c =3D> accel/stubs/hax-stub.c       |   0
 block/iscsi.c                              |  51 +--
 block/qcow2.c                              |   9 +-
 block/vvfat.c                              |   7 +-
 default-configs/pci.mak                    |   2 +-
 default-configs/ppc-softmmu.mak            |   2 +-
 default-configs/ppc64-softmmu.mak          |   4 +-
 default-configs/s390x-softmmu.mak          |   2 +-
 docs/devel/build-system.txt                |  18 +-
 hw/acpi/core.c                             |  10 +-
 hw/arm/vexpress.c                          |   4 +-
 hw/block/virtio-blk.c                      |   2 +-
 hw/i386/acpi-build.c                       |  15 +-
 hw/i386/multiboot.c                        |  19 +
 hw/i386/pc.c                               |   9 +-
 hw/i386/pc_q35.c                           |   8 +-
 hw/i386/xen/xen-mapcache.c                 |   5 +-
 hw/mips/mips_malta.c                       |   4 +-
 hw/mips/mips_r4k.c                         |   5 +-
 hw/misc/applesmc.c                         |   2 +-
 hw/s390x/s390-virtio.c                     |  18 +-
 hw/scsi/esp.c                              |  10 +-
 hw/scsi/megasas.c                          |   2 +-
 hw/scsi/mptendian.c                        |   2 +-
 hw/scsi/mptsas.c                           |   8 +-
 hw/scsi/scsi-bus.c                         | 440 ++---------------------
 hw/scsi/scsi-disk.c                        |  43 ++-
 hw/scsi/scsi-generic.c                     |  50 +--
 hw/scsi/spapr_vscsi.c                      |   2 +-
 hw/scsi/virtio-scsi-dataplane.c            |   2 +-
 hw/scsi/virtio-scsi.c                      |  10 +-
 hw/scsi/vmw_pvscsi.c                       |   2 +-
 hw/usb/dev-uas.c                           |   2 +-
 hw/usb/hcd-ehci.c                          |   5 +-
 hw/virtio/virtio-balloon.c                 |   3 +-
 hw/virtio/virtio.c                         |   6 +-
 include/hw/i386/pc.h                       |   5 +
 include/hw/ide/internal.h                  |   2 +-
 include/hw/scsi/scsi.h                     |  94 +----
 include/hw/virtio/virtio-scsi.h            |   2 +-
 include/qemu/osdep.h                       |  16 +
 include/{block/scsi.h =3D> scsi/constants.h} |   2 -
 include/scsi/utils.h                       | 124 +++++++
 memory.c                                   |  22 +-
 net/hub.c                                  |  10 +-
 net/net.c                                  |  15 +-
 qga/vss-win32.c                            |   3 +-
 scripts/checkpatch.pl                      | 139 ++++++--
 scripts/update-linux-headers.sh            |   4 +-
 scsi/Makefile.objs                         |   1 +
 scsi/utils.c                               | 538 +++++++++++++++++++++++=
++++++
 target/i386/cpu.c                          |  30 +-
 target/i386/cpu.h                          |  12 +-
 target/i386/hax-mem.c                      |   6 +-
 target/i386/hyperv-proto.h                 | 260 ++++++++++++++
 target/i386/hyperv.c                       |   6 +-
 target/i386/kvm.c                          | 195 ++++++-----
 target/i386/machine.c                      |  15 +-
 target/i386/monitor.c                      |   8 +-
 target/i386/ops_sse.h                      |  47 +--
 target/i386/translate.c                    |   3 +-
 target/mips/kvm.c                          |  10 +-
 target/ppc/translate_init.c                |  17 +-
 target/s390x/kvm.c                         |   4 +-
 tests/Makefile.include                     |  11 +-
 tests/docker/Makefile.include              |   1 -
 tests/virtio-scsi-test.c                   |   2 +-
 trace/control.c                            |   4 +-
 trace/simple.c                             |   3 +-
 ui/keymaps.c                               |  10 +-
 ui/spice-display.c                         |   2 +-
 util/cutils.c                              |   3 +-
 util/main-loop.c                           |   6 +-
 79 files changed, 1572 insertions(+), 1112 deletions(-)
 rename hax-stub.c =3D> accel/stubs/hax-stub.c (100%)
 rename include/{block/scsi.h =3D> scsi/constants.h} (99%)
 create mode 100644 include/scsi/utils.h
 create mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/utils.c
 create mode 100644 target/i386/hyperv-proto.h
--=20
2.13.5
