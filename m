Received: from eggs.gnu.org ([2001:4830:134:3::10]:42023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBZ-0001oX-Uv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBW-000120-Ll
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57349
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBW-00011Z-FR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hg92007229
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:09 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm611gb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:09 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:08 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/67] Patch Round-up for stable 2.7.1,
 freeze on 2016-12-20
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

The following new patches are queued for QEMU stable v2.7.1:

  https://github.com/mdroth/qemu/commits/stable-2.7-staging

The release is planned for 2016-12-23:

  http://wiki.qemu.org/Planning/2.7

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Testing/feedback is greatly appreciated.

Thanks!

----------------------------------------------------------------
Adrian Bunk (1):
      rules.mak: Use -r instead of -Wl, -r to fix building when PIE is de=
fault

Alberto Garcia (2):
      throttle: Correct access to wrong BlockBackendPublic structures
      qemu-iotests: Test I/O in a single drive from a throttling group

Alex Williamson (2):
      memory: Replace skip_dump flag with "ram_device"
      memory: Don't use memcpy for ram_device regions

Corey Minyard (1):
      acpi/ipmi: Initialize the fwinfo before fetching it

Cornelia Huck (2):
      linux-headers: update
      s390x/css: handle cssid 255 correctly

Daniel P. Berrange (4):
      crypto: ensure XTS is only used with ciphers with 16 byte blocks
      qcow2: fix encryption during cow of sectors
      char: fix missing return in error path for chardev TLS init
      net: fix sending of data with -net socket, listen backend

David Gibson (2):
      vfio/pci: Fix regression in MSI routing configuration
      target-ppc: Fix CPU migration from qemu-2.6 <-> later versions

Eduardo Habkost (2):
      vhost-user-test: Use libqos instead of pxe-virtio.rom
      vl: Delay initialization of memory backends

Emilio G. Cota (2):
      qht: simplify qht_reset_size
      qht: fix unlock-after-free segfault upon resizing

Eric Blake (6):
      iscsi: Fix divide-by-zero regression on raw SG devices
      migrate: Fix cpu-throttle-increment regression in HMP
      qcow2: Inform block layer about discard boundaries
      block: Let write zeroes fallback work even with small max_transfer
      block: Return -ENOTSUP rather than assert on unaligned discards
      block: Pass unaligned discard requests to drivers

Fam Zheng (3):
      iothread: Stop threads before main() quits
      scsi-disk: Cleaning up around tray open state
      virtio-scsi: Don't abort when media is ejected

Gonglei (1):
      vnc: fix qemu crash because of SIGSEGV

Greg Kurz (3):
      9pfs: fix potential segfault during walk
      vhost: adapt vhost_verify_ring_mappings() to virtio 1 ring layout
      vhost: drop legacy vring layout bits

John Snow (4):
      ahci: clear aiocb in ncq_cb
      block: reintroduce bdrv_flush_all
      qemu: use bdrv_flush_all for vm_stop et al
      block-backend: remove blk_flush_all

Kevin Wolf (1):
      block: Don't mark node clean after failed flush

Ladi Prosek (1):
      virtio-balloon: discard virtqueue element on reset

Li Qiang (1):
      scsi: mptsas: use g_new0 to allocate MPTSASRequest object

Lin Ma (2):
      qemu-char: avoid segfault if user lacks of permisson of a given log=
file
      msmouse: Fix segfault caused by free the chr before chardev cleanup.

Marc-Andr=C3=A9 Lureau (2):
      qmp: fix object-add assert() without props
      qapi: Fix crash when 'any' or 'null' parameter is missing

Markus Armbruster (1):
      tests/test-qmp-input-strict: Cover missing struct members

Max Reitz (4):
      block/curl: Use BDRV_SECTOR_SIZE
      block/curl: Fix return value from curl_read_cb
      block/curl: Remember all sockets
      block/curl: Do not wait for data beyond EOF

Michael Roth (1):
      Merge tag 'ppc-for-2.7-20161013' into stable-2.7-staging

Michael S. Tsirkin (2):
      virtio: allow per-device-class legacy features
      virtio-net: mark VIRTIO_NET_F_GSO as legacy

Paolo Bonzini (3):
      scsi: mptconfig: fix misuse of MPTSAS_CONFIG_PACK
      rbd: shift byte count as a 64-bit value
      Revert "megasas: remove useless check for cmd->frame"

Peter Xu (2):
      pci-assign: sync MSI/MSI-X cap and table with PCIDevice
      intel_iommu: fix incorrect device invalidate

Prasad J Pandit (4):
      scsi: pvscsi: limit process IO loop to ring size
      vmw_pvscsi: check page count while initialising descriptor rings
      scsi: mptconfig: fix an assert expression
      net: rtl8139: limit processing of ring descriptors

Rony Weng (1):
      scsi-disk: change disk serial length from 20 to 36

Samuel Thibault (1):
      slirp: Fix access to freed memory

Stefan Hajnoczi (1):
      virtio: zero vq->inuse in virtio_reset()

Thomas Huth (4):
      hw/ppc/spapr: Move code related to "ibm,pa-features" to a separate =
function
      hw/ppc/spapr: Fix the selection of the processor features
      ppc: Check the availability of transactional memory
      ppc/kvm: Mark 64kB page size support as disabled if not available

Thorsten Kohfeldt (1):
      vfio/pci: Fix vfio_rtl8168_quirk_data_read address offset

