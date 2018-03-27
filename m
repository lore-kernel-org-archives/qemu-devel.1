Received: from eggs.gnu.org ([2001:4830:134:3::10]:46082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f0yHu-0004LJ-K4
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f0yHr-0006s0-Bv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:45:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53606
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f0yHr-0006rn-6C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 19:45:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RNdbUo083241
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:45:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gyu8gafqk-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:45:52 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 19:45:52 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 18:45:42 -0500
Message-Id: <152219434244.14447.17162045562665710632@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc1 is now available
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
second release candidate for the QEMU 2.12 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.12.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-2.12.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 2.12 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.12

Please add entries to the ChangeLog for the 2.12 release below:

  http://wiki.qemu.org/ChangeLog/2.12

Changes since rc0:

fa3704d877: Update version for v2.12.0-rc1 release (Peter Maydell)
1bb982b8fc: gdbstub: send a termination packet instead of crashing gdb (KON=
RAD Frederic)
0dfddbb537: hmp.c: Revert hmp_info_cpus output format change (Satheesh Raje=
ndran)
fa198ad9bd: tests: qmp-test: add test for new "x-oob" (Peter Xu)
ddee57e017: tests: Add parameter to qtest_init_without_qmp_handshake (Eric =
Blake)
be933ffc23: monitor: new parameter "x-oob" (Peter Xu)
6d2d563f8c: qmp: cleanup qmp queues properly (Peter Xu)
1a1b11dc0f: tests: add oob-test for qapi-schema (Peter Xu)
4bebca1e42: tests: let qapi-schema tests detect oob (Peter Xu)
9408860165: qapi: restrict allow-oob value to be "true" (Peter Xu)
9ddb7456c8: qmp: fix qmp_capabilities error regression (Peter Xu)
625eaca9e5: qdict: remove useless cast (Laurent Vivier)
710c263407: error: Remove NULL checks on error_propagate() calls (Laurent V=
ivier)
2d9178d90f: error: Strip trailing '\n' from error string arguments (again a=
gain) (Laurent Vivier)
fdf235ba15: tests: Silence false positive warning on generated test name (E=
ric Blake)
fa15cf8b5c: qmp-test: fix response leak (Marc-Andr=C3=A9 Lureau)
f5a53faad4: MAINTAINERS: add include/block/aio-wait.h (Stefan Hajnoczi)
35111583aa: coroutine: add test-aio coroutine queue chaining test case (Ste=
fan Hajnoczi)
c40a254570: coroutine: avoid co_queue_wakeup recursion (Stefan Hajnoczi)
67a74148d8: queue: add QSIMPLEQ_PREPEND() (Stefan Hajnoczi)
eb69953ecb: macio: fix NULL pointer dereference when issuing IDE trim (Mark=
 Cave-Ayland)
caeadbc8ba: ide: fix invalid TRIM range abortion for macio (Anton Nefedov)
d0ce7e9cfc: target/xtensa: fix timers test (Max Filippov)
12ab0b33f1: linux-user/xtensa: remove stray syscall.h (Max Filippov)
2745c3bbf3: target/xtensa/import_core.sh: fix #include <xtensa-isa.h> (Max =
Filippov)
dda2441b2b: target/xtensa: add .inc. to non-top level source file names (Ma=
x Filippov)
a77672ea3d: vmdk: return ERROR when cluster sector is larger than vmdk limi=
tation (yuchenlin)
f7640f0dbc: iotests: enable shared migration cases in 169 (Vladimir Sements=
ov-Ogievskiy)
2d949dfcef: qcow2: fix bitmaps loading when bitmaps already exist (Vladimir=
 Sementsov-Ogievskiy)
b1336cc2ec: qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint() (Vladimir Seme=
ntsov-Ogievskiy)
ebd0e15114: target/hppa: Include priv level in user-only iaoq (Richard Hend=
erson)
83d7c40c92: scripts/decodetree: Fix insnmask not marked as global in main()=
 (Bastian Koppelmann)
