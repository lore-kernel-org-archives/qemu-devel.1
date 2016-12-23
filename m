Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cKTta-0003pa-5Z
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cKTtX-0006vH-17
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:44:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56737
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cKTtW-0006uC-SA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:44:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBNHht6U036720
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 12:44:35 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27h5mxpr6j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 12:44:35 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 23 Dec 2016 10:44:34 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri, 23 Dec 2016 11:44:14 -0600
Message-Id: <20161223174414.26007.53899@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.7.1 Stable released
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

I am pleased to announce that the QEMU v2.7.1 stable release is now
available:

  http://wiki.qemu.org/download/qemu-2.7.1.tar.bz2

v2.7.1 is now tagged in the official qemu.git repository,
and the stable-2.7 branch has been updated accordingly:

  http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.7

This update fixes a number of issues relating to migration for
both x86 and pseries guests, and addresses a broad range of bugs.
Users should upgrade accordingly.

Thank you to everyone involved!

CHANGELOG:

0d83fcc: Update version for 2.7.1 release (Michael Roth)
4dde694: ide: Fix memory leak in ide_register_restart_cb() (Ashijeet Achary=
a)
7d17d68: portio: keep references on portio (Marc-Andr=C3=A9 Lureau)
345f1cd: block-backend: Always notify on blk_eject (John Snow)
8d5f2a7: dma-helpers: explicitly pass alignment into DMA helpers (Mark Cave=
-Ayland)
5f20161: atapi: classify read_cd as conditionally returning data (John Snow)
05838b4: ui/gtk: fix "Copy" menu item segfault (Stefan Hajnoczi)
223d1a2: vfio/pci: Fix vfio_rtl8168_quirk_data_read address offset (Thorste=
n Kohfeldt)
7f7ac21: msmouse: Fix segfault caused by free the chr before chardev cleanu=
p. (Lin Ma)
db1604c: Revert "megasas: remove useless check for cmd->frame" (Paolo Bonzi=
ni)
cc1fd25: vl: Delay initialization of memory backends (Eduardo Habkost)
ee99e42: vhost-user-test: Use libqos instead of pxe-virtio.rom (Eduardo Hab=
kost)
0ef167c: intel_iommu: fix incorrect device invalidate (Peter Xu)
248a780: rules.mak: Use -r instead of -Wl, -r to fix building when PIE is d=
efault (Adrian Bunk)
80f630b: pci-assign: sync MSI/MSI-X cap and table with PCIDevice (Peter Xu)
353801c: ivshmem: Fix 64 bit memory bar configuration (Zhuang Yanying)
c8a3159: vhost: drop legacy vring layout bits (Greg Kurz)
48fdfeb: block/curl: Do not wait for data beyond EOF (Max Reitz)
6eb194d: block/curl: Remember all sockets (Max Reitz)
7e278ef: block/curl: Fix return value from curl_read_cb (Max Reitz)
6a5ea68: block/curl: Use BDRV_SECTOR_SIZE (Max Reitz)
31454eb: block: Pass unaligned discard requests to drivers (Eric Blake)
5e4eb85: block: Return -ENOTSUP rather than assert on unaligned discards (E=
ric Blake)
dd11d33: block: Let write zeroes fallback work even with small max_transfer=
 (Eric Blake)
