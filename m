Received: from eggs.gnu.org ([2001:4830:134:3::10]:36397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cszgJ-0006Qw-HE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cszgE-00018L-Hn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:33:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cszgE-000186-8A
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:33:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2SMJHiU104071
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:33:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fswab2h5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:33:31 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 28 Mar 2017 18:33:30 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 28 Mar 2017 17:33:21 -0500
Message-Id: <149074040175.19300.6522092894860160358@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc2 is now available
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
third release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc2.tar.xz.sig

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

Changes since rc1:

df90463: Update version for v2.9.0-rc2 release (Peter Maydell)
44fdc76: sockets: Fix socket_address_to_string() hostname truncation (Marku=
s Armbruster)
2836284: rbd: Fix bugs around -drive parameter "server" (Markus Armbruster)
577d8c9: rbd: Revert -blockdev parameter password-secret (Markus Armbruster)
464444f: rbd: Revert -blockdev and -drive parameter auth-supported (Markus =
Armbruster)
0784639: rbd: Clean up qemu_rbd_create()'s detour through QemuOpts (Markus =
Armbruster)
cbf036b: rbd: Clean up runtime_opts, fix -drive to reject filename (Markus =
Armbruster)
82f20e8: rbd: Don't accept -drive driver=3Drbd, keyvalue-pairs=3D... (Marku=
s Armbruster)
8efb339: rbd: Clean up after the previous commit (Markus Armbruster)
730b00b: rbd: Don't limit length of parameter values (Markus Armbruster)
f51c363: rbd: Fix to cleanly reject -drive without pool or image (Markus Ar=
mbruster)
eb87203: rbd: Reject -blockdev server.*.{numeric, to, ipv4, ipv6} (Markus A=
rmbruster)
79b7a77: block: Declare blockdev-add and blockdev-del supported (Markus Arm=
bruster)
7609ffb: trace: fix tcg tracing build breakage (Stefan Hajnoczi)
dc62da8: parallels: wrong call to bdrv_truncate (Denis V. Lunev)
5b12c16: replay/replay.c: bump REPLAY_VERSION (Alex Benn=C3=A9e)
8cfef89: tcg: Add a new line after incompatibility warning (Pranith Kumar)
0096109: ui/console: use exclusive mechanism directly (Alex Benn=C3=A9e)
8539093: ui/console: ensure do_safe_dpy_refresh holds BQL (Alex Benn=C3=A9e)
95992b6: bsd-user: align use of mmap_lock to that of linux-user (Alex Benn=
=C3=A9e)
02bed6b: user-exec: handle synchronous signals from QEMU gracefully (Alex B=
enn=C3=A9e)
34ef723: tests/virtio-9p-test: Don't call le*_to_cpus on fields of packed s=
truct (Peter Maydell)
d63fb19: 9pfs: fix file descriptor leak (Li Qiang)
700f9ce: block/file-posix.c: Fix unused variable warning on OpenBSD (Peter =
Maydell)
bed58b4: scsi-generic: Fill in opt_xfer_len in INQUIRY reply if it is zero =
(Fam Zheng)
e5bcf96: file-posix: Make bdrv_flush() failure permanent without O_DIRECT (=
Kevin Wolf)
a12a712: nbd-client: fix handling of hungup connections (Paolo Bonzini)
c919297: qemu-img: print short help on getopt failure (Stefan Hajnoczi)
f707762: qemu-img: fix switch indentation in img_amend() (Stefan Hajnoczi)
4581c16: qemu-img: show help for invalid global options (Stefan Hajnoczi)
5354edd: Revert "apic: save apic_delivered flag" (Paolo Bonzini)
e4548bb: nbd: drop unused NBDClientSession.is_unix field (Stefan Hajnoczi)
12f8def: win32: replace custom mutex and condition variable with native pri=
mitives (Andrey Shedel)
e5766eb: vnc: fix reverse mode (Gerd Hoffmann)
8bce03e: ui/egl-helpers: fix egl 1.5 display init (Gerd Hoffmann)
db6cd4c: cirrus: fix PUTPIXEL macro (Gerd Hoffmann)
5709454: virtio-input: fix eventq batching (Ladi Prosek)
0f5a15e: virtio-input: free event queue when finalizing (Ladi Prosek)
7150d34: boot-serial-test: use -no-shutdown (Christian Borntraeger)
dfd0dcc: mem-prealloc: fix sysconf(_SC_NPROCESSORS_ONLN) failure case. (Jit=
endra Kolhe)
30663fd: tcg/i386: Check the size of instruction being translated (Pranith =
Kumar)
7140778: virtio-scsi: Fix acquire/release in dataplane handlers (Fam Zheng)
3d69f82: virtio-scsi: Make virtio_scsi_acquire/release public (Fam Zheng)
ade9c1a: clear pending status before calling memory commit (Xu, Anthony)
bd517b4: disas/microblaze: Remove unused REG_PC define (Peter Maydell)
0d3ef78: trace: Avoid abuse of amdvi_mmio_read (Eric Blake)
d17e744: trace: Fix incorrect megasas trace parameters (Eric Blake)
67adf4b: trace: Fix backwards mirror_yield parameters (Eric Blake)
0832970: qom: Fix regression with 'qom-type' (Eric Blake)
c50126a: configure: Fix cut-n-paste errors in OS deprecation warning (Peter=
 Maydell)
