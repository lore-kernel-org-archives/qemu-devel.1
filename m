Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMhuG-00056q-55
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMhi6-0003Px-58
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:03:10 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gMhi5-0003Pd-Uv
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:03:06 -0500
Received: by mail-ot1-x343.google.com with SMTP id n46so13005381otb.9
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 15:03:05 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <154215017000.30771.5390705532145615451@sif>
Date: Tue, 13 Nov 2018 17:02:50 -0600
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0-rc1 is now available
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
second release candidate for the QEMU 3.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.1.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-3.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 3.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.1

Please add entries to the ChangeLog for the 3.1 release below:

  http://wiki.qemu.org/ChangeLog/3.1

Thank you to everyone involved!

Changes since rc0:

cb968d275c: Update version for v3.1.0-rc1 release (Peter Maydell)
436c0cbbeb: target/arm/cpu: Give Cortex-A15 and -A7 the EL2 feature (Peter =
Maydell)
593cfa2b63: target/arm: Hyp mode R14 is shared with User and System (Peter =
Maydell)
89430fc6f8: target/arm: Correctly implement handling of HCR_EL2.{VI, VF} (P=
eter Maydell)
ed89f078ff: target/arm: Track the state of our irq lines from the GIC expli=
citly (Peter Maydell)
c624ea0fa7: Revert "target/arm: Implement HCR.VI and VF" (Peter Maydell)
22af90255e: arm: fix aa64_generate_debug_exceptions to work with EL2 (Alex =
Benn=C3=A9e)
b281ba4223: arm: use symbolic MDCR_TDE in arm_debug_target_el (Alex Benn=C3=
=A9e)
f251cb2371: tests/guest-debug: fix scoping of failcount (Alex Benn=C3=A9e)
14f9a5c0e4: target/arm64: kvm debug set target_el when passing exception to=
 guest (Alex Benn=C3=A9e)
9b16ec4351: target/arm64: hold BQL when calling do_interrupt() (Alex Benn=
=C3=A9e)
864df2058d: target/arm64: properly handle DBGVR RESS bits (Alex Benn=C3=A9e)
09a86dfa3f: target/arm: Fix typo in tlbi_aa64_vmalle1_write (Richard Hender=
son)
e9ac8e84f0: hw/arm/sysbus-fdt: Only call match_fn callback if the type matc=
hes (Eric Auger)
671f11b204: MAINTAINERS: Add an entry for the 'collie' machine (Thomas Huth)
e24ad48490: target/arm: Remove antique TODO comment (Peter Maydell)
521ed6b401: target/arm: Remove workaround for small SAU regions (Peter Mayd=
ell)
7cb6d3c9be: qcow2: Read outside array bounds in qcow2_pre_write_overlap_che=
ck() (Liam Merwick)
8d9401c279: block: Fix potential Null pointer dereferences in vvfat.c (Liam=
 Merwick)
2e2db26009: qemu-img: assert block_job_get() does not return NULL in img_co=
mmit() (Liam Merwick)
602414d123: block: Null pointer dereference in blk_root_get_parent_desc() (=
Liam Merwick)
c2032289b0: job: Fix off-by-one assert checks for JobSTT and JobVerbTable (=
Liam Merwick)
2f74013655: block: Make more block drivers compile-time configurable (Jeff =
Cody)
aef96d7d4f: tests: Add unit tests for image locking (Fam Zheng)
f2e3af29b7: file-posix: Drop s->lock_fd (Fam Zheng)
2996ffad3a: file-posix: Skip effectiveless OFD lock operations (Fam Zheng)
a883d6a0bc: nvme: free cmbuf in nvme_exit (Li Qiang)
20faf0f5f8: nvme: don't unref ctrl_mem when device unrealized (Li Qiang)
d52e1a0e96: blockdev: Consistently use snapshot_node_name in external_snaps=
hot_prepare() (Peter Maydell)
63d5341f85: blockdev: handle error on block latency histogram set error (zh=
enwei pi)
db0754df88: file-posix: Use error API properly (Fam Zheng)
113a9dd73f: linux-user: Add support for SO_REUSEPORT (Yunqiang Su)
435cc3e4d5: hw/acpi/nvdimm: Don't take address of fields in packed structs =
(Peter Maydell)
9f214bd390: linux-user: Clean up nios2 main loop signal handling (Peter May=
dell)
b10089a14c: linux-user: Don't call gdb_handlesig() before queue_signal() (P=
eter Maydell)
e285977e77: linux-user: Remove dead error-checking code (Peter Maydell)
f1aba960cc: ui/gtk: fix cursor in egl mode (Gerd Hoffmann)
6cdc2d189c: pulseaudio: process audio data in smaller chunks (Gerd Hoffmann)
627c865d22: edid: silence a stringop-overflow warning (Marc-Andr=C3=A9 Lure=
au)
c0188e69d3: bt: Mark the bluetooth subsystem as deprecated (Thomas Huth)
b4c0595446: docker: use HTTPS git URL for virglrenderer (Stefan Hajnoczi)
06bef596ce: target-alpha: use HTTPS git URL for palcode (Stefan Hajnoczi)
8308ed30a2: pc-testdev: use HTTPS git URL (Stefan Hajnoczi)
ebe2aad24e: git: use HTTPS git URLs for repo.or.cz (Stefan Hajnoczi)
a897f22b59: gitmodules: use 'https://' instead of 'git://' (Stefan Hajnoczi)
e18a8b3423: MAINTAINERS: use 'https://' instead of 'git://' for GitHub (Ste=
fan Hajnoczi)
86e6010a7a: get_maintainer: use 'https://' instead of 'git://' (Stefan Hajn=
oczi)
c814b17762: README: use 'https://' instead of 'git://' (Stefan Hajnoczi)
5c75f3adbb: slirp: fork_exec(): create and connect child socket before fork=
() (Peter Maydell)
4ded9bb54c: slirp: Remove code that handles socreate() failure (Peter Mayde=
ll)
84ec9bfaf2: slirp: Use g_new() to allocate sockets in socreate() (Peter May=
dell)
c41868152a: slirp: Don't pass possibly -1 fd to send() (Peter Maydell)
61baac2fdb: qga: Add multiple include guard to guest-agent-core.h (Peter Ma=
ydell)
f898ee0f99: qga-win: fix leaks of build_guest_disk_info() (Marc-Andr=C3=A9 =
Lureau)
5b76ef50f6: 9p: write lock path in v9fs_co_open2() (Greg Kurz)
00a014ac01: riscv: spike: Fix memory leak in the board init (Alistair Franc=
is)
a7ce790a02: tcg/tcg-op.h: Add multiple include guard (Peter Maydell)
0b57007755: replay: Exit on errors reading from replay log (Peter Maydell)
b9a477b725: ppc/spapr_caps: Add SPAPR_CAP_NESTED_KVM_HV (Suraj Jitindar Sin=
gh)
56de52cad9: target/ppc: Add one reg id for ptcr (Suraj Jitindar Singh)
a59d628f92: This patch fixes processing of rfi instructions in icount mode.=
 (Maria Klimushenkova)
