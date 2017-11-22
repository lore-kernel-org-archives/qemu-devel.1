Received: from eggs.gnu.org ([2001:4830:134:3::10]:43111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eHLdB-0007JF-OY
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eHLd7-0006sm-LK
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:23:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eHLd7-0006sT-By
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:23:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAM3Jpnu093533
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 22:23:15 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecyf04c27-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 22:23:14 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 22:23:13 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <151129128964.22232.12085565834223304351@sif>
	<255b996e-cfe4-2499-c6aa-8122461eb1dc@de.ibm.com>
	<fe97da57-87c3-40a0-92b9-f1868ab09080@de.ibm.com>
In-Reply-To: <fe97da57-87c3-40a0-92b9-f1868ab09080@de.ibm.com>
Date: Tue, 21 Nov 2017 21:23:00 -0600
Message-Id: <151132098079.31225.2285990377569459449@sif>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc2 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, jcody@redhat.com

Quoting Christian Borntraeger (2017-11-21 15:38:32)
> forgot to cc qemu-devel....
> =

> On 11/21/2017 10:37 PM, Christian Borntraeger wrote:
> > a quick heads up . Rc2 now triggers
> > +qemu-img: block/block-backend.c:2088: blk_root_drained_end: Assertion =
`blk->quiesce_counter' failed.
> > for several qemu iotests. =

> > =

> > I have not looked into any details.

It looks to be due to:

4afeffc8572f40d8844b946a30c00b10da4442b1
blockjob: do not allow coroutine double entry or entry-after-completion

> > =

> > Christian
> > =

> > On 11/21/2017 08:08 PM, Michael Roth wrote:
> >> Hello,
> >>
> >> On behalf of the QEMU Team, I'd like to announce the availability of t=
he
> >> third release candidate for the QEMU 2.11 release.  This release is me=
ant
> >> for testing purposes and should not be used in a production environmen=
t.
> >>
> >>   http://download.qemu-project.org/qemu-2.11.0-rc2.tar.xz
> >>   http://download.qemu-project.org/qemu-2.11.0-rc2.tar.xz.sig
> >>
> >> You can help improve the quality of the QEMU 2.11 release by testing t=
his
> >> release and reporting bugs on Launchpad:
> >>
> >>   https://bugs.launchpad.net/qemu/
> >>
> >> The release plan, as well a documented known issues for release
> >> candidates, are available at:
> >>
> >>   http://wiki.qemu.org/Planning/2.11
> >>
> >> Please add entries to the ChangeLog for the 2.11 release below:
> >>
> >>   http://wiki.qemu.org/ChangeLog/2.11
> >>
> >> Changes since rc1:
> >>
> >> a15d835f00: Update version for v2.11.0-rc2 release (Peter Maydell)
> >> d975301dc8: qemu-iotest: add test for blockjob coroutine race conditio=
n (Jeff Cody)
> >> a2339699c3: qemu-iotests: add option in common.qemu for mismatch only =
(Jeff Cody)
> >> 6133b39f3c: coroutine: abort if we try to schedule or enter a pending =
coroutine (Jeff Cody)
> >> 4afeffc857: blockjob: do not allow coroutine double entry or entry-aft=
er-completion (Jeff Cody)
> >> 7c3d1917fd: build: disarm the TCG unit test trap (Daniel P. Berrange)
> >> 2807746ff1: iotests: Fix 176 on 32-bit host (Eric Blake)
> >> 50a3efb0f0: block: Close a BlockDriverState completely even when bs->d=
rv is NULL (Alberto Garcia)
> >> 70a5afedd6: block: Error out on load_vm with active dirty bitmaps (Kev=
in Wolf)
> >> 2b624fe079: block: Add errp to bdrv_all_goto_snapshot() (Kevin Wolf)
> >> 0b62bcbc61: block: Add errp to bdrv_snapshot_goto() (Kevin Wolf)
> >> 1f4ad7d3b8: block: Don't request I/O permission with BDRV_O_NO_IO (Kev=
in Wolf)
> >> dacaa16238: block: Don't use BLK_PERM_CONSISTENT_READ for format probi=
ng (Kevin Wolf)
> >> 70b7fba987: Use HTTPS for qemu.org and other domains (Stefan Hajnoczi)
> >> 1b3bbc6887: Use qemu.org domain name (Stefan Hajnoczi)
> >> d0dead3b6d: scripts/make-release: ship u-boot source as a tarball (Mic=
hael Roth)
> >> 34d49937e4: accel/tcg: Handle atomic accesses to notdirty memory corre=
ctly (Peter Maydell)
> >> 2726627197: exec.c: Factor out before/after actions for notdirty memor=
y writes (Peter Maydell)
> >> df83eabd52: qga: replace GetIfEntry with GetIfEntry2 for interface sta=
ts (ZhiPeng Lu)
> >> 6cbf1ec85c: pc-bios/s390-ccw.img: update image (Cornelia Huck)
> >> f516511ea8: linux-user: Fix calculation of auxv length (Peter Maydell)
> >> b350ae138f: hw/arm: Silence xlnx-ep108 deprecation warning during test=
s (Thomas Huth)
> >> b6e70d1d7f: hw/arm/aspeed: Unlock SCU when running kernel (Joel Stanle=
y)
> >> 50cd71b0d3: arm: check regime, not current state, for ATS write PAR fo=
rmat (Peter Maydell)
> >> 2b75ef01ca: nvic: Fix ARMv7M MPU_RBAR reads (Peter Maydell)
> >> 96a8b92ed8: target/arm: Report GICv3 sysregs present in ID registers i=
f needed (Peter Maydell)
> >> b11ce33fe0: Revert "cpu-exec: don't overwrite exception_index" (Peter =
Maydell)
> >> 8775d91a0f: pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN=
 when rebooting (Thomas Huth)
> >> 7337c6eb98: s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG) (David Hilde=
nbrand)
> >> dc0bbef5e6: s390x: fix storing CPU status (again) (David Hildenbrand)
> >> c527e0afcd: hw/net/vmxnet3: Fix code to work on big endian hosts, too =
(Thomas Huth)
> >> 0dacea92d2: net: Transmit zero UDP checksum as 0xFFFF (Ed Swierk)
> >> ebc2327f07: MAINTAINERS: Add missing entry for eepro100 emulation (Ste=
fan Weil)
> >> 8f8e8053d9: hw/net/eepro100: Fix endianness problem on big endian host=
s (Thomas Huth)
> >> 2ec405524e: Revert "Add new PCI ID for i82559a" (Jason Wang)
> >> 4d36623520: colo-compare: fix the dangerous assignment (Mao Zhongyi)
> >> 8251248394: spapr: reset DRCs after devices (Greg Kurz)
> >> 7abd43baec: target/ppc: Update setting of cpu features to account for =
compat modes (Suraj Jitindar Singh)
> >> c0012e9a22: iotests: Make 087 pass without AIO enabled (Max Reitz)
> >> 5e003f17ec: block: Make bdrv_next() keep strong references (Max Reitz)
> >> 08546bcfb2: qcow2: Fix overly broad madvise() (Max Reitz)
> >> 4efb1f7c61: qcow2: Refuse to get unaligned offsets from cache (Max Rei=
tz)
> >> 23482f8a60: qcow2: Add bounds check to get_refblock_offset() (Max Reit=
z)
> >> d470ad42ac: block: Guard against NULL bs->drv (Max Reitz)
> >> 93bbaf03ff: qcow2: Unaligned zero cluster in handle_alloc() (Max Reitz)
> >> 791fff504c: qcow2: check_errors are fatal (Max Reitz)
> >> 3e3b838ffe: qcow2: reject unaligned offsets in write compressed (Anton=
 Nefedov)
> >> 2b7731938d: iotests: Add test for failing qemu-img commit (Max Reitz)
> >> 1b76e8389b: tests: Add check-qobject for equality tests (Max Reitz)
> >> 791cbccc94: iotests: Add test for non-string option reopening (Max Rei=
tz)
> >> 54fd1b0d26: block: qobject_is_equal() in bdrv_reopen_prepare() (Max Re=
itz)
> >> b38dd678a2: qapi: Add qobject_is_equal() (Max Reitz)
> >> 254bf807e5: qapi/qlist: Add qlist_append_null() macro (Max Reitz)
> >> 84be629d55: qapi/qnull: Add own header (Max Reitz)
> >> 4096974e18: qcow2: fix image corruption on commit with persistent bitm=
ap (Eric Blake)
> >> 3590cd0f04: iotests: test clearing unknown autoclear_features by qcow2=
 (Vladimir Sementsov-Ogievskiy)
> >> dafe096057: block: Fix permissions in image activation (Kevin Wolf)
> >> fed5f8f820: nbd/server: Fix error reporting for bad requests (Eric Bla=
ke)
> >> 01b05c66a3: nbd/client: Don't hard-disconnect on ESHUTDOWN from server=
 (Eric Blake)
> >> cb6b1a3fc3: nbd/client: Use error_prepend() correctly (Eric Blake)
> >> 08ace1d753: nbd: Don't crash when server reports NBD_CMD_READ failure =
(Eric Blake)
> >> f06033295b: qcow2: fix image corruption after committing qcow2 image i=
nto base (Daniel P. Berrange)
> >> 398e6ad014: block: Deprecate bdrv_set_read_only() and users (Kevin Wol=
f)
> >> f66afbe26f: qcow2: don't permit changing encryption parameters (Daniel=
 P. Berrange)
> >> 6473069416: block: Fix error path in bdrv_backing_update_filename() (K=
evin Wolf)
> >> c60f6fcfbd: qemu-iotests: Use -nographic in 182 (Kevin Wolf)
> >> 611e0653ad: replication: Fix replication open fail (Wang Guang)
> >> 3831c07b89: tests/bios-tables-test: Fix endianess problems when passin=
g data to iasl (Thomas Huth)
> >> f865da7c36: build-sys: restrict vmcoreinfo to fw_cfg+dma capable targe=
ts (Marc-Andr=C3=A9 Lureau)
> >> b948bb55da: vmcoreinfo: put it in the 'misc' device category (Marc-And=
r=C3=A9 Lureau)
> >> 7b8be49d36: NUMA: Enable adding NUMA node implicitly (Dou Liyang)
> >> 45bd4b1c09: tests/acpi-test-data: update _CRS in DSDT (Michael S. Tsir=
kin)
> >> 2d0f99ed38: hw/pcie-pci-bridge: restrict to X86 and ARM (Marcel Apfelb=
aum)
> >> 9fa99d2519: hw/pci-host: Fix x86 Host Bridges 64bit PCI hole (Marcel A=
pfelbaum)
> >> d06bce95ff: pci: Initialize pci_dev->name before use (Alexey Kardashev=
skiy)
> >> 7abea552ab: fix: unrealize virtio device if we fail to hotplug it (lin=
zhecheng)
> >> 341e0b5658: throttle-groups: forget timer and schedule next TGM on det=
ach (Stefan Hajnoczi)
> >> bcf43cdc17: sdl2: Fix broken display updating after the window is hidd=
en (Jindrich Makovicka)
> >> 24952847ad: sdl2: Do not leave grab when fullscreen (Jindrich Makovick=
a)
> >> cd6d78b718: sdl2: Fix dead keyboard after fullsceen (Jindrich Makovick=
a)
> >> 253347e100: sdl2: Use the same pointer show/hide logic for absolute an=
d relative mode (Jindrich Makovicka)
> >> fc49e7279d: sdl2: Do not quit the emulator when an auxilliary window i=
s closed (Jindrich Makovicka)
> >> 4950b1a766: fix scripts/update-linux-headers.sh here document (Gerd Ho=
ffmann)
> >> 07c114bbf3: exec: Do not resolve subpage in mru_section (Paolo Bonzini)
> >> 6cd65969da: tpm_tis: Return 0 for every register in case of failure mo=
de (Stefan Berger)
> >> ad4aca69bb: tpm_tis: Return TPM_VERSION_UNSPEC in case of BE failure (=
Stefan Berger)
> >> 17b1af773e: tpm-emulator: protect concurrent ctrl_chr access (Marc-And=
r=C3=A9 Lureau)
> >> 83e83c34b2: specs: Extend TPM spec with TPM emulator description (Stef=
an Berger)
> >> 3c5f9c3f35: target/arm: Fix GETPC usage in do_paired_cmpxchg64_l/be (R=
ichard Henderson)
> >> 3bdb5fcc9a: target/arm: Use helper_retaddr in stxp helpers (Richard He=
nderson)
> >> ec603b5584: tcg: Record code_gen_buffer address for user-only memory h=
elpers (Richard Henderson)
> >> 26a5db322b: util/stats64: Fix min/max comparisons (Max Reitz)
> >> 17b50b0c29: cpu-exec: avoid cpu_exec_nocache infinite loop with record=
/replay (Pavel Dovgalyuk)
> >> e01cecabf3: cpu-exec: don't overwrite exception_index (Pavel Dovgalyuk)
> >> 9200361060: vhost-user-scsi: add missing virtqueue_size param (Dariusz=
 Stojaczyk)
> >> 6976af663d: target-i386: adds PV_TLB_FLUSH CPUID feature bit (Wanpeng =
Li)
> >> 54113dd5eb: thread-posix: fix qemu_rec_mutex_trylock macro (Emilio G. =
Cota)
> >> b8e535ae8a: Makefile: simpler/faster "make help" (Philippe Mathieu-Dau=
d=C3=A9)
> >> a2e6ffab97: ioapic/tracing: Remove last DPRINTFs (Dr. David Alan Gilbe=
rt)
> >> 78bfef72fb: linux-user: Handle rt_sigaction correctly for SPARC (Peter=
 Maydell)
> >> 8d8cb956e0: linux-user/sparc: Put address for data faults where linux-=
user expects it (Peter Maydell)
> >> 15e692a6fc: linux-user/ppc: Report correct fault address for data faul=
ts (Peter Maydell)
> >> f2d34df3c1: linux-user/s390x: Mask si_addr for SIGSEGV (Peter Maydell)
> >> a8b154a637: linux-user: return EINVAL from prctl(PR_*_SECCOMP) (James =
Cowgill)
> >> a4dd3d5172: linux-user: fix 'finshed' typo in comment (Emilio G. Cota)
> >> 8bf8e9df4a: linux-user/syscall.c: Handle SH4's exceptional alignment f=
or p{read, write}64 (James Clarke)
> >> 541e169042: linux-user: Handle TARGET_MAP_STACK and TARGET_MAP_HUGETLB=
 (Helge Deller)
> >> 3d60c84dea: linux-user/hppa: Fix TARGET_F_RDLCK, TARGET_F_WRLCK, TARGE=
T_F_UNLCK (Helge Deller)
> >> e65be6a7cf: linux-user/hppa: Fix TARGET_MAP_TYPE (Helge Deller)
> >> 92afb15310: linux-user/hppa: Fix typo for TARGET_NR_epoll_wait (Helge =
Deller)
> >> fc37dcfe1a: linux-user/hppa: Fix cpu_clone_regs (Richard Henderson)
> >> 2da6e76cca: linux-user/hppa: Fix TARGET_SA_* defines (Helge Deller)
> >> 7f047de18c: linux-user: Restrict usage of sa_restorer (Richard Henders=
on)
> >> e5a11847c4: Enable 8-byte wide MMIO for 16550 serial devices (Mike Naw=
rocki)
> >>
> >>
>=20
