Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dfB2f-0002Qi-8M
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dfB2b-0007Fn-6O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51644
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dfB2a-0007FM-W2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:23:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v78KNjMK067989
	for <qemu-devel@nongnu.org>; Tue, 8 Aug 2017 16:23:48 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c7hbshxnw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 16:23:47 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 8 Aug 2017 16:23:47 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 08 Aug 2017 15:23:37 -0500
Message-Id: <150222381791.30596.10692796082101371085@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc2 is now available
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
third release candidate for the QEMU 2.10 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.10.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-2.10.0-rc2.tar.xz.sig

A note from the maintainer:

  Known issue in this rc: "make check" may produce warnings about
  "acpi-test: Warning! DSDT mismatch". These are harmless and will
  be silenced in the next rc.
 =

You can help improve the quality of the QEMU 2.10 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.10

Please add entries to the ChangeLog for the 2.10 release below:

  http://wiki.qemu.org/ChangeLog/2.10

Changes since rc1:

54affb3: Update version for v2.10.0-rc2 release (Peter Maydell)
f5048cb: maint: Include bug-reporting info in --help output (Eric Blake)
8f1c29a: qga: Give more --version information (Eric Blake)
4face32: qemu-io: Give more --version information (Eric Blake)
57b2d9d: qemu-img: Sort sub-command names in --help (Eric Blake)
113fe79: block/nfs: fix mutex assertion in nfs_file_close() (Jeff Cody)
ea22b7a: qemu-iotests: Test reopen between read-only and read-write (Kevin =
Wolf)
ea92203: qemu-io: Allow reopen read-write (Kevin Wolf)
fd45202: block: Set BDRV_O_ALLOW_RDWR during rw reopen (Kevin Wolf)
54a32bf: block: Allow reopen rw without BDRV_O_ALLOW_RDWR (Kevin Wolf)
8aecf1d: block: Fix order in bdrv_replace_child() (Kevin Wolf)
e5e6268: parallels: drop check that bdrv_truncate() is working (Denis V. Lu=
nev)
d8b83e3: parallels: respect error code of bdrv_getlength() in allocate_clus=
ters() (Denis V. Lunev)
70d9110: block: respect error code from bdrv_getlength in handle_aiocb_writ=
e_zeroes (Denis V. Lunev)
0e51b9b: vmdk: Fix error handling/reporting of vmdk_check (Fam Zheng)
809eb70: block/null: Remove 'filename' option (Kevin Wolf)
8234668: block: drop bdrv_set_key from BlockDriver (Paolo Bonzini)
95d7298: block/vhdx: check error return of bdrv_truncate() (Jeff Cody)
c6572fa: block/vhdx: check error return of bdrv_flush() (Jeff Cody)
27539ac: block/vhdx: check for offset overflow to bdrv_truncate() (Jeff Cod=
y)
3f91069: block/vhdx: check error return of bdrv_getlength() (Jeff Cody)
795be06: quorum: Set sectors-count to 0 when reporting a flush error (Alber=
to Garcia)
53dd401: qemu-iotests/109: Fix lock race condition (Cleber Rosa)
ab6ab3e: target/i386: set rip_offset for some SSE4.1 instructions (Joseph M=
yers)
ded6ddc: scsi: clarify sense codes for LUN0 emulation (Hannes Reinecke)
1b7ac7c: kvm: workaround build break on gcc-7.1.1 / fedora26 (Greg Kurz)
2a96a55: Revert "rcu: do not create thread in pthread_atfork callback" (Pao=
lo Bonzini)
73c6e40: rcu: completely disable pthread_atfork callbacks as soon as possib=
le (Paolo Bonzini)
e2a7f28: cpu: add APIs to allocate/free CPU environment (Michael S. Tsirkin)
a41c78c: hw/i386: allow SHPC for Q35 machine (Aleksandr Bezzubikov)
f22ab6c: hw/arm/virt: Add 2.10 machine type (Eric Auger)
f42cf44: block: move trace probes into bdrv_co_preadv|pwritev (Daniel P. Be=
rrange)
13aaef6: tcg: Increase minimum alignment from tcg_malloc to 8 (Richard Hend=
erson)
de4e05d: target/s390x: Fix CSST for 16-byte store (Richard Henderson)
ca671de: tcg/arm: Fix runtime overalignment test (Richard Henderson)
e6a7486: build-sys: add --disable-vhost-user (Marc-Andr=C3=A9 Lureau)
413d463: slirp: check len against dhcp options array end (Prasad J Pandit)
5c843af: slirp: fill error when failing to initialize user network (Herv=C3=
=A9 Poussineau)
be2960b: cpu: don't allow negative core id (Laurent Vivier)
d673a68: target/mips: Fix RDHWR CC with icount (James Hogan)
51ca717: target/mips: Drop redundant gen_io_start/stop() (James Hogan)
b74cddc: target/mips: Use BS_EXCP where interrupts are expected (James Hoga=
n)
2d1847e: target-mips: apply CP0.PageMask before writing into TLB entry (Leo=
n Alrae)
d3d93c6: mips: Add KVM T&E segment support for TCG (James Hogan)
6743334: mips: Improve segment defs for KVM T&E guests (James Hogan)
9652ef2: mips/malta: leave space for the bootmap after the initrd (Aurelien=
 Jarno)
cb539fd: target-mips: Don't stop on [d]mtc0 DESAVE/KScratch (James Hogan)
