Received: from eggs.gnu.org ([2001:4830:134:3::10]:46278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dq2V8-0002qm-3p
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dq2V0-0000lQ-KH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:30:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dq2V0-0000kV-F5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:30:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87JSpS7020626
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 15:30:01 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cu89pn78r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:30:00 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 13:30:00 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 07 Sep 2017 14:29:53 -0500
Message-Id: <150481259362.14429.2420800534920948443@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.1 Stable released
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

I am pleased to announce that the QEMU v2.9.1 stable release is now
available:

  http://wiki.qemu.org/download/qemu-2.9.1.tar.xz
  http://wiki.qemu.org/download/qemu-2.9.1.tar.xz.sig

v2.9.1 is now tagged in the official qemu.git repository,
and the stable-2.9 branch has been updated accordingly:

  http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.9

This update contains security fixes addressing a possible guest
privilege escalation when using virtfs/9pfs (CVE-2017-7493) and
hardening against possible guest-induced host memory exhaustion
via audio/input emulation (CVE-2017-8309 / CVE-2017-8379).
There's also a pretty broad range of general fixes. Please see
the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

4cd4265: Update version for 2.9.1 release (Michael Roth)
c24c591: virtfs: error out gracefully when mandatory suboptions are missing=
 (Greg Kurz)
2d1bbf5: target/arm: Fix aa64 ldp register writeback (Richard Henderson)
30b76b2: exec: Add lock parameter to qemu_ram_ptr_length (Anthony PERARD)
2f64063: xen/mapcache: store dma information in revmapcache entries for deb=
ugging (Stefano Stabellini)
15d8f91: exec: use qemu_ram_ptr_length to access guest ram (Prasad J Pandit)
f9c313f: xhci: only update dequeue ptr on completed transfers (Gerd Hoffman=
n)
5320675: vl.c/exit: pause cpus before closing block devices (Dr. David Alan=
 Gilbert)
167e764: PPC: E500: update u-boot to match shipped binary (Michael Roth)
e22e199: s390-ccw: Fix alignment for CCW1 (Farhan Ali)
5035184: vnc: Set default kbd delay to 10ms (Alexander Graf)
20920f4: qemu-nbd: Ignore SIGPIPE (Max Reitz)
4e6889b: usb-redir: fix stack overflow in usbredir_log_data (Gerd Hoffmann)
244a3ef: megasas: do not read SCSI req parameters more than once from frame=
 (Paolo Bonzini)
578fb50: megasas: do not read command more than once from frame (Paolo Bonz=
ini)
50b9353: megasas: do not read DCMD opcode more than once from frame (Paolo =
Bonzini)
d016071: megasas: do not read iovec count more than once from frame (Paolo =
Bonzini)
20fd62d: megasas: do not read sense length more than once from frame (Paolo=
 Bonzini)
7442018: 9pfs: local: forbid client access to metadata (CVE-2017-7493) (Gre=
g Kurz)
0f590e79: scsi: avoid an off-by-one error in megasas_mmio_write (Prasad J P=
andit)
3c69132: audio: release capture buffers (Gerd Hoffmann)
40a7d47: vmw_pvscsi: check message ring page count at initialisation (P J P)
9b9b442: hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" =
device (Thomas Huth)
980e826: hw/ppc/spapr_rtc: Mark the RTC device with user_creatable =3D fals=
e (Thomas Huth)
aab0023: qdev: Replace cannot_instantiate_with_device_add_yet with !user_cr=
eatable (Eduardo Habkost)
cfc65be: fix qemu-system-unicore32 crashing when calling without -kernel (E=
duardo Otubo)
ac0038f: hw/s390x/ipl: Fix crash with virtio-scsi-pci device (Thomas Huth)
62708c7: slirp: fix clearing ifq_so from pending packets (Samuel Thibault)
746e1fd: slirp: tftp, copy sockaddr_size (Marc-Andr=C3=A9 Lureau)
e8679f5: monitor: Check whether TCG is enabled before running the "info jit=
" code (Thomas Huth)
c152efc: target-s390x: Mask the SIGP order_code to 8bit. (Philipp Kern)
077a67e: 9pfs: local: fix fchmodat_nofollow() limitations (Greg Kurz)
f4f3529: block/nfs: fix mutex assertion in nfs_file_close() (Jeff Cody)
5f7f7e4: hw/i386: allow SHPC for Q35 machine (Aleksandr Bezzubikov)
de9b672: cpu: don't allow negative core id (Laurent Vivier)
a0ddbcf: block: Skip implicit nodes in query-block/blockstats (Kevin Wolf)
d445e0a: qemu-iotests: Test automatic commit job cancel on hot unplug (Kevi=
n Wolf)
ad480ab: input: Decrement queue count on kbd delay (Alexander Graf)
f8d050a: input: limit kbd queue depth (Gerd Hoffmann)
9527514: virtio-net: fix offload ctrl endian (Jason Wang)
2a7526b: spapr: fix memory leak in spapr_core_pre_plug() (Greg Kurz)
2e40aad: commit: Add NULL check for overlay_bs (Kevin Wolf)
70da03f: virtio-scsi: finalize IOMMU support (Jason Wang)
19284a0: spapr: fix migration to pseries machine < 2.8 (Laurent Vivier)
0060a3e: hid: Reset kbd modifiers on reset (Alexander Graf)
e0398cc: 9pfs: local: remove: use correct path component (Bruce Rogers)
438cd1e: block: Do not strcmp() with NULL uri->scheme (Max Reitz)
40ed5cd: nbd: fix NBD over TLS (Paolo Bonzini)
2182791: blkverify: Catch bs->exact_filename overflow (Max Reitz)
1828d47: blkdebug: Catch bs->exact_filename overflow (Max Reitz)
1dd3ba3: commit: Fix completion with extra reference (Kevin Wolf)
ecc7a24: nbd: Fix regression on resiliency to port scan (Eric Blake)
ec49c8a: nbd: Fully initialize client in case of failed negotiation (Eric B=
lake)
f28b890: commit: Fix use after free in completion (Kevin Wolf)
bace1f9: target/xtensa: handle unknown registers in gdbstub (Max Filippov)
3b2f3a4: spapr: fix memory leak in spapr_memory_pre_plug() (Greg Kurz)
7f4c9f5: spapr: add pre_plug function for memory (Laurent Vivier)
592ee40: target/ppc: fix memory leak in kvmppc_is_mem_backend_page_size_ok(=
) (Greg Kurz)
917a5b9: target/ppc: pass const string to kvmppc_is_mem_backend_page_size_o=
k() (Greg Kurz)
2401d8a: pc: Use "min-[x]level" on compat_props (Eduardo Habkost)
1775fe6: monitor: fix object_del for command-line-created objects (Michael =
Roth)
b0a3ead: tests: check-qom-proplist: add checks for cmdline-created objects =
(Michael Roth)
3b428e9: linuxboot_dma: compile for i486 (Paolo Bonzini)
11bac2f: virtio-serial-bus: Unset hotplug handler when unrealize (Ladi Pros=
ek)
0ebbef1: mirror: Drop permissions on s->target on completion (Kevin Wolf)
64945cb: block: Guarantee that *file is set on bdrv_get_block_status() (Eri=
c Blake)
6a3f9c5: block: Simplify BDRV_BLOCK_RAW recursion (Eric Blake)
3f3fe28: tests: Add coverage for recent block geometry fixes (Eric Blake)
48f2dc0: blkdebug: Add ability to override unmap geometries (Eric Blake)
3ae7400: blkdebug: Simplify override logic (Eric Blake)
577cf9e: blkdebug: Add pass-through write_zero and discard support (Eric Bl=
ake)
138cf63: blkdebug: Refactor error injection (Eric Blake)
a1a3d60: blkdebug: Sanity check block layer guarantees (Eric Blake)
0b18554: virtio-net: fix wild pointer when remove virtio-net queues (Yunjia=
n Wang)
f367637: s390x/css: catch section mismatch on load (Halil Pasic)
4921c57: e1000e: Fix ICR "Other" causes clear logic (Sameeh Jubran)
952cc38: virtio-scsi: Unset hotplug handler when unrealize (Fam Zheng)
c6b510d: virtio: allow broken device to notify guest (Greg Kurz)
636eacb: vvfat: fix qemu-img map and qemu-img convert (Herv=C3=A9 Poussinea=
u)
c60a8ed: stream: fix crash in stream_start() when block_job_create() fails =
(Alberto Garcia)
c79bef6: curl: avoid recursive locking of BDRVCURLState mutex (Paolo Bonzin=
i)
4b519b9: curl: never invoke callbacks with s->mutex held (Paolo Bonzini)
f00c08c: curl: strengthen assertion in curl_clean_state (Paolo Bonzini)
d81db0b: target/xtensa: fix return value of read/write simcalls (Max Filipp=
ov)
e442253: target/xtensa: fix mapping direction in read/write simcalls (Max F=
ilippov)
af8ca55: blockdev: use drained_begin/end for qmp_block_resize (John Snow)
5797a36: block: Add errp to b{lk,drv}_truncate() (Max Reitz)
73aa7ad: block/vhdx: Make vhdx_create() always set errp (Max Reitz)
d8cddcc: qemu-img: wait for convert coroutines to complete (Anton Nefedov)
ce11924: aio: add missing aio_notify() to aio_enable_external() (Stefan Haj=
noczi)
0e727a2: hw/virtio: fix vhost user fails to startup when MQ (Zhiyong Yang)
d2fcb92: block: Reuse bs as backing hd for drive-backup sync=3Dnone (Fam Zh=
eng)
e59084b: qobject: Use simpler QDict/QList scalar insertion macros (Eric Bla=
ke)
1eaf431: s390x: Drop useless casts (Eric Blake)
396474a: qobject: Add helper macros for common scalar insertions (Eric Blak=
e)
3f308bf: qobject: Drop useless QObject casts (Eric Blake)
2104724: coccinelle: Add script to remove useless QObject casts (Eric Blake)
785d9ab: 9pfs: local: fix unlink of alien files in mapped-file mode (Greg K=
urz)
45b3eac: replication: Make --disable-replication compile again (Markus Armb=
ruster)
c64d184: ACPI: don't call acpi_pcihp_device_plug_cb on xen (Bruce Rogers)
c1059a3: block: Do not unref bs->file on error in BD's open (Max Reitz)
0b906e4: pci: deassert intx when pci device unrealize (Herongguang (Stephen=
))
181e005: migration: setup bi-directional I/O channel for exec: protocol (Da=
niel P. Berrange)
b8420f7: iotests/051: Add test for empty filename (Max Reitz)
bd1039b: block: An empty filename counts as no filename (Max Reitz)
bc70597: qemu-img/convert: Move bs_n > 1 && -B check down (Max Reitz)
a1c850f: qemu-img/convert: Use @opts for one thing only (Max Reitz)
c37a62b: qemu-img/convert: Always set ret < 0 on error (Max Reitz)
4aa16db: dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented =
(Eric Blake)
27dd31f: qga-win: Enable 'can-offline' field in 'guest-get-vcpus' reply (Sa=
meeh Jubran)
