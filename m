Received: from eggs.gnu.org ([2001:4830:134:3::10]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f3rCZ-00024o-G4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f3rCV-000367-Bm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f3rCV-00031R-38
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:48:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w34MkOuZ098400
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 18:48:16 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h56mbtcnv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:48:16 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 16:48:15 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 04 Apr 2018 17:47:04 -0500
Message-Id: <152288202465.13651.16220663033323888791@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc2 is now available
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
third release candidate for the QEMU 2.12 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.12.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-2.12.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 2.12 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.12

Please add entries to the ChangeLog for the 2.12 release below:

  http://wiki.qemu.org/ChangeLog/2.12

Changes since rc1:

0e87fdc966: Update version for v2.12.0-rc2 release (Peter Maydell)
bfb15b4bec: block/rbd: remove processed options from qdict (Jeff Cody)
74912f6dad: tcg: fix 16-byte vector operations detection (Laurent Vivier)
abd3622cc0: iotests: Test abnormally large size in compressed cluster descr=
iptor (Alberto Garcia)
96914159b7: qemu-iotests: Use ppc64 qemu_arch on ppc64le host (Luk=C3=A1=C5=
=A1 Doktor)
733d1dce0f: iotests: Test preallocated truncate of 2G image (Max Reitz)
82b45e0a0b: block/file-posix: Fix fully preallocated truncate (Max Reitz)
eb42e7193e: iotests: fix 208 for luks format (Vladimir Sementsov-Ogievskiy)
627f607e3d: iotests: Update 186 after commit ac64273c66ab136c44043259162 (A=
lberto Garcia)
242c172132: iotests: Update 051 and 186 after commit 1454509726719e0933c (A=
lberto Garcia)
9dae635afa: gluster: Fix blockdev-add with server.N.type=3Dunix (Kevin Wolf)
604343ced7: blockjob: use qapi enum helpers (Marc-Andr=C3=A9 Lureau)
a865cebb82: blockjob: leak fix, remove from txn when failing early (Marc-An=
dr=C3=A9 Lureau)
a03083a017: block: handle invalid lseek returns gracefully (Jeff Cody)
3e4d88eabf: gluster: Fix blockdev-add with server.N.type=3Dunix (Kevin Wolf)
3ea7f4a226: linux-user: fix TARGET___O_TMPFILE for sparc (Laurent Vivier)
5de154e82f: linux-user: define TARGET_ARCH_HAS_KA_RESTORER (Laurent Vivier)
95a29a4e3e: linux-user: fix alpha signal emulation (Laurent Vivier)
d3b6e3bb6d: pc-bios/s390-ccw: update image (Cornelia Huck)
23bf419c1c: pc-bios/s390-ccw: Increase virtio timeout to 30 seconds (Thomas=
 Huth)
d9b06db813: hw/s390x: fix memory leak in s390_init_ipl_dev() (Greg Kurz)
5d7bc72a43: sev/i386: fix memory leak in sev_guest_init() (Greg Kurz)
72a841d2a4: exec: fix memory leak in find_max_supported_pagesize() (Greg Ku=
rz)
2b53af2523: nbd: trace meta context negotiation (Eric Blake)
260e34dbb7: nbd/client: Correctly handle bad server REP_META_CONTEXT (Eric =
Blake)
00d96a4612: nbd: Fix 32-bit compilation on BLOCK_STATUS (Eric Blake)
64a563dd8d: target/xtensa: linux-user: fix fadvise64 call (Max Filippov)
12e3340c23: linux-user: implement clock_settime (Max Filippov)
b9f9908e2d: linux-user: fix error propagation in clock_gettime (Max Filippo=
v)
a3da8be512: target/xtensa: linux-user: fix sysv IPC structures (Max Filippo=
v)
a23ea40982: linux-user: fix mq_getsetattr implementation (Max Filippov)
73a988d957: linux-user: call cpu_copy under clone_lock (Max Filippov)
4a6bf7adb9: target/xtensa: linux-user: rewind pc for restarted syscall (Max=
 Filippov)
20ef667060: target/xtensa: fix flush_window_regs (Max Filippov)
abbbb0350d: qemu-doc: Rework the network options chapter to make "-net" les=
s prominent (Thomas Huth)
4d0d1c077e: tests: Tests more flags of the CRB interface (Stefan Berger)
384cf1fc64: tpm: CRB: Enforce locality is requested before processing buffe=
r (Stefan Berger)
025bc93619: tpm: CRB: Reset Granted flag when relinquishing locality (Stefa=
n Berger)
3a3c873502: tpm: CRB: set the Idle flag by default (Stefan Berger)
b02403363f: RISC-V: Workaround for critical mstatus.FS bug (Michael Clark)
0746a92612: migration: Don't activate block devices if using -S (Dr. David =
Alan Gilbert)
fc6008f37a: migration: fix pfd leak (Marc-Andr=C3=A9 Lureau)
33b4f859f1: RISC-V: Fix incorrect disassembly for addiw (Michael Clark)
eab1586257: RISC-V: Convert cpu definition to future model (Michael Clark)
f2f1dde751: tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops (Richard Hender=
son)
