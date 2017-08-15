Received: from eggs.gnu.org ([2001:4830:134:3::10]:51312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dhj10-0003Jt-1q
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 17:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dhj0w-00024p-S3
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 17:04:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dhj0w-00023w-My
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 17:04:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7FL3kXu135265
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 17:04:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cc6f6nes7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 17:04:36 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 15 Aug 2017 15:04:36 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 15 Aug 2017 16:04:21 -0500
Message-Id: <150283106173.12142.14640827565327335906@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc3 is now available
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
fourth release candidate for the QEMU 2.10 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-2.10.0-rc3.tar.xz.sig

A note from the maintainer:

  We don't currently know of any outstanding release critical bugs,
  so unless any last minute showstoppers appear next week, we hope
  to be able to release 2.10.0 on schedule on the 22nd. If any
  further release critical bugs are fixed we'll release an rc4 on
  the 22nd and the final release a week after that.

You can help improve the quality of the QEMU 2.10 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.10

Please add entries to the ChangeLog for the 2.10 release below:

  http://wiki.qemu.org/ChangeLog/2.10

Changes since rc2:

1f29673: Update version for v2.10.0-rc3 release (Peter Maydell)
72b384f: mmio-interface: Mark as not user creatable (Peter Maydell)
4a2fdb7: target/arm: Require alignment for load exclusive (Alistair Francis)
19514cd: target/arm: Correct load exclusive pair atomicity (Richard Henders=
on)
955fd0a: target/arm: Correct exclusive store cmpxchg memop mask (Alistair F=
rancis)
72b6ffc: nbd-client: Fix regression when server sends garbage (Eric Blake)
dd7fdaa: iotests: Add non-shared storage migration case 192 (Fam Zheng)
5f7772c: block-backend: Defer shared_perm tightening migration completion (=
Fam Zheng)
3dff24f: nbd: Fix order of bdrv_set_perm and bdrv_invalidate_cache (Kevin W=
olf)
80adf54: stubs: Add vm state change handler stubs (Fam Zheng)
cbaddb2: qemu-iotests: step clock after each test iteration (Stefan Hajnocz=
i)
dad3946: nbd: Fix trace message for disconnect (Eric Blake)
47025a0: qxl: call qemu_spice_display_init_common for secondary devices (Pa=
olo Bonzini)
840d835: simpletrace: fix flight recorder --no-header option (Stefan Hajnoc=
zi)
d6b76d6: trace: use static event ID mapping in simpletrace.stp (Stefan Hajn=
oczi)
a8132a2: docker: add centos7 image (Philippe Mathieu-Daud=C3=A9)
06f3c7b: docker: install more packages on CentOS to extend code coverage (P=
hilippe Mathieu-Daud=C3=A9)
18a2b7a: docker: add Xen libs to centos6 image (Philippe Mathieu-Daud=C3=A9)
6aef2ad: docker: use one package per line in CentOS config (Philippe Mathie=
u-Daud=C3=A9)
e45eaef: Makefile: Let "make check-help" work without running ./configure (=
Fam Zheng)
88b3739: pc-bios/s390-ccw: Use rm command during make clean (Eric Farman)
83c3a1f: xlnx-qspi: add a property for mmio-execution (KONRAD Frederic)
bd7adc8: qemu-doc: Mention host_net_add/-remove in the deprecation chapter =
(Thomas Huth)
a808c08: hw/misc/mmio_interface: Return after error_setg() to avoid crash (=
Thomas Huth)
a3e08c2: qemu-iotests: remove comment about root privileges requirement (Cl=
eber Rosa)
80758ec: qemu-iotests: remove commented out variables (Cleber Rosa)
657c572: qemu-iotests: get rid of _full_imgproto_details() (Cleber Rosa)
88552b5: qemu-doc: Fix "-net van" typo (Thomas Huth)
e8ec011: libqtest: Fix typo in comments (Eric Blake)
0ac241b: unicore32: abort when entering "x 0" on the monitor (Eduardo Otubo)
6900191: qemu-doc: Fix "-net van" typo (Thomas Huth)
480bc11: boot-serial-test: fallback to kvm accelerator (Cornelia Huck)
8565c3a: qemu-iotests: fix 185 (Vladimir Sementsov-Ogievskiy)
2b218f5: file-posix: Do runtime check for ofd lock API (Fam Zheng)
ca74995: osdep: Add runtime OFD lock detection (Fam Zheng)
d0d5d0e: qcow2: Check failure of bdrv_getlength() (Eric Blake)
c40fe9c: qcow2: Drop debugging dump_refcounts() (Eric Blake)
81caa3c: vpc: Check failure of bdrv_getlength() (Eric Blake)
01a02ec: tests/multiboot: Fix whitespace failure (Eric Blake)
17d0bc0: virtio-blk: handle blk_getlength() errors (Stefan Hajnoczi)
ce317e8: IDE: test flush on empty CDROM (Kevin Wolf)
4da9712: IDE: Do not flush empty CDROM drives (Stefan Hajnoczi)
4751fd5: 9pfs: local: fix fchmodat_nofollow() limitations (Greg Kurz)
f57467e: spapr: Fix bug in h_signal_sys_reset() (Sam Bobroff)
325837c: spapr_drc: abort if object_property_add_child() fails (Greg Kurz)
b8af5b2: target/ppc: Add stub implementation of the PSSCR (David Gibson)
650f328: target/ppc: Implement TIDR (David Gibson)
e7bab9a: ppc: fix double-free in cpu_post_load() (Greg Kurz)
89fca22: booke206: fix MAS update on tlb miss (KONRAD Frederic)
24dd1e1: libqtest: always set up signal handler for SIGABRT (Jens Freimann)
2566378: libvhost-user: quit when no more data received (Jens Freimann)
0f8c289: net: fix -netdev socket,fd=3D for UDP sockets (Jens Freimann)
cde0a63: Revert "cpu: add APIs to allocate/free CPU environment" (Michael S=
. Tsirkin)
114e0af: acpi-test: update expected DSDT files (Michael S. Tsirkin)
