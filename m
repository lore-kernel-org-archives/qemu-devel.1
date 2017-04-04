Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvVrD-000415-50
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvVr9-0000PP-3h
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:19:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cvVr8-0000NM-Pi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 17:19:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34LIlEh146509
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 17:19:12 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29m51nc4sq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 17:19:12 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 17:19:11 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 16:18:20 -0500
Message-Id: <149134070075.27082.5005971312741202532@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc3.tar.xz.sig

A note from the maintainer:

  We anticipate there being an rc4 release next week but that
  should be the last rc before the 2.9.0 release, so we'll only
  be taking fixes for critical bugs between now and then.

You can help improve the quality of the QEMU 2.9 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.9

The dates have all been pushed back a week due to delays with the
initial RC.

Please add entries to the ChangeLog for the 2.9 release below:

  http://wiki.qemu.org/ChangeLog/2.9

Changes since rc2:

1fde6ee: Update version for v2.9.0-rc3 release (Peter Maydell)
6d54af0: 9pfs: clear migration blocker at session reset (Greg Kurz)
18adde8: 9pfs: fix multiple flush for same request (Greg Kurz)
193982c: pci: Only unmap bus_master_enabled_region if was added previously =
(Alexey Kardashevskiy)
b8a6872: io: fix FD socket handling in DNS lookup (Daniel P. Berrange)
0e5d632: io: fix incoming client socket initialization (Wang guang)
d9123d0: tests/libqtest.c: Delete possible stale unix sockets (Peter Maydel=
l)
ecbddbb: main-loop: Acquire main_context lock around os_host_main_loop_wait=
. (Richard W.M. Jones)
86d1bd7: block/parallels: Avoid overflows (Max Reitz)
f82c5b1: iotests: Improve image-clear tests on non-aligned image (Eric Blak=
e)
0c1bd46: qcow2: Discard unaligned tail when wiping image (Eric Blake)
07ff948: iotests: fix 097 when run with qcow (Daniel P. Berrange)
6aabeb5: qemu-io-cmds: Assert that global and nofile commands don't use ct-=
>perms (Peter Maydell)
d1c1368: sheepdog: Fix blockdev-add (Markus Armbruster)
9445673: nbd: Tidy up blockdev-add interface (Markus Armbruster)
216411b: sockets: New helper socket_address_crumple() (Markus Armbruster)
8bc0673: qapi-schema: SocketAddressFlat variants 'vsock' and 'fd' (Markus A=
rmbruster)
fce5d53: gluster: Prepare for SocketAddressFlat extension (Markus Armbruste=
r)
129c7d1: block: Document -drive problematic code and bugs (Markus Armbruste=
r)
a6c7628: io vnc sockets: Clean up SocketAddressKind switches (Markus Armbru=
ster)
d2e49aa: char: Fix socket with "type": "vsock" address (Markus Armbruster)
ca0b64e: nbd sockets vnc: Mark problematic address family tests TODO (Marku=
s Armbruster)
9588c58: block: add missed aio_context_acquire into release_drive (Denis V.=
 Lunev)
102a3d8: usb-host: switch to LIBUSB_API_VERSION (Gerd Hoffmann)
230f4c6: disas/cris.c: Avoid unintentional sign extension (Peter Maydell)
6499fd1: configure: Mark SPARC as supported (Peter Maydell)
5c32be5: tcg/sparc: Zero extend address argument to ld/st helpers (Peter Ma=
ydell)
709a340: tcg/sparc: Zero extend data argument to store helpers (Peter Mayde=
ll)
90c4fe5: exec: revert MemoryRegionCache (Paolo Bonzini)
fa03cb7: vnc: allow to connect with add_client when -vnc none (Marc-Andr=C3=
=A9 Lureau)
1684907: Fix input-linux reading from device (Javier Celaya)
243afe8: xhci: flush dequeue pointer to endpoint context (Gerd Hoffmann)
8149e29: pseries: Enforce homogeneous threads-per-core (David Gibson)
cc1e139: nbd: fix memory leak on socket_connect failed (yaolujing)
cb9a05a: ipmi: Fix macro issues (Corey Minyard)
c7f15bc: target-i386: fix "info lapic" segfault on isapc (Tejaswini Poluri)
b9afaba: iscsi: drop unused IscsiAIOCB.qiov field (Stefan Hajnoczi)
34634ca: block/curl: Check protocol prefix (Max Reitz)
6b9d62d: qapi/curl: Extend and fix blockdev-add schema (Max Reitz)
e98c696: rbd: Fix regression in legacy key/values containing escaped : (Eri=
c Blake)
93587e3: Revert "vfio/pci-quirks.c: Disable stolen memory for igd VFIO" (Xi=
ong Zhang)
e7d5441: hw/intc/arm_gicv3_kvm: Check KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS in r=
eset (Eric Auger)
fd5d23b: hmp: fix "dump-quest-memory" segfault (Iwona Kotlarska)
4eaf720: qga: Make qemu-ga compile statically for Windows (Sameeh Jubran)
b4053c6: e1000: disable debug by default (Jason Wang)
1074b87: virtio-net: avoid call tap_enable when there's only one queue (Jas=
on Wang)
8251a72: qga: don't fail if mount doesn't have slave devices (Michael Roth)
0d87608: tests/acpi: don't pack a structure (Michael S. Tsirkin)
375f74f: vhost: generalize iommu memory region (Jason Wang)
fb59dab: configure: Don't claim 'unsupported host OS' when better message a=
vailable (Peter Maydell)
fe6824d: spapr: fix memory hot-unplugging (Laurent Vivier)
24ec286: spapr: fix buffer-overflow (Marc-Andr=C3=A9 Lureau)
b8adbc6: virtio: fix vring_align() on 64-bit windows (Andrew Baumann)
c53598e: pci: Add missing drop of bus master AS reference (Alexey Kardashev=
skiy)
aa26292: event_notifier: prevent accidental use after close (Halil Pasic)
a2f80fd: slirp: Send RDNSS in RA only if host has an IPv6 DNS server (Samue=
l Thibault)
e42f869: slirp: Make RA build more flexible (Samuel Thibault)
51149a2: slirp: fix compilation errors with DEBUG set (Laurent Vivier)
d4a606b: i386: Don't override -cpu options on -cpu host/max (Eduardo Habkos=
t)
a7b0ffa: i386: Replace uint32_t* with FeatureWord on feature getter/setter =
(Eduardo Habkost)
