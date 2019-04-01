Received: from eggs.gnu.org ([209.51.188.92]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47C-0003nM-1o
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB477-00050k-IZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004o6-2o
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4ie4114727
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:49 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksvqgyv3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:45 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:48 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
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

Hi everyone,                                                             =
                                =20

The following new patches are queued for QEMU stable v3.0.1:

  https://github.com/mdroth/qemu/commits/stable-3.0-staging

The release is planned for 2019-04-11:

  https://wiki.qemu.org/Planning/3.0

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Note that this update falls outside the normal stable release support
window (~1 development cycle), but is being release now since it was
delayed from its intended release date.

Thanks!

----------------------------------------------------------------
Alberto Garcia (1):
      block: Fix use after free error in bdrv_open_inherit()

BALATON Zoltan (1):
      i2c: Move typedef of bitbang_i2c_interface to i2c.h

Bharata B Rao (1):
      spapr_cpu_core: vmstate_[un]register per-CPU data from (un)realizef=
n

Christian Borntraeger (1):
      iotests: make 235 work on s390 (and others)

Corey Minyard (2):
      i2c: Add a length check to the SMBus write handling
      pc:piix4: Update smbus I/O space after a migration

Daniel Henrique Barboza (1):
      qga: update docs with systemd suspend support info

Daniel P. Berrang=C3=A9 (1):
      qemu-img: fix regression copying secrets during convert

Denis V. Lunev (1):
      nbd: fix NBD_FLAG_SEND_CACHE value

Eduardo Habkost (1):
      i386: Disable TOPOEXT by default on "-cpu host"

Eric Blake (4):
      nbd/server: Advertise all contexts in response to bare LIST
      nbd/client: Make x-dirty-bitmap more reliable
      nbd/client: Send NBD_CMD_DISC if open fails after connect
      bitmap: Update count after a merge

Fam Zheng (5):
      nvme: Fix nvme_init error handling
      aio-posix: Don't count ctx->notifier as progress when polling
      aio: Do aio_notify_accept only during blocking aio_poll
      slirp: Add sanity check for str option length
      job: Fix nested aio_poll() hanging in job_txn_apply

Gerd Hoffmann (3):
      fmops: fix off-by-one in AR_TABLE and DR_TABLE array size
      usb-mtp: outlaw slashes in filenames
      usb-mtp: use O_NOFOLLOW and O_CLOEXEC.

Greg Kurz (1):
      9p: fix QEMU crash when renaming files

Igor Mammedov (1):
      pc: acpi: revert back to 1 SRAT entry for hotpluggable area

Ilya Maximets (1):
      migration: Stop postcopy fault thread before notifying

Janosch Frank (1):
      s390x: Return specification exception for unimplemented diag 308 su=
bcodes

Jason Wang (5):
      ne2000: fix possible out of bound access in ne2000_receive
      rtl8139: fix possible out of bound access
      pcnet: fix possible buffer overflow
      net: ignore packet size greater than INT_MAX
      net: drop too large packet early

Jeff Cody (6):
      block: for jobs, do not clear user_paused until after the resume
      block: iotest to catch abort on forced blockjob cancel
      block/rbd: pull out qemu_rbd_convert_options
      block/rbd: Attempt to parse legacy filenames
      block/rbd: add iotest for rbd legacy keyvalue filename parsing
      block/rbd: add deprecation documentation for filename keyvalue pair=
s

Kevin Wolf (4):
      block/qapi: Fix memory leak in qmp_query_blockstats()
      mirror: Fail gracefully for source =3D=3D target
      block-backend: Set werror/rerror defaults in blk_new()
      block: Fix invalidate_cache error path for parent activation

Liam Merwick (1):
      tpm_tis: fix loop that cancels any seizure by a lower locality

Marc-Andr=C3=A9 Lureau (1):
      monitor: fix oob command leak

Marcel Apfelbaum (1):
      hw/rdma: another clang compilation fix

Mark Cave-Ayland (1):
      fdc: fix segfault in fdctrl_stop_transfer() when DMA is disabled

Markus Armbruster (1):
      vfio-helpers: Fix qemu_vfio_open_pci() crash

Max Filippov (3):
      target/xtensa: fix FPU2000 bugs
      target/xtensa: fix s32c1i TCGMemOp flags
      target/xtensa: drop num_[core_]regs from dc232b/dc233c configs

Max Reitz (2):
      qemu-img: Fix typo
      qemu-img: Fix leak

Michael Roth (1):
      make-release: add skiboot .version file

Michael S. Tsirkin (1):
      tests: update acpi expected files

Paolo Bonzini (3):
      virtio: update MemoryRegionCaches when guest negotiates features
      virtio: do not take address of packed members
      nvme: fix out-of-bounds access to the CMB

Paul A. Clarke (1):
      Changes requirement for "vsubsbs" instruction

Peter Maydell (4):
      virt: Suppress external aborts on virt-2.10 and earlier
      target/arm: Correct condition for v8M callee stack push
      linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
      exec.c: Don't reallocate IOMMUNotifiers that are in use

Peter Wu (1):
      vnc: fix memleak of the "vnc-worker-output" name

Peter Xu (2):
      intel_iommu: introduce vtd_reset_caches()
      intel_iommu: better handling of dmar state switch

Prasad J Pandit (1):
      tpm: use loop iterator to set sts data field

Prasad Singamsetty (1):
      kvm: add call to qemu_add_opts() for -overcommit option

Richard Henderson (16):
      target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
      target/arm: Fix typo in do_sat_addsub_64
      target/arm: Reorganize SVE WHILE
      target/arm: Fix typo in helper_sve_movz_d
      target/arm: Fix typo in helper_sve_ld1hss_r
      target/arm: Fix sign-extension in sve do_ldr/do_str
      target/arm: Fix offset for LD1R instructions
      target/arm: Fix offset scaling for LD_zprr and ST_zprr
      target/arm: Reformat integer register dump
      target/arm: Dump SVE state if enabled
      target/arm: Add sve-max-vq cpu property to -cpu max
      target/arm: Adjust FPCR_MASK for FZ16
      target/arm: Ignore float_flag_input_denormal from fp_status_f16
      target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h
      target/arm: Use FZ not FZ16 for SVE FCVT single-half and double-hal=
f
      target/arm: Fix cpu_get_tb_cpu_state() for non-SVE CPUs

Stefan Berger (4):
      tpm: Zero-init structure to avoid uninitialized variables in valgri=
nd log
      tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
      tpm: Make sure the locality received from backend is valid
      acpi: Make TPM 2.0 with TIS available as MSFT0101

Thomas Huth (1):
      hw/s390x: Fix bad mask in time2tod()

Tony Garnock-Jones (1):
      linux-user: write(fd, NULL, 0) parity with linux's treatment of sam=
e

Vladimir Sementsov-Ogievskiy (4):
      nbd/server: fix bitmap export
      nbd/server: fix NBD_CMD_CACHE
      mirror: fix dead-lock
      iotests: simple mirror test with kvm on 1G image

William Bowling (1):
      slirp: check sscanf result when emulating ident

Yury Kotov (1):
      vhost: fix invalid downcast

Zheng Xiang (1):
      pcie: set link state inactive/active after hot unplug/plug

liujunjie (1):
      clean up callback when del virtqueue

yuchenlin (1):
      vhost-scsi: prevent using uninitialized vqs

 block.c                                    |   2 +
 block/block-backend.c                      |   3 +
 block/mirror.c                             |  18 ++---
 block/nbd-client.c                         |  22 +++++-
 block/nvme.c                               |  37 ++++------
 block/qapi.c                               |   3 +-
 block/rbd.c                                |  90 ++++++++++++++++++++---=
-
 exec.c                                     |  10 +--
 hw/9pfs/9p.c                               |   3 +
 hw/acpi/piix4.c                            |   1 +
 hw/arm/virt.c                              |   2 +
 hw/audio/fmopl.h                           |   4 +-
 hw/block/fdc.c                             |   2 +-
 hw/block/nvme.c                            |   2 +-
 hw/char/virtio-serial-bus.c                |   6 +-
 hw/i2c/bitbang_i2c.h                       |   2 -
 hw/i2c/smbus.c                             |   6 +-
 hw/i386/acpi-build.c                       |  85 ++++++-----------------
 hw/i386/intel_iommu.c                      |  34 ++++++---
 hw/net/ne2000.c                            |   4 +-
 hw/net/pcnet.c                             |   4 +-
 hw/net/rtl8139.c                           |   8 +--
 hw/pci/pcie.c                              |  12 ++++
 hw/ppc/spapr_cpu_core.c                    |  62 +++++++++--------
 hw/rdma/rdma_rm_defs.h                     |   4 +-
 hw/scsi/vhost-scsi.c                       |   2 +-
 hw/tpm/tpm_emulator.c                      |   1 +
 hw/tpm/tpm_tis.c                           |  10 ++-
 hw/usb/dev-mtp.c                           |  19 ++++--
 hw/virtio/vhost.c                          |   4 +-
 hw/virtio/virtio.c                         |  17 ++++-
 include/block/nbd.h                        |   4 +-
 include/hw/i2c/i2c.h                       |   2 +
 include/hw/i2c/ppc4xx_i2c.h                |   3 -
 include/hw/s390x/tod.h                     |   2 +-
 include/net/net.h                          |   6 --
 job.c                                      |  20 ++----
 linux-user/syscall.c                       |  44 +++++++++---
 migration/postcopy-ram.c                   |  11 +--
 monitor.c                                  |   2 +
 nbd/server.c                               |   9 ++-
 net/net.c                                  |  23 +++++--
 net/slirp.c                                |   9 +++
 qemu-deprecated.texi                       |  15 ++++
 qemu-img.c                                 |  35 +++++-----
 qga/qapi-schema.json                       |  25 ++++---
 scripts/make-release                       |   1 +
 slirp/bootp.c                              |  32 ++++++---
 slirp/tcp_subr.c                           |  10 +--
 target/arm/cpu.c                           |   6 +-
 target/arm/cpu.h                           |   5 +-
 target/arm/cpu64.c                         |  29 ++++++++
 target/arm/helper.c                        |  55 +++++++++------
 target/arm/sve_helper.c                    |  23 +++----
 target/arm/translate-a64.c                 | 106 +++++++++++++++++++++++=
+-----
 target/arm/translate-sve.c                 |  81 +++++++++++++---------
 target/i386/cpu.c                          |   6 ++
 target/ppc/translate/vmx-ops.inc.c         |   2 +-
 target/s390x/diag.c                        |   2 +-
 target/xtensa/core-dc232b.c                |   2 -
 target/xtensa/core-dc232b/gdb-config.inc.c |   1 +
 target/xtensa/core-dc233c.c                |   2 -
 target/xtensa/core-dc233c/gdb-config.inc.c |   1 +
 target/xtensa/translate.c                  |   8 +--
 tests/Makefile.include                     |   2 +-
 tests/acpi-test-data/pc/DSDT               | Bin 5144 -> 5131 bytes
 tests/acpi-test-data/pc/DSDT.bridge        | Bin 7003 -> 6990 bytes
 tests/acpi-test-data/pc/DSDT.cphp          | Bin 5607 -> 5594 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm       | Bin 6803 -> 6790 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs       | Bin 5216 -> 5203 bytes
 tests/acpi-test-data/pc/DSDT.memhp         | Bin 6509 -> 6496 bytes
 tests/acpi-test-data/pc/DSDT.numamem       | Bin 5150 -> 5137 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm       | Bin 472 -> 392 bytes
 tests/acpi-test-data/pc/SRAT.memhp         | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/DSDT              | Bin 7828 -> 7815 bytes
 tests/acpi-test-data/q35/DSDT.bridge       | Bin 7845 -> 7832 bytes
 tests/acpi-test-data/q35/DSDT.cphp         | Bin 8291 -> 8278 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm      | Bin 9487 -> 9474 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt       | Bin 7903 -> 7890 bytes
 tests/acpi-test-data/q35/DSDT.memhp        | Bin 9193 -> 9180 bytes
 tests/acpi-test-data/q35/DSDT.numamem      | Bin 7834 -> 7821 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm      | Bin 472 -> 392 bytes
 tests/acpi-test-data/q35/SRAT.memhp        | Bin 264 -> 264 bytes
 tests/nvme-test.c                          |  68 +++++++++++++++---
 tests/qemu-iotests/041                     |   6 ++
 tests/qemu-iotests/041.out                 |   4 +-
 tests/qemu-iotests/067.out                 |   1 +
 tests/qemu-iotests/229                     |  95 +++++++++++++++++++++++=
+++
 tests/qemu-iotests/229.out                 |  23 +++++++
 tests/qemu-iotests/231                     |  62 +++++++++++++++++
 tests/qemu-iotests/231.out                 |   9 +++
 tests/qemu-iotests/235                     |  78 +++++++++++++++++++++
 tests/qemu-iotests/235.out                 |   3 +
 tests/qemu-iotests/group                   |   3 +
 ui/vnc-jobs.c                              |   3 +-
 util/aio-posix.c                           |   7 +-
 util/aio-win32.c                           |   3 +-
 util/hbitmap.c                             |   3 +
 util/vfio-helpers.c                        |   2 +-
 vl.c                                       |   1 +
 100 files changed, 1033 insertions(+), 401 deletions(-)
 create mode 100755 tests/qemu-iotests/229
 create mode 100644 tests/qemu-iotests/229.out
 create mode 100755 tests/qemu-iotests/231
 create mode 100644 tests/qemu-iotests/231.out
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out
