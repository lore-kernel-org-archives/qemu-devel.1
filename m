Received: from eggs.gnu.org ([2001:4830:134:3::10]:39843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fi5UH-0003Jg-GF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fi5UE-0003U6-7Y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fi5UE-0003T6-0G
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:08:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6OM8aOZ132264
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 18:08:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kea81mu7s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 18:08:52 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 24 Jul 2018 18:08:51 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 24 Jul 2018 17:08:39 -0500
Message-Id: <153247011984.11309.9687749051366741435@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.0-rc2 is now available
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
third release candidate for the QEMU 3.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.0.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-3.0.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 3.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.0

Please add entries to the ChangeLog for the 3.0 release below:

  http://wiki.qemu.org/ChangeLog/3.0

Thank you to everyone involved!

Changes since rc1:

18a398f6a3: Update version for v3.0.0-rc2 release (Peter Maydell)
db0a8c70f2: tests: fix TLS handshake failure with TLS 1.3 (Daniel P. Berran=
g=C3=A9)
68db13183f: tests: use error_abort in places expecting errors (Daniel P. Be=
rrang=C3=A9)
977a7204ab: tests: don't silence error reporting for all tests (Daniel P. B=
errang=C3=A9)
dbddad7026: tests: call qcrypto_init instead of gnutls_global_init (Daniel =
P. Berrang=C3=A9)
4b3fb65db9: migration: fix duplicate initialization for expected_downtime a=
nd cleanup_bh (Lidong Chen)
829db8b497: tests: only update last_byte when at the edge (Peter Xu)
97ca211c62: migration: disallow recovery for release-ram (Peter Xu)
814bb08f17: migration: update recv bitmap only on dest vm (Peter Xu)
67fa1f5700: audio/hda: Fix migration (Dr. David Alan Gilbert)
57225e5f32: migrate: Fix cancelling state warning (Dr. David Alan Gilbert)
4fcefd44a0: migration: fix potential overflow in multifd send (Peter Xu)
042b757cc7: block/file-posix: add bdrv_attach_aio_context callback for host=
 dev and cdrom (Nishanth Aravamudan)
1a3bdc6111: tests/tcg: remove runcom test (Alex Benn=C3=A9e)
15352decf8: docker: perform basic binfmt_misc validation in docker.py (Alex=
 Benn=C3=A9e)
f7b446b5de: docker: ignore distro versioning of debootstrap (Alex Benn=C3=
=A9e)
11cc24a126: docker: add commentary to debian-bootstrap.docker (Alex Benn=C3=
=A9e)
571fef5e07: docker: Update debootstrap script after Debian migration from A=
lioth to Salsa (Philippe Mathieu-Daud=C3=A9)
d19f5fc041: docker: report hint when docker.py check fails (Alex Benn=C3=A9=
e)
2796346069: docker: drop QEMU_TARGET check, fallback in EXECUTABLE not set =
(Alex Benn=C3=A9e)
ff1a390296: docker: add expansion for docker-test-FOO to Makefile.include (=
Alex Benn=C3=A9e)
d984f24c77: docker: add test-unit runner (Alex Benn=C3=A9e)
77b08f73c8: docker: Makefile.include don't include partial images (Alex Ben=
n=C3=A9e)
56c115a953: docker: gracefully skip check_qemu (Alex Benn=C3=A9e)
3f9747a738: docker: move make check into check_qemu helper (Alex Benn=C3=A9=
e)
e4ce964d94: docker: split configure_qemu from build_qemu (Alex Benn=C3=A9e)
43e1b2ffec: docker: fail more gracefully on docker.py check (Alex Benn=C3=
=A9e)
be5e1f527a: docker: par down QEMU_CONFIGURE_OPTS in debian-tricore-cross (A=
lex Benn=C3=A9e)
e043d73212: docker: base debian-tricore on qemu:debian9 (Alex Benn=C3=A9e)
1818d50179: tests/.gitignore: don't ignore docker tests (Alex Benn=C3=A9e)
1a5182c0d2: target/arm: Escalate to correct HardFault when AIRCR.BFHFNMINS =
is set (Peter Maydell)
042374c92e: hw/intc/arm_gicv3: Check correct HCR_EL2 bit when routing IRQ (=
Peter Maydell)
0c6c439554: ui/cocoa.m: prevent stuck command key when going into full scre=
en mode (John Arbuckle)
ae7da1e5f6: qga: process_event() simplification and leak fix (Marc-Andr=C3=
=A9 Lureau)
c5840b905e: qga-win: Handle fstrim for OSes lower than Win8 (Sameeh Jubran)
672189cd58: tcg/i386: Mark xmm registers call-clobbered (Richard Henderson)
5f00335aec: i386: Rename enum CacheType members (Eduardo Habkost)
3e31b4e170: block/vvfat: Disable debug message by default (Thomas Huth)
092b9c408f: iotests: Disallow compat=3D0.10 in 223 (Max Reitz)
d6e4ca9021: iotest: Fix filtering order in 226 (Max Reitz)
e05eb9f29b: iotests: remove LUKS support from test 226 (John Snow)
6360ab278c: qemu-img: avoid overflow of min_sparse parameter (Peter Lieven)
50d6a8a352: block: Fix typos in comments (found by codespell) (Stefan Weil)
4e04f3d91a: qemu-iotests: Use host_device instead of file in 149 (Kevin Wol=
f)
1ddc9b98c3: hw/intc/exynos4210_gic: Turn instance_init into realize functio=
n (Thomas Huth)
07bc425ea3: hw/arm/spitz: Move problematic nand_init() code to realize func=
tion (Thomas Huth)
9d2b5a58f8: target/arm: Correctly handle overlapping small MPU regions (Pet=
er Maydell)
03a31776e8: hw/sd/bcm2835_sdhost: Fix PIO mode writes (Guenter Roeck)
7b6d7b84da: hw/microblaze/xlnx-zynqmp-pmu: Fix introspection problem in 'xl=
nx, zynqmp-pmu-soc' (Thomas Huth)
62aa1d887f: monitor: Fix unsafe sharing of @cur_mon among threads (Peter Xu)
25b1ef31db: qapi: Make 'allow-oob' optional in SchemaInfoCommand (Markus Ar=
mbruster)
6598f0cdad: po: Don't include comments with location (Stefan Weil)
fa97e38eed: linux-user/ppc: Implement swapcontext syscall (Richard Henderso=
n)
33143c446e: linux-user: fix ELF load alignment error (Laurent Vivier)
323e7c1177: tap: fix memory leak on success to create a tap device (Yunjian=
 Wang)
4712c158c5: e1000e: Prevent MSI/MSI-X storms (Jan Kiszka)
e65a5f227d: tcg/aarch64: limit mul_vec size (Alex Benn=C3=A9e)
8ff62f6aa0: spike: Fix crash when introspecting the device (Alistair Franci=
s)
5657c3f53c: riscv_hart: Fix crash when introspecting the device (Alistair F=
rancis)
a993cb150f: virt: Fix crash when introspecting the device (Alistair Francis)
4eea9d7deb: sifive_u: Fix crash when introspecting the device (Alistair Fra=
ncis)
54f3141a58: sifive_e: Fix crash when introspecting the device (Alistair Fra=
ncis)
db817b8c50: tracing: Use double-dash spelling for trace option (Yaowei Bai)
6fccbb475b: throttle-groups: fix hang when group member leaves (Stefan Hajn=
oczi)
677ff32db1: s390x/cpumodel: fix segmentation fault when baselining models (=
David Hildenbrand)