09a333ee3d: hw/ppc/ppc440_uc: Remove dead code in sdram_size() (Peter Mayde=
ll)
bba8e23aff: MAINTAINERS: PPC: Remove myself (Alexander Graf)
d07945e78e: ppc/pnv: check size before data buffer access (Prasad J Pandit)
b8edea50a7: target/ppc: fix mtmsr instruction for icount (Pavel Dovgalyuk)
1bbd6272a1: hw/ppc/mac_newworld: Free openpic_irqs array after use (Peter M=
aydell)
0c2adc1753: macio/pmu: Fix missing vmsd terminator (Dr. David Alan Gilbert)
4fc4c6a53d: spapr_pci: convert g_malloc() to g_new() (Greg Kurz)
a3dec427e0: target/ppc: Split out float_invalid_cvt (Richard Henderson)
fec59ef30c: target/ppc: Split out float_invalid_op_div (Richard Henderson)
4f0da706c2: target/ppc: Split out float_invalid_op_mul (Richard Henderson)
57483867e9: target/ppc: Split out float_invalid_op_addsub (Richard Henderso=
n)
0394d7a684: target/ppc: Introduce fp number classification (Richard Henders=
on)
6525aadc12: target/ppc: Remove float_check_status (Richard Henderson)
13c9115fa9: target/ppc: Split up float_invalid_op_excp (Richard Henderson)
0e947a89ce: hw/ppc/spapr_rng: Introduce CONFIG_SPAPR_RNG switch for spapr_r=
ng.c (Thomas Huth)
73785b329e: PPC: e500: convert SysBus init method to a realize method (C=C3=
=A9dric Le Goater)
95ba556707: ppc4xx_pci: convert SysBus init method to a realize method (C=
=C3=A9dric Le Goater)
7b0f4ec9d3: ppc440_pcix: convert SysBus init method to a realize method (C=
=C3=A9dric Le Goater)
50728199c5: target/ppc: add external PID support (Roman Kapl)
a458774ad7: util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX (Peter =
Maydell)
ca95173c7f: include/qemu/thread.h: Document qemu_thread_atexit* API (Peter =
Maydell)
763c56872b: scsi-generic: do not do VPD emulation for sense other than ILLE=
GAL_REQUEST (Paolo Bonzini)
3d4a8bf0ee: scsi-generic: avoid invalid access to struct when emulating blo=
ck limits (Paolo Bonzini)
57dbb58d80: scsi-generic: avoid out-of-bounds access to VPD page list (Paol=
o Bonzini)
6c219fc8a1: scsi-generic: keep VPD page list sorted (Paolo Bonzini)
e58ccf0396: lsi53c895a: check message length value is valid (Prasad J Pandi=
t)
7f13535656: scripts/dump-guest-memory: Synchronize with guest_phys_blocks_r=
egion_add (Paolo Bonzini)
17a6ddb6fa: memory-mapping: skip non-volatile memory regions in GuestPhysBl=
ockList (Marc-Andr=C3=A9 Lureau)
640713d8a1: nvdimm: set non-volatile on the memory region (Marc-Andr=C3=A9 =
Lureau)
c26763f8ec: memory: learn about non-volatile memory region (Marc-Andr=C3=A9=
 Lureau)
1a1435dd61: target/i386: Clear RF on SYSCALL instruction (Rudolf Marek)
2185fd67d2: MAINTAINERS: remove or downgrade myself to reviewer from some s=
ubsystems (Paolo Bonzini)
bce410a33b: ivshmem: fix memory backend leak (Igor Mammedov)
d4715481de: i386: clarify that the Q35 machine type implements a P35 chipse=
t (Daniel P. Berrang=C3=A9)
e204ac612c: x86: hv_evmcs CPU flag support (Vitaly Kuznetsov)
013aabdc66: icount: fix deadlock when all cpus are sleeping (Clement Descha=
mps)