f8e1a98964: qemu-pr-helper: Actually allow users to specify pidfile (Michal=
 Privoznik)
12051d82f0: chardev/char-fe: Allow NULL chardev in qemu_chr_fe_init() (Pete=
r Maydell)
90c558beca: iothread: fix breakage on windows (Peter Xu)
09c2c6ffda: scsi: turn "is this a SCSI device?" into a conditional hint (Pa=
olo Bonzini)
ff82fab792: chardev-socket: remove useless if (Paolo Bonzini)
87f963be66: tcg: Really fix cpu_io_recompile (Richard Henderson)
8e029fd64e: vhost-user-test: add back memfd check (Marc-Andr=C3=A9 Lureau)
642e065a15: vhost-user-test: do not hang if chardev creation failed (Marc-A=
ndr=C3=A9 Lureau)
6ff8d9b03a: scripts/device-crash-test: Remove fixed isapc-with-iommu entry =
(Thomas Huth)
c9073238fc: hw/audio: Fix crashes when devices are used on ISA bus without =
DMA (Thomas Huth)
b3da551389: fdc: Exit if ISA controller does not support DMA (Alexey Kardas=
hevskiy)
089eac81e1: hw/net/can: Fix segfaults when using the devices without bus (T=
homas Huth)
4e286099fe: WHPX improve vcpu_post_run perf (Justin Terry (VM))
60168541da: WHPX fix WHvSetPartitionProperty in PropertyCode (Justin Terry =
(VM))
3907e6318e: WHPX fix WHvGetCapability out WrittenSizeInBytes (Justin Terry =
(VM))
36b4cf1934: scripts/get_maintainer.pl: Print proper error message for missi=
ng $file (Ian Jackson)
0b7e7f6681: qemu-iotests: Test vhdx image creation with QMP (Kevin Wolf)
6f16f7c562: vhdx: Check for 4 GB maximum log size on creation (Kevin Wolf)
0fcc38e7d0: vhdx: Don't use error_setg_errno() with constant errno (Kevin W=
olf)
b412f49407: vhdx: Require power-of-two block size on create (Kevin Wolf)
e8f6ea6fb6: qemu-iotests: Test parallels image creation with QMP (Kevin Wol=
f)
2332d82589: parallels: Check maximum cluster size on create (Kevin Wolf)
50880f25c8: qemu-iotests: Test invalid resize on luks (Kevin Wolf)
120bc742c0: luks: Turn another invalid assertion into check (Kevin Wolf)
633c175f8c: qemu-iotests: Enable 025 for luks (Kevin Wolf)
b7de0777dc: qemu-iotests: Test vdi image creation with QMP (Kevin Wolf)
95a14d51b2: vdi: Fix build with CONFIG_VDI_DEBUG (Kevin Wolf)
61fa64871d: vdi: Change 'static' create option to 'preallocation' in QMP (K=
evin Wolf)
abf754fe40: qcow2: Reset free_cluster_index when allocating a new refcount =
block (Alberto Garcia)
1e486cf30a: include/block/block_int: Document protocol related functions (F=
abiano Rosas)
8140e786f0: block/blkreplay: Remove protocol-related fields (Fabiano Rosas)
a7328ba55f: block/throttle: Remove protocol-related fields (Fabiano Rosas)
65d2c3e2f6: block/quorum: Remove protocol-related fields (Fabiano Rosas)
cb83d2efe1: block/replication: Remove protocol_name field (Fabiano Rosas)
71b74b2544: iotests: 163 is not quick (Eric Blake)
7587855cd2: net/vde: print error on vde_open() failure (Julia Suvorova via =
Qemu-devel)
94b52958b7: virtio_net: flush uncompleted TX on reset (Greg Kurz)
548f514cf8: target/arm: Always set FAR to a known unknown value for debug e=
xceptions (Peter Maydell)
62b94f31d0: target/arm: Set FSR for BKPT, BRK when raising exception (Peter=
 Maydell)