Zhuang Yanying (1):
      ivshmem: Fix 64 bit memory bar configuration

 backends/msmouse.c                                 |  4 +-
 block/block-backend.c                              | 22 -----
 block/curl.c                                       | 99 ++++++++++++++++=
------
 block/io.c                                         | 87 ++++++++++++++--=
---
 block/iscsi.c                                      | 17 ++--
 block/qcow2-cluster.c                              |  2 +-
 block/qcow2.c                                      |  6 ++
 block/rbd.c                                        |  4 +-
 block/sheepdog.c                                   |  5 +-
 block/throttle-groups.c                            | 27 +++++-
 cpus.c                                             |  4 +-
 crypto/cipher-gcrypt.c                             |  6 ++
 crypto/cipher-nettle.c                             | 12 +--
 hmp.c                                              |  1 +
 hw/9pfs/9p.c                                       |  5 +-
 hw/acpi/ipmi.c                                     |  1 +
 hw/i386/intel_iommu.c                              |  1 +
 hw/i386/kvm/pci-assign.c                           |  4 +
 hw/i386/xen/xen_platform.c                         |  2 -
 hw/ide/ahci.c                                      |  1 +
 hw/ide/piix.c                                      |  4 +
 hw/misc/ivshmem.c                                  |  4 +-
 hw/net/rtl8139.c                                   |  2 +-
 hw/net/virtio-net.c                                |  1 +
 hw/ppc/spapr.c                                     | 76 ++++++++++------=
-
 hw/s390x/css.c                                     |  8 +-
 hw/s390x/virtio-ccw.c                              |  4 +-
 hw/scsi/megasas.c                                  |  6 +-
 hw/scsi/mptconfig.c                                |  6 +-
 hw/scsi/mptsas.c                                   |  2 +-
 hw/scsi/scsi-disk.c                                | 26 +++---
 hw/scsi/virtio-scsi.c                              | 15 ++--
 hw/scsi/vmw_pvscsi.c                               | 24 +++---
 hw/vfio/common.c                                   |  9 +-
 hw/vfio/pci-quirks.c                               |  2 +-
 hw/vfio/pci.c                                      |  4 +-
 hw/vfio/spapr.c                                    |  2 +-
 hw/virtio/vhost.c                                  | 92 +++++++++++++---=
----
 hw/virtio/virtio-balloon.c                         |  1 +
 hw/virtio/virtio-pci.c                             |  4 +-
 hw/virtio/virtio.c                                 |  4 +
 include/block/block.h                              |  1 +
 include/exec/memory.h                              | 47 ++++++----
 include/hw/s390x/css.h                             |  2 +-
 include/hw/virtio/vhost.h                          |  7 +-
 include/hw/virtio/virtio.h                         |  5 ++
 include/standard-headers/linux/input-event-codes.h | 32 +++++++
 include/standard-headers/linux/input.h             |  1 +
 include/standard-headers/linux/virtio_config.h     | 10 ++-
 include/standard-headers/linux/virtio_ids.h        |  1 +
 include/standard-headers/linux/virtio_net.h        |  3 +
 include/standard-headers/linux/virtio_vsock.h      | 94 ++++++++++++++++=
++++
 include/sysemu/block-backend.h                     |  1 -
 include/sysemu/iothread.h                          |  1 +
 iothread.c                                         | 24 +++++-
 linux-headers/asm-arm/kvm.h                        |  4 +-
 linux-headers/asm-arm64/kvm.h                      |  2 +
 linux-headers/asm-s390/kvm.h                       | 41 +++++++++
 linux-headers/asm-x86/unistd_x32.h                 |  4 +-
 linux-headers/linux/kvm.h                          | 18 +++-
 linux-headers/linux/vhost.h                        | 33 ++++++++
 memory.c                                           | 80 ++++++++++++++++=
-
 memory_mapping.c                                   |  2 +-
 net/net.c                                          |  5 +-
 net/socket.c                                       |  1 +
 qapi/qmp-input-visitor.c                           | 11 +++
 qemu-char.c                                        |  7 ++
 qmp.c                                              |  8 +-
 rules.mak                                          |  2 +-
 slirp/socket.c                                     | 17 ++++
 target-ppc/cpu.h                                   |  6 ++
 target-ppc/kvm.c                                   | 14 +++
 target-ppc/kvm_ppc.h                               |  6 ++
 target-ppc/machine.c                               | 29 ++++++-
 tests/Makefile.include                             |  2 +-
 tests/qemu-iotests/026.out                         | 22 +++++
 tests/qemu-iotests/026.out.nocache                 | 22 +++++
 tests/qemu-iotests/071.out                         |  2 +
 tests/qemu-iotests/093                             | 33 ++++++--
 tests/qemu-iotests/093.out                         |  4 +-
 tests/qemu-iotests/158                             | 80 ++++++++++++++++=
+
 tests/qemu-iotests/158.out                         | 36 ++++++++
 tests/qemu-iotests/group                           |  1 +
 tests/test-crypto-cipher.c                         | 43 ++++++++--
 tests/test-qmp-input-strict.c                      | 46 ++++++++++
 tests/vhost-user-test.c                            | 37 +++++++-
 trace-events                                       |  2 +
 ui/vnc.c                                           |  4 +
 util/qht.c                                         | 55 ++++++------
 vl.c                                               | 15 ++++
 90 files changed, 1230 insertions(+), 299 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_vsock.h
 create mode 100755 tests/qemu-iotests/158
 create mode 100644 tests/qemu-iotests/158.out
