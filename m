Received: from eggs.gnu.org ([2001:4830:134:3::10]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dzVGF-0002We-MS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dzVGC-0001dJ-If
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dzVGC-0001a0-B2
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:01:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v93LxW4J140604
	for <qemu-devel@nongnu.org>; Tue, 3 Oct 2017 18:01:48 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dch8y56j6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 18:01:48 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Oct 2017 18:01:46 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 03 Oct 2017 17:01:40 -0500
Message-Id: <150706810032.867.12730264004941338092@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.1 Stable released
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

I am pleased to announce that the QEMU v2.10.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v2.10.1 is now tagged in the official qemu.git repository,
and the stable-2.10 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.10

This update contains security fixes addressing guest-induced crashing
of host QEMU process (CVE-2017-13672, CVE-2017-13673) and possible
code injection into host QEMU process via a crafted multiboot ELF
kernel when specified directly via QEMU command-line option
(CVE-2017-14167).

There are also the normal range of general fixes. Please see the
changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

7851197b81: Update version for 2.10.1 release (Michael Roth)
547435f550: migration: disable auto-converge during bulk block migration (P=
eter Lieven)
17cd46fbdf: s390x/cpumodel: remove ais from z14 default model-> also for 2.=
10.1 (Christian Borntraeger)
6a903482b1: Revert "ACPI: don't call acpi_pcihp_device_plug_cb on xen" (Ant=
hony PERARD)
8edf4c6adc: hw/acpi: Move acpi_set_pci_info to pcihp (Anthony PERARD)
2c3a8cc581: hw/acpi: Limit hotplug to root bus on legacy mode (Anthony PERA=
RD)
0691b70a2a: nbd-client: avoid read_reply_co entry if send failed (Stefan Ha=
jnoczi)
4d824886c8: accel/tcg/cputlb: avoid recursive BQL (fixes #1706296) (Alex Be=
nn=C3=A9e)
780fb4ce48: block/qcow2-bitmap: fix use of uninitialized pointer (Vladimir =
Sementsov-Ogievskiy)
7496699ba6: block/throttle-groups.c: allocate RestartData on the heap (Mano=
s Pitsidianakis)
33a599667a: osdep: Fix ROUND_UP(64-bit, 32-bit) (Eric Blake)
a432f419ab: s390x/ais: for 2.10 stable: disable ais facility (Christian Bor=
ntraeger)
a83858fdb5: 9pfs: check the size of transport buffer before marshaling (Jan=
 Dakinevich)
d13a0bde83: 9pfs: fix name_to_path assertion in v9fs_complete_rename() (Jan=
 Dakinevich)
e90997dc8f: 9pfs: fix readdir() for 9p2000.u (Jan Dakinevich)
7e1288cd0c: console: fix dpy_gfx_replace_surface assert (Gerd Hoffmann)
83b23fe55c: ide: ahci: unparent children buses before freeing their memory =
(Igor Mammedov)
e96002e0d1: hw/ide/microdrive: Mark the dscm1xxxx device with user_creatabl=
e =3D false (Thomas Huth)
cc7dd3ad3f: hw/arm/aspeed_soc: Mark devices as user_creatable =3D false (Th=
omas Huth)
de4ad17a8e: hw/arm/digic: Mark device with user_creatable =3D false (Thomas=
 Huth)
8a9d7f3063: s390x/ipl: The s390-ipl device is not hot-pluggable (Thomas Hut=
h)
d3f05848fc: watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable=
 (Thomas Huth)
fca5f37fe9: multiboot: validate multiboot header address values (Prasad J P=
andit)
2965be1f00: vga: stop passing pointers to vga_draw_line* functions (Gerd Ho=
ffmann)
d6f7f3b0cf: vga: fix display update region calculation (split screen) (Gerd=
 Hoffmann)
2a2eab6660: vhost-user-bridge: fix resume regression (since 2.9) (Marc-Andr=
=C3=A9 Lureau)
48f65ce837: libvhost-user: support resuming vq->last_avail_idx based on use=
d_idx (Marc-Andr=C3=A9 Lureau)
b95fbe6f12: scsi-bus: correct responses for INQUIRY and REQUEST SENSE (Hann=
es Reinecke)
b8cd978919: mps2-an511: Fix wiring of UART overflow interrupt lines (Peter =
Maydell)
b24304ca13: vhost: Release memory references on cleanup (Alex Williamson)
c6841b112e: qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache=
 flushing (Pavel Butsykin)
65a24b5c44: hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_c=
reatable =3D false (Thomas Huth)
85cdc23e75: arm_gicv3_kvm: Fix compile warning (Pranith Kumar)
168ff32c5d: virtfs: error out gracefully when mandatory suboptions are miss=
ing (Greg Kurz)
728bfa3273: target/arm: Fix aa64 ldp register writeback (Richard Henderson)
e1b4750f06: s390-ccw: Fix alignment for CCW1 (Farhan Ali)
53d421dd9c: slirp: fix clearing ifq_so from pending packets (Samuel Thibaul=
t)
