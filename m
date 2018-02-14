Received: from eggs.gnu.org ([2001:4830:134:3::10]:45223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1em5ms-0004ZC-CT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1em5mp-0002eY-33
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:44:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1em5mo-0002d3-Qd
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:44:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EMiKDY133738
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 17:44:21 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4wxkrcj1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 17:44:21 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 15:44:20 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 16:44:07 -0600
Message-Id: <151864824792.12702.1556511371459552160@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.1 Stable released
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

I am pleased to announce that the QEMU v2.11.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v2.11.1 is now tagged in the official qemu.git repository,
and the stable-2.11 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.11

This update contains new functionality needed to enable mitigations for
Spectre/Meltdown (CVE-2017-5715) in x86, pseries, and s390x QEMU/KVM
guest operating systems. Documentation for the various options/requirements
for enabling this functionality is available here:

  https://www.qemu.org/2018/02/14/qemu-2-11-1-and-spectre-update/

There are also security fixes for potential host DoS attacks via
VGA devices (CVE-2018-5683) and VNC clients (CVE-2017-15124), as
well as the normal range of general fixes. Please see the changelog
for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

7c1beb52ed: Update version for 2.11.1 release (Michael Roth)
00e9fba2be: spapr: add missing break in h_get_cpu_characteristics() (Greg K=
urz)
63112b16a6: vga: check the validation of memory addr when draw text (linzhe=
cheng)
30c3b4823c: input: fix memory leak (linzhecheng)
88ab85384d: ui: correctly advance output buffer when writing SASL data (Dan=
iel P. Berrang=C3=A9)
64653b7fbe: ui: avoid sign extension using client width/height (Daniel P. B=
errange)
9a26ca6b94: ui: mix misleading comments & return types of VNC I/O helper me=
thods (Daniel P. Berrange)
172f4e5a31: ui: add trace events related to VNC client throttling (Daniel P=
. Berrange)
0c85a40e71: ui: place a hard cap on VNC server output buffer size (Daniel P=
. Berrange)
f9e53c77ea: ui: fix VNC client throttling when forced update is requested (=
Daniel P. Berrange)
f9c8767828: ui: fix VNC client throttling when audio capture is active (Dan=
iel P. Berrange)
5af9f2504f: ui: refactor code for determining if an update should be sent t=
o the client (Daniel P. Berrange)
2e6571e671: ui: correctly reset framebuffer update state after processing d=
irty regions (Daniel P. Berrange)
126617e6f8: ui: introduce enum to track VNC client framebuffer update reque=
st state (Daniel P. Berrange)
8a9c5c34ac: ui: track how much decoded data we consumed when doing SASL enc=
oding (Daniel P. Berrange)
616d64ac06: ui: avoid pointless VNC updates if framebuffer isn't dirty (Dan=
iel P. Berrange)
a7b2537f8a: ui: remove redundant indentation in vnc_client_update (Daniel P=
. Berrange)
de1e7a91c8: ui: remove unreachable code in vnc_update_client (Daniel P. Ber=
range)
0181686a98: ui: remove 'sync' parameter from vnc_update_client (Daniel P. B=
errange)
a3fd64f2fe: migration: incoming postcopy advise sanity checks (Greg Kurz)
68d7e24475: target/sh4: add missing tcg_temp_free() in _decode_opc() (Phili=
ppe Mathieu-Daud=C3=A9)
2095c5a2e3: migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32 (=
Daniel Henrique Barboza)
c8847f5565: migration: Recover block devices if failure in device state (Dr=
. David Alan Gilbert)
b9eec804f4: migration: Don't leak IO channels (Ross Lagerwall)
b8aa511bc0: s390x/sclp: fix event mask handling (Christian Borntraeger)
ab7b4f6734: memory: set ioeventfd_update_pending after address_space_update=
_ioeventfds (linzhecheng)
ed8b4ecc68: target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS (Suraj J=
itindar Singh)
eab4b5170f: target/ppc/spapr_caps: Add new tristate cap safe_indirect_branc=
h (Suraj Jitindar Singh)
d7aa3d0a0a: target/ppc/spapr_caps: Add new tristate cap safe_bounds_check (=
Suraj Jitindar Singh)
3dc12273b7: target/ppc/spapr_caps: Add new tristate cap safe_cache (Suraj J=
itindar Singh)
e9a8747cd2: target/ppc/spapr_caps: Add support for tristate spapr_capabilit=
ies (Suraj Jitindar Singh)
49b1fa33a3: target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_b=
ranch] (Suraj Jitindar Singh)
43a29f0025: target/ppc/spapr_caps: Add macro to generate spapr_caps migrati=
on vmstate (Suraj Jitindar Singh)
d72e0a69ea: target/ppc: introduce the PPC_BIT() macro (C=C3=A9dric Le Goate=
r)
4374cbca95: spapr: fix device tree properties when using compatibility mode=
 (Greg Kurz)