c4bf37e: qcow2: Inform block layer about discard boundaries (Eric Blake)
e9dbd28: slirp: Fix access to freed memory (Samuel Thibault)
92230a5: vhost: adapt vhost_verify_ring_mappings() to virtio 1 ring layout =
(Greg Kurz)
48b3aa2: block: Don't mark node clean after failed flush (Kevin Wolf)
f1372d6: virtio-net: mark VIRTIO_NET_F_GSO as legacy (Michael S. Tsirkin)
63087cd: virtio: allow per-device-class legacy features (Michael S. Tsirkin)
9df69dc: target-ppc: Fix CPU migration from qemu-2.6 <-> later versions (Da=
vid Gibson)
95a0638: net: fix sending of data with -net socket, listen backend (Daniel =
P. Berrange)
1790a9d: acpi/ipmi: Initialize the fwinfo before fetching it (Corey Minyard)
1b16ded: memory: Don't use memcpy for ram_device regions (Alex Williamson)
ca83f87: memory: Replace skip_dump flag with "ram_device" (Alex Williamson)
2817466: net: rtl8139: limit processing of ring descriptors (Prasad J Pandi=
t)
e389e44: qemu-iotests: Test I/O in a single drive from a throttling group (=
Alberto Garcia)
b1fdc94: throttle: Correct access to wrong BlockBackendPublic structures (A=
lberto Garcia)
6178198: ppc/kvm: Mark 64kB page size support as disabled if not available =
(Thomas Huth)
857efec: rbd: shift byte count as a 64-bit value (Paolo Bonzini)
99837b0: tests/test-qmp-input-strict: Cover missing struct members (Markus =
Armbruster)
b34c7bd: qapi: Fix crash when 'any' or 'null' parameter is missing (Marc-An=
dr=C3=A9 Lureau)
f3467f5: qmp: fix object-add assert() without props (Marc-Andr=C3=A9 Lureau)
5be5335: char: fix missing return in error path for chardev TLS init (Danie=
l P. Berrange)
af29bd3: qht: fix unlock-after-free segfault upon resizing (Emilio G. Cota)
f72ca1a: qht: simplify qht_reset_size (Emilio G. Cota)
4d45fe1: migrate: Fix cpu-throttle-increment regression in HMP (Eric Blake)
4a25ab2: block-backend: remove blk_flush_all (John Snow)
95200eb: qemu: use bdrv_flush_all for vm_stop et al (John Snow)
8e94512: block: reintroduce bdrv_flush_all (John Snow)
d40d148: iscsi: Fix divide-by-zero regression on raw SG devices (Eric Blake)
f985602: qcow2: fix encryption during cow of sectors (Daniel P. Berrange)
a3a2545: vfio/pci: Fix regression in MSI routing configuration (David Gibso=
n)
533dedf: s390x/css: handle cssid 255 correctly (Cornelia Huck)
54c26b7: ahci: clear aiocb in ncq_cb (John Snow)
f5436d1: virtio-scsi: Don't abort when media is ejected (Fam Zheng)
3550eea: scsi-disk: Cleaning up around tray open state (Fam Zheng)
316c2c9: iothread: Stop threads before main() quits (Fam Zheng)
98b4465: crypto: ensure XTS is only used with ciphers with 16 byte blocks (=
Daniel P. Berrange)
8342e12: scsi: mptconfig: fix misuse of MPTSAS_CONFIG_PACK (Paolo Bonzini)
0b6ab25: scsi: mptconfig: fix an assert expression (Prasad J Pandit)
7428865: vmw_pvscsi: check page count while initialising descriptor rings (=
Prasad J Pandit)
2f8e8c7: scsi-disk: change disk serial length from 20 to 36 (Rony Weng)
069e885: qemu-char: avoid segfault if user lacks of permisson of a given lo=
gfile (Lin Ma)
bfb15f7: scsi: pvscsi: limit process IO loop to ring size (Prasad J Pandit)
c6a7b92: scsi: mptsas: use g_new0 to allocate MPTSASRequest object (Li Qian=
g)
d06c61f: 9pfs: fix potential segfault during walk (Greg Kurz)
91a2f46: vnc: fix qemu crash because of SIGSEGV (Gonglei)
520d4b2: virtio-balloon: discard virtqueue element on reset (Ladi Prosek)
4b6542d: virtio: zero vq->inuse in virtio_reset() (Stefan Hajnoczi)
2e68f28: ppc: Check the availability of transactional memory (Thomas Huth)
45a4f18: hw/ppc/spapr: Fix the selection of the processor features (Thomas =
Huth)
5c17966: hw/ppc/spapr: Move code related to "ibm,pa-features" to a separate=
 function (Thomas Huth)
6ff3ab0: linux-headers: update (Cornelia Huck)
