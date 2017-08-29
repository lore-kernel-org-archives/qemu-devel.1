Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC3-0000p6-NU
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC0-00052T-8p
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53828
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC0-000523-06
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EbP9087998
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmvhgaqh7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:43 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:42 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
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

The following new patches are queued for QEMU stable v2.9.1:

  https://github.com/mdroth/qemu/commits/stable-2.9-staging

The release is planned for 2017-09-07:

  http://wiki.qemu.org/Planning/2.9

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Testing/feedback is greatly appreciated.

Thanks!

----------------------------------------------------------------
Alberto Garcia (1):
      stream: fix crash in stream_start() when block_job_create() fails

Aleksandr Bezzubikov (1):
      hw/i386: allow SHPC for Q35 machine

Alexander Graf (2):
      hid: Reset kbd modifiers on reset
      input: Decrement queue count on kbd delay

Anton Nefedov (1):
      qemu-img: wait for convert coroutines to complete

Bruce Rogers (2):
      ACPI: don't call acpi_pcihp_device_plug_cb on xen
      9pfs: local: remove: use correct path component

Daniel P. Berrange (1):
      migration: setup bi-directional I/O channel for exec: protocol

Eduardo Habkost (1):
      pc: Use "min-[x]level" on compat_props

Eric Blake (16):
      dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
      coccinelle: Add script to remove useless QObject casts
      qobject: Drop useless QObject casts
      qobject: Add helper macros for common scalar insertions
      s390x: Drop useless casts
      qobject: Use simpler QDict/QList scalar insertion macros
      blkdebug: Sanity check block layer guarantees
      blkdebug: Refactor error injection
      blkdebug: Add pass-through write_zero and discard support
      blkdebug: Simplify override logic
      blkdebug: Add ability to override unmap geometries
      tests: Add coverage for recent block geometry fixes
      block: Simplify BDRV_BLOCK_RAW recursion
      block: Guarantee that *file is set on bdrv_get_block_status()
      nbd: Fully initialize client in case of failed negotiation
      nbd: Fix regression on resiliency to port scan

Fam Zheng (2):
      block: Reuse bs as backing hd for drive-backup sync=3Dnone
      virtio-scsi: Unset hotplug handler when unrealize

Gerd Hoffmann (1):
      input: limit kbd queue depth

Greg Kurz (7):
      9pfs: local: fix unlink of alien files in mapped-file mode
      virtio: allow broken device to notify guest
      target/ppc: pass const string to kvmppc_is_mem_backend_page_size_ok=
()
      target/ppc: fix memory leak in kvmppc_is_mem_backend_page_size_ok()
      spapr: fix memory leak in spapr_memory_pre_plug()
      spapr: fix memory leak in spapr_core_pre_plug()
      9pfs: local: fix fchmodat_nofollow() limitations

Halil Pasic (1):
      s390x/css: catch section mismatch on load

Herongguang (Stephen) (1):
      pci: deassert intx when pci device unrealize

Herv=C3=A9 Poussineau (1):
      vvfat: fix qemu-img map and qemu-img convert

Jason Wang (2):
      virtio-scsi: finalize IOMMU support
      virtio-net: fix offload ctrl endian

Jeff Cody (1):
      block/nfs: fix mutex assertion in nfs_file_close()

John Snow (1):
      blockdev: use drained_begin/end for qmp_block_resize

Kevin Wolf (6):
      mirror: Drop permissions on s->target on completion
      commit: Fix use after free in completion
      commit: Fix completion with extra reference
      commit: Add NULL check for overlay_bs
      qemu-iotests: Test automatic commit job cancel on hot unplug
      block: Skip implicit nodes in query-block/blockstats

Ladi Prosek (1):
      virtio-serial-bus: Unset hotplug handler when unrealize

Laurent Vivier (3):
      spapr: add pre_plug function for memory
      spapr: fix migration to pseries machine < 2.8
      cpu: don't allow negative core id

Markus Armbruster (1):
      replication: Make --disable-replication compile again

Max Filippov (3):
      target/xtensa: fix mapping direction in read/write simcalls
      target/xtensa: fix return value of read/write simcalls
      target/xtensa: handle unknown registers in gdbstub

Max Reitz (11):
      qemu-img/convert: Always set ret < 0 on error
      qemu-img/convert: Use @opts for one thing only
      qemu-img/convert: Move bs_n > 1 && -B check down
      block: An empty filename counts as no filename
      iotests/051: Add test for empty filename
      block: Do not unref bs->file on error in BD's open
      block/vhdx: Make vhdx_create() always set errp
      block: Add errp to b{lk,drv}_truncate()
      blkdebug: Catch bs->exact_filename overflow
      blkverify: Catch bs->exact_filename overflow
      block: Do not strcmp() with NULL uri->scheme

Michael Roth (2):
      tests: check-qom-proplist: add checks for cmdline-created objects
      monitor: fix object_del for command-line-created objects

Paolo Bonzini (5):
      curl: strengthen assertion in curl_clean_state
      curl: never invoke callbacks with s->mutex held
      curl: avoid recursive locking of BDRVCURLState mutex
      linuxboot_dma: compile for i486
      nbd: fix NBD over TLS

Sameeh Jubran (2):
      qga-win: Enable 'can-offline' field in 'guest-get-vcpus' reply
      e1000e: Fix ICR "Other" causes clear logic

Stefan Hajnoczi (1):
      aio: add missing aio_notify() to aio_enable_external()

Yunjian Wang (1):
      virtio-net: fix wild pointer when remove virtio-net queues

Zhiyong Yang (1):
      hw/virtio: fix vhost user fails to startup when MQ

 MAINTAINERS                         |   1 +
 block.c                             |  82 +++++-----
 block/blkdebug.c                    | 288 ++++++++++++++++++++++++++++--=