a1f33a5b93: ppc: Change Power9 compat table to support at most 8 threads/co=
re (Jose Ricardo Ziviani)
6a47136799: hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal repr=
esentation (Suraj Jitindar Singh)
e4f4fa00eb: spapr: Handle Decimal Floating Point (DFP) as an optional capab=
ility (David Gibson)
ff6f7e10c6: spapr: Handle VMX/VSX presence as an spapr capability flag (Dav=
id Gibson)
7c578cbc37: target/ppc: Clean up probing of VMX, VSX and DFP availability o=
n KVM (David Gibson)
804e5ea9ed: spapr: Validate capabilities on migration (David Gibson)
9070f408f4: spapr: Treat Hardware Transactional Memory (HTM) as an optional=
 capability (David Gibson)
78a38cd47e: spapr: Capabilities infrastructure (David Gibson)
0fac4aa930: spapr: Add pseries-2.12 machine type (David Gibson)
97d17551b5: spapr: don't initialize PATB entry if max-cpu-compat < power9 (=
Laurent Vivier)
7e25155a7b: linux-user/signal.c: Rename MC_* defines (Peter Maydell)
80277d7cd5: spapr_pci: fix MSI/MSIX selection (Greg Kurz)
50c6998c20: usb-storage: Fix share-rw option parsing (Fam Zheng)
dccdaacc3d: osdep: Retry SETLK upon EINTR (Fam Zheng)
5683983e99: s390x/kvm: provide stfle.81 (Christian Borntraeger)
4d79c0e434: s390x/kvm: Handle bpb feature (Christian Borntraeger)
098132386d: linux-headers: update (Cornelia Huck)
61c8e67a66: linux-headers: update to 4.15-rc1 (Eric Auger)
e7857ad997: s390x: fix storage attributes migration for non-small guests (C=
laudio Imbrenda)
9327a8e2d6: linux-user: Fix locking order in fork_start() (Peter Maydell)
8ebfafa796: i386: Add EPYC-IBPB CPU model (Eduardo Habkost)
61efbbf869: i386: Add new -IBRS versions of Intel CPU models (Eduardo Habko=
st)
1ade973f52: i386: Add FEAT_8000_0008_EBX CPUID feature word (Eduardo Habkos=
t)
803d42fa65: i386: Add spec-ctrl CPUID bit (Eduardo Habkost)
cb2637a5ae: i386: Add support for SPEC_CTRL MSR (Paolo Bonzini)
4b220d88ba: i386: Change X86CPUDefinition::model_id to const char* (Eduardo=
 Habkost)
1027f3419b: hw/pci-bridge: fix QEMU crash because of pcie-root-port (Marcel=
 Apfelbaum)
ccf82aee58: scsi-disk: release AioContext in unaligned WRITE SAME case (Ste=
fan Hajnoczi)
1e14820884: hw/sd/ssi-sd: Reset SD card on controller reset (Peter Maydell)
a22b8096b6: hw/sd/milkymist-memcard: Reset SD card on controller reset (Pet=
er Maydell)
3f44190cb6: hw/sd/pl181: Reset SD card on controller reset (Peter Maydell)
88bf4a70df: vhost: remove assertion to prevent crash (Jay Zhou)
f793121539: virtio_error: don't invoke status callbacks (Michael S. Tsirkin)
0af294d774: hw/intc/arm_gic: reserved register addresses are RAZ/WI (Peter =
Maydell)
62425350b5: hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI (Pet=
er Maydell)
d6f1448277: vfio: Fix vfio-kvm group registration (Alex Williamson)
7f53a81073: block: Open backing image in force share mode for size probe (F=
am Zheng)
2b0c34cf61: block: Call .drain_begin only once in bdrv_drain_all_begin() (K=
evin Wolf)
057364da77: block: Make bdrv_drain_invoke() recursive (Kevin Wolf)
b9da3c1de7: block/nbd: fix segmentation fault when .desc is not null-termin=
ated (Murilo Opsfelder Araujo)
c184e17c75: qemu-pr-helper: miscellaneous fixes (Paolo Bonzini)
5ba945f1cb: qemu-options: Remove stray colons from output of --help (Markus=
 Armbruster)
ea311a9959: target/sh4: fix TCG leak during gusa sequence (Alex Benn=C3=A9e)
fd89d93e85: block/iscsi: dont leave allocmap in an invalid state on UNMAP f=
ailure (Peter Lieven)
817a9fcba8: target/i386: Fix handling of VEX prefixes (Peter Maydell)
