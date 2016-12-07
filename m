Received: from eggs.gnu.org ([2001:4830:134:3::10]:50950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEcsx-0000he-Ci
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEcss-0006ov-CR
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:07:51 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:59982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cEcss-0006oi-2T
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:07:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7E6pdn108920
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 09:07:44 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276gjg43dd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 09:07:43 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 07:07:43 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 07 Dec 2016 08:07:33 -0600
Message-Id: <20161207140733.3613.57602@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 2.8 release.  This release is meant
for testing purposes and should not be used in a production environment.

http://wiki.qemu.org/download/qemu-2.8.0-rc3.tar.bz2

Barring the discovery of any major issues, this is the last planned RC
before the release of QEMU 2.8, so your testing is greatly appreciated.

You can help improve the quality of the QEMU 2.8 release by testing this
release and reporting bugs on Launchpad or directly to the mailing list:

https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

http://wiki.qemu.org/Planning/2.8

Please add entries to the ChangeLog for the 2.8 release below:

http://wiki.qemu.org/ChangeLog/2.8

Changes since rc1:

1cd56fd: Update version for v2.8.0-rc2 release (Stefan Hajnoczi)
7ecf44a: rules.mak: Also try -r to build modules (Paolo Bonzini)
6725f88: hbitmap: Fix shifts of constants by granularity (Max Reitz)
c79ed23: configure: fix LTTng UST tracing backend detection (Francis Deslau=
riers)
e514379: xen: ignore direction in bufioreq handling (Jan Beulich)
f37f29d: xen: slightly simplify bufioreq handling (Jan Beulich)
ff3b8b8: xen: fix quad word bufioreq handling (Jan Beulich)
c96f0ee: rules.mak: Use -r instead of -Wl, -r to fix building when PIE is d=
efault (Adrian Bunk)
f9f885b: migration/pcspk: Turn migration of pcspk off for 2.7 and older (Dr=
. David Alan Gilbert)
04e27c6: migration/pcspk: Add a property to state if pcspk is migrated (Dr.=
 David Alan Gilbert)
64e184e: pci-assign: sync MSI/MSI-X cap and table with PCIDevice (Peter Xu)
9e55d58: megasas: clean up and fix request completion/cancellation (Paolo B=
onzini)
75f19f8: megasas: do not call pci_dma_unmap after having freed the frame on=
ce (Paolo Bonzini)
b77257d: arm: Create /chosen and /memory devicetree nodes if necessary (Gue=
nter Roeck)
6aa3a61: generic-loader: file: Only set a PC if a CPU is specified (Alistai=
r Francis)
685479b: target-i386: Remove unused local_err variable (Eduardo Habkost)
8f57758: docs: Specify that cache-clean-interval is only supported in Linux=
 (Alberto Garcia)
a8b99dd: qcow2: Remove stale comment (Alberto Garcia)
91203f0: qcow2: Allow 'cache-clean-interval' in Linux only (Alberto Garcia)
2f2c8d6: qcow2: Make qcow2_cache_table_release() work only in Linux (Albert=
o Garcia)
06c3375: Update OpenBIOS images to ef8a14e built from submodule. (Mark Cave=
-Ayland)
4a18cd4: target-m68k: fix muluw/mulsw (Laurent Vivier)
5436c29: target-m68k: Fix cmpa operand size (Laurent Vivier)
c090c97: target-m68k: fix EXG instruction (Laurent Vivier)
7875efb: xen_disk: split discard input to match internal representation (Ol=
af Hering)
898ae90: 9pfs: add cleanup operation for proxy backend driver (Li Qiang)
971f406: 9pfs: add cleanup operation for handle backend driver (Li Qiang)
702dbcc: 9pfs: add cleanup operation in FileOperations (Li Qiang)
4774718: 9pfs: adjust the order of resource cleanup in device unrealize (Li=
 Qiang)
5c4537b: spapr: Fix 2.7<->2.8 migration of PCI host bridge (David Gibson)
5a78b82: Revert "spapr: Fix migration of PCI host bridges from qemu-2.7" (D=
avid Gibson)
146c11f: target-ppc: Allow eventual removal of old migration mistakes (Davi=
d Gibson)
3fed86e: migration: Add VMSTATE_UINTTL_TEST() (David Gibson)
16a2497: target-ppc: Fix CPU migration from qemu-2.6 <-> later versions (Da=
vid Gibson)
39d97e1: ppc: Make uninorth interrupt swizzling identical to Grackle (Benja=
min Herrenschmidt)
a813fe7: target-ppc: fix index array of national digits (Jose Ricardo Zivia=
ni)
8a273cb: hw/char/spapr_vty: Return amount of free buffer entries in vty_can=
_receive() (Thomas Huth)
0d28aa1: ppc: BOOK3E: nothing should be done when MSR:PR is set (Vladimir S=
voboda)
62ef376: spapr: migration support for CAS-negotiated option vectors (Michae=
l Roth)
171da9d: tests/postcopy: Use KVM on ppc64 only if it is KVM-HV (Thomas Huth)
1d895fe: scsi/esp: do not raise an interrupt when reading the FIFO register=
 (Herv=C3=A9 Poussineau)
169407e: nbd: Allow unmap and fua during write zeroes (Eric Blake)
c2a8531: cpu_ldst.h: use correct guest address parameter (Bobby Bingham)
424ad83: target-alpha: Fix interrupt mask for cpu1 (Richard Henderson)