a352aa6: target/s390x: Fix broken user mode (Stefan Weil)
b7bad50: cryptodev: fix asserting single queue (Halil Pasic)
50d19cf: cryptodev: setiv only when really need (Longpeng(Mike))
21f88d0: qapi: Fix QemuOpts visitor regression on unvisited input (Eric Bla=
ke)
9a6d1ac: qom: Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts (E=
ric Blake)
600ac6a: blockjob: add devops to blockjob backends (John Snow)
f4d9cc8: block-backend: add drained_begin / drained_end ops (John Snow)
e3796a2: blockjob: add block_job_start_shim (John Snow)
d79df2a: blockjob: avoid recursive AioContext locking (Paolo Bonzini)
f920630: hw/acpi/vmgenid: prevent more than one vmgenid device (Laszlo Erse=
k)
f2a1ae4: hw/acpi/vmgenid: prevent device realization on pre-2.5 machine typ=
es (Laszlo Ersek)
e49a661: virtio: always use handle_aio_output if registered (Paolo Bonzini)
76861f6: tests: Expose regression in QemuOpts visitor (Eric Blake)
a77690c: virtio: Fix error handling in virtio_bus_device_plugged (Fam Zheng)
5564121: numa,spapr: align default numa node memory size to 256MB (Laurent =
Vivier)
4bc0c94: test-qobject-input-visitor: Cover visit_type_uint64() (Markus Armb=
ruster)
ff5bbe5: parallels: fix default options parsing (Edgar Kaziahmedov)
658ae5a: Revert "hostmem: fix QEMU crash by 'info memdev'" (Markus Armbrust=
er)
d278822: qapi: Fix string input visitor regression for empty lists (Markus =
Armbruster)
c32617a: qapi2texi: Fix translation of *strong* and _emphasized_ (Markus Ar=
mbruster)
80d1f2e: tests/qapi-schema: Systematic positive doc comment tests (Markus A=
rmbruster)
818c331: tests/qapi-schema: Make test-qapi.py print docs again (Markus Armb=
ruster)
32b8a2a: qapi: Drop unused QAPIDoc member optional (Markus Armbruster)
e8ba07e: qapi2texi: Fix to actually fail when 'doc-required' is false (Mark=
us Armbruster)
4afeeb5: qapi: Drop excessive Make dependencies on qapi2texi.py (Markus Arm=
bruster)
e94630d: MAINTAINERS: Add myself for files I touched recently (Markus Armbr=
uster)
0ee9ae7: keyval: Document issues with 'any' and alternate types (Markus Arm=
bruster)
599c156: test-keyval: Cover alternate and 'any' type (Markus Armbruster)
fae425d: keyval: Improve some comments (Markus Armbruster)
b2cd5b9: test-keyval: Tweaks to improve list coverage (Markus Armbruster)