81621d9ab8: target/arm: Factor out code to calculate FSR for debug exceptio=
ns (Peter Maydell)
c900a2e62d: target/arm: Honour MDCR_EL2.TDE when routing exceptions due to =
BKPT/BRK (Peter Maydell)
dfadc3bfb4: mach-virt: Set VM's SMBIOS system version to mc->name (Wei Huan=
g)
478a573a7d: i.MX: Support serial RS-232 break properly (Trent Piepho)
2b0b93210a: hw/arm/bcm2836: Use the Cortex-A7 instead of Cortex-A15 (Peter =
Maydell)
a2e2d7fc46: hw/intc/arm_gicv3: Fix secure-GIC NS ICC_PMR and ICC_RPR access=
es (Peter Maydell)
544156efcf: sdhci: fix incorrect use of Error * (Paolo Bonzini)
a75a52d624: arm/translate-a64: treat DISAS_UPDATE as variant of DISAS_EXIT =
(Victor Kamensky)
09576e74db: migration: Fix block migration flag case (Dr. David Alan Gilber=
t)
39615354fc: qapi: Force UTF8 encoding when parsing qapi files (Eric Blake)
a4f90923b5: Revert "monitor: enable IO thread for (qmp & !mux) typed" (Pete=
r Xu)
cc797607c0: Revert "tests: qmp-test: verify command batching" (Peter Xu)
4fd78ad793: Revert "tests: qmp-test: add oob test" (Peter Xu)
b47d1e9fe0: migration/block: compare only read blocks against the rate limi=
ter (Peter Lieven)
44815334e1: migration/block: limit the number of parallel I/O requests (Pet=
er Lieven)
e8a0f2f9a1: migration: Fix rate limiting issue on RDMA migration (Lidong Ch=
en)
bdd847a026: migration: convert socket server to QIONetListener (Daniel P. B=
errange)
6f559013c8: hw/rdma: Fix 32-bit compilation (Yuval Shaia)
94f480b8db: hw/rdma: Use correct print format in CHK_ATTR macro (Yuval Shai=
a)
9bbb8d3577: hw/rdma: Change host_virt to void * (Yuval Shaia)
197053e212: hw/rdma: fix clang compilation errors (Marcel Apfelbaum)
9edc19c939: make: switch from -I to -iquote (Michael S. Tsirkin)
0efc9511aa: rdma: fix up include directives (Michael S. Tsirkin)
79cfdca7aa: hw/rdma: Add support for Query QP verb to pvrdma device (Yuval =
Shaia)
c99f217431: hw/rdma: Add Query QP operation (Yuval Shaia)
06a97edac1: s390x/cpumodel: fix feature groups and breakage of MSA8 (Christ=
ian Borntraeger)
57da367b9e: s390x/pci: forbid multifunction pci device (Yi Min Zhao)
d522e0bd18: gitmodules: Use the QEMU mirror of qemu-palcode (Peter Maydell)
e2679395d5: tests/multiboot: Add .gitignore (Kevin Wolf)
1c8c426fb4: tests/multiboot: Add tests for the a.out kludge (Kevin Wolf)
49713c413a: tests/multiboot: Test exit code for every qemu run (Kevin Wolf)
dbf2dce7aa: multiboot: Check validity of mh_header_addr (Kevin Wolf)
b17a9054a0: multiboot: Reject kernels exceeding the address space (Kevin Wo=
lf)
4b17bc933f: dump-guest-memory: more descriptive lookup_type failure (Andrew=
 Jones)
0c33659d09: dump.c: allow fd_write_vmcore to return errno on failure (Yasmi=
n Beatriz)
ffbf24bdb2: tpm: CRB: query backend for TPM established flag (Stefan Berger)
de4a22d0fa: tpm: CRB: reset locAssigned upon relinquishing locality (Stefan=
 Berger)
e1880ed80a: tpm: CRB: set registers to 0 by default (Stefan Berger)
be052a3b3d: tpm: CRB: Set tpmRegValidSts flag to '1' in device reset (Stefa=
n Berger)
2a53535af4: linux-user: init_guest_space: Try to make ARM space+commpage co=
ntinuous (Luke Shumaker)