------
 block/blkreplay.c                   |   3 -
 block/blkverify.c                   |  26 ++--
 block/block-backend.c               |   5 +-
 block/commit.c                      |  24 ++-
 block/crypto.c                      |   2 +-
 block/curl.c                        |  33 ++++-
 block/dirty-bitmap.c                |   2 +-
 block/file-posix.c                  |   8 +-
 block/file-win32.c                  |   4 +-
 block/io.c                          |   9 +-
 block/mirror.c                      |  12 +-
 block/nbd-client.c                  |   4 +-
 block/nbd.c                         |  47 +++---
 block/nfs.c                         |  56 ++++---
 block/null.c                        |   2 +-
 block/parallels.c                   |  13 +-
 block/qapi.c                        |  34 ++++-
 block/qcow.c                        |   6 +-
 block/qcow2-refcount.c              |   5 +-
 block/qcow2.c                       |  18 ++-
 block/qed.c                         |   2 +-
 block/quorum.c                      |  16 +-
 block/raw-format.c                  |   2 +-
 block/rbd.c                         |  16 +-
 block/sheepdog.c                    |   6 +-
 block/snapshot.c                    |   2 +-
 block/ssh.c                         |  18 +--
 block/stream.c                      |   2 +-
 block/vdi.c                         |   4 +-
 block/vhdx-log.c                    |   2 +-
 block/vhdx.c                        |  29 +++-
 block/vmdk.c                        |  13 +-
 block/vpc.c                         |  13 +-
 block/vvfat.c                       |  13 +-
 blockdev-nbd.c                      |   6 +-
 blockdev.c                          |  71 ++++-----
 hw/9pfs/9p-local.c                  |  78 ++++++----
 hw/9pfs/9p-util.h                   |  24 +--
 hw/acpi/piix4.c                     |  11 +-
 hw/block/xen_disk.c                 |   2 +-
 hw/char/virtio-serial-bus.c         |   3 +
 hw/cpu/core.c                       |   5 +
 hw/i386/acpi-build.c                |   4 +-
 hw/input/hid.c                      |   1 +
 hw/net/e1000e_core.c                |  10 +-
 hw/net/virtio-net.c                 |   5 +
 hw/pci/pci.c                        |   1 +
 hw/ppc/spapr.c                      |  46 ++++--
 hw/ppc/spapr_pci.c                  |  28 ++--
 hw/s390x/css.c                      |  14 ++
 hw/s390x/virtio-ccw.c               |   6 +-
 hw/scsi/virtio-scsi.c               |   6 +-
 hw/usb/xen-usb.c                    |  12 +-
 hw/virtio/vhost-user.c              |  21 ++-
 hw/virtio/virtio.c                  |   4 +-
 include/block/aio.h                 |  10 +-
 include/block/block.h               |   3 +-
 include/block/block_int.h           |   1 +
 include/block/nbd.h                 |   2 +-
 include/hw/i386/pc.h                |  42 +++---
 include/qapi/qmp/qdict.h            |   8 +
 include/qapi/qmp/qlist.h            |   8 +
 include/sysemu/block-backend.h      |   2 +-
 migration/colo.c                    |  12 ++
 migration/exec.c                    |   4 +-
 monitor.c                           |  28 ++--
 nbd/server.c                        |  32 ++--
 pc-bios/linuxboot_dma.bin           | Bin 1536 -> 1536 bytes
 pc-bios/optionrom/Makefile          |   1 +
 qapi/block-core.json                |  39 ++++-
 qapi/qmp-event.c                    |   2 +-
 qemu-img.c                          |  75 +++++-----
 qemu-io-cmds.c                      |   5 +-
 qemu-io.c                           |   2 +-
 qemu-nbd.c                          |   8 +-
 qga/commands-win32.c                |   2 +-
 qobject/qdict.c                     |   2 +-
 qom/object_interfaces.c             |   9 ++
 scripts/coccinelle/qobject.cocci    |  35 +++++
 target/ppc/kvm.c                    |   5 +-
 target/ppc/kvm_ppc.h                |   4 +-
 target/s390x/cpu_models.c           |   4 +-
 target/xtensa/gdbstub.c             |  13 +-
 target/xtensa/xtensa-semi.c         |  27 +++-
 tests/check-qdict.c                 | 142 +++++++++---------
 tests/check-qlist.c                 |   4 +-
 tests/check-qom-proplist.c          |  56 +++++++
 tests/device-introspect-test.c      |   4 +-
 tests/qemu-iotests/040              |  63 +++++++-
 tests/qemu-iotests/040.out          |   4 +-
 tests/qemu-iotests/041              |  38 ++++-
 tests/qemu-iotests/041.out          |   4 +-
 tests/qemu-iotests/051              |   1 +
 tests/qemu-iotests/051.out          |   3 +
 tests/qemu-iotests/051.pc.out       |   3 +
 tests/qemu-iotests/122.out          |   4 +-
 tests/qemu-iotests/177              | 117 +++++++++++++++
 tests/qemu-iotests/177.out          |  51 +++++++
 tests/qemu-iotests/group            |   1 +
 tests/test-qemu-opts.c              |   4 +-
 tests/test-qmp-commands.c           |  30 ++--
 tests/test-qmp-event.c              |  30 ++--
 tests/test-qobject-output-visitor.c |   6 +-
 tests/test-x86-cpuid-compat.c       |  38 +++++
 ui/input.c                          |  15 +-
 util/qemu-option.c                  |   2 +-
 109 files changed, 1507 insertions(+), 678 deletions(-)
 create mode 100644 scripts/coccinelle/qobject.cocci
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out
