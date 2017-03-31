Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctxmf-0000Je-4J
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctxma-0004Ta-Re
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:44:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35205
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ctxma-0004Sj-J5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:44:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2VEdLoF035400
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 10:44:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29hr8x2x84-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 10:44:07 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 31 Mar 2017 10:44:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri, 31 Mar 2017 09:43:57 -0500
Message-Id: <149097143799.4159.11923553673991145567@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.8.1 Stable released
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

I am pleased to announce that the QEMU v2.8.1 stable release is now
available:

  http://wiki.qemu.org/download/qemu-2.8.1.tar.xz
  http://wiki.qemu.org/download/qemu-2.8.1.tar.xz.sig

v2.8.1 is now tagged in the official qemu.git repository,
and the stable-2.8 branch has been updated accordingly:

  http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.8

This update addresses a number of CVEs relating to virtio-9p/virtfs,
cirrus VGA, and NBD, as well as a broad range of general bug fixes.
Please see the changelog for more details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

7124ccf: Update version for 2.8.1 release (Michael Roth)
08c48c7: spapr: fix off-by-one error in spapr_ovec_populate_dt() (Sam Bobro=
ff)
12110bf: seabios: update to 1.10.2 release (Gerd Hoffmann)
07672ab: qom: Fix regression with 'qom-type' (Eric Blake)
877e2b0: target/s390x: Fix broken user mode (Stefan Weil)
2f8ab9b: qapi: Fix QemuOpts visitor regression on unvisited input (Eric Bla=
ke)
c15c6d2: qom: Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts (E=
ric Blake)
dd39c54: monitor: reuse user_creatable_add_opts() instead of user_creatable=
_add() (Igor Mammedov)
879b645: tests: Expose regression in QemuOpts visitor (Eric Blake)
ce37df9: virtio: always use handle_aio_output if registered (Paolo Bonzini)
dc35a13: cirrus: fix off-by-one in cirrus_bitblt_rop_bkwd_transp_*_16 (Gerd=
 Hoffmann)
a290442: cirrus: stop passing around src pointers in the blitter (Gerd Hoff=
mann)
031700e: cirrus: stop passing around dst pointers in the blitter (Gerd Hoff=
mann)
2f51fd1: cirrus: fix cirrus_invalidate_region (Gerd Hoffmann)
63fdb09: cirrus/vnc: zap bitblit support from console code. (Gerd Hoffmann)
3328c14: fix :cirrus_vga fix OOB read case qemu Segmentation fault (hangaoh=
uai)
a99fd94: Revert "cirrus: allow zero source pitch in pattern fill rops" (Ger=
d Hoffmann)
670ddcc: cirrus: fix patterncopy checks (Gerd Hoffmann)
8db3804: cirrus: fix blit address mask handling (Gerd Hoffmann)
205a619: cirrus: allow zero source pitch in pattern fill rops (Wolfgang Bum=
iller)
5d26f91: cirrus: handle negative pitch in cirrus_invalidate_region() (Wolfg=
ang Bumiller)
1a184c3: 9pfs: don't try to flush self and avoid QEMU hang on reset (Greg K=
urz)
7f515a9: 9pfs: fix off-by-one error in PDU free list (Greg Kurz)
d437262: target-arm: Fix aarch64 vec_reg_offset (Richard Henderson)
74b13f9: target-arm: Fix aarch64 disas_ldst_single_struct (Richard Henderso=
n)
4bcb497: linux-user: Fix s390x safe-syscall for z900 (Richard Henderson)
8029d55: nbd/client: fix drop_sync [CVE-2017-2630] (Vladimir Sementsov-Ogie=
vskiy)
a3aeb9f: thread-pool: add missing qemu_bh_cancel in completion function (Pe=
ter Lieven)
34e9c09: s390x/css: reassign subchannel if schid is changed after migration=
 (Dong Jia Shi)
9e9483d: virtio-pci: reset modern vq meta data (Jason Wang)
ba9c51d: scsi: mptsas: fix the wrong reading size in fetch request (Li Qian=
g)
495756e: e1000e: correctly tear down MSI-X memory regions (Paolo Bonzini)
9ad2696: NetRxPkt: Account buffer with ETH header in IOV length (Dmitry Fle=
ytman)
15ad066: NetRxPkt: Do not try to pull more data than present (Dmitry Fleytm=
an)
7cfd9c1: NetRxPkt: Fix memory corruption on VLAN header stripping (Dmitry F=
leytman)
bddf223: eth: Extend vlan stripping functions (Dmitry Fleytman)
fc8e94c: cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2=
017-2620) (Gerd Hoffmann)
5e46417: hmp: fix block_set_io_throttle (Eric Blake)
d5506b3: qga: ignore EBUSY when freezing a filesystem (Peter Lieven)
823fb68: target-i386: correctly propagate retaddr into SVM helpers (Paolo B=
onzini)
270a46e: apic: reset apic_delivered global variable on machine reset (Pavel=
 Dovgalyuk)
f61f76c: target/sparc: Restore ldstub of odd asis (Richard Henderson)
8ac427c: block/vmdk: Fix the endian problem of buf_len and lba (QingFeng Ha=
o)
1d1d922: target-ppc, tcg: fix usermode segfault with pthread_create() (Sam =
Bobroff)
adf2c47: vnc: do not disconnect on EAGAIN (Michael Tokarev)
1a156ae: sd: sdhci: check data length during dma_memory_read (Prasad J Pand=
it)
3b8f27f: block/nfs: fix naming of runtime opts (Peter Lieven)
44d24c7: block/nfs: fix NULL pointer dereference in URI parsing (Peter Liev=
en)
5f4b901: s390x/kvm: fix small race reboot vs. cmma (Christian Borntraeger)
5e40f28: target/s390x: use "qemu" cpu model in user mode (David Hildenbrand)
d2b9063: ahci: advertise HOST_CAP_64 (Ladi Prosek)
d8dea6f: cpu-exec: fix icount out-of-bounds access (Paolo Bonzini)
f054cea: cirrus: fix oob access issue (CVE-2017-2615) (Li Qiang)
5fb07a7: s390x/kvm: fix cmma reset for KVM (Christian Borntraeger)
3fb4b3c: block/iscsi: avoid data corruption with cache=3Dwriteback (Peter L=
ieven)
a626117: virtio: fix up max size checks (Michael S. Tsirkin)
3b33cba: ui: use evdev keymap when running under wayland (Daniel P. Berrang=
e)
50b468d: tcg/aarch64: Fix tcg_out_movi (Richard Henderson)
028fbea: tcg/aarch64: Fix addsub2 for 0+C (Richard Henderson)
6e8052f: char: fix ctrl-a b not working (Marc-Andr=C3=A9 Lureau)
5c60c6e: x86: ioapic: fix fail migration when irqchip=3Dsplit (Peter Xu)
2ab8276: display: cirrus: ignore source pitch value as needed in blit_is_un=
safe (Bruce Rogers)
662a97d: exec: Add missing rcu_read_unlock (Roman Kapl)
d6f1194: virtio-crypto: fix possible integer and heap overflow (Gonglei)
f47bf08: qemu-thread: fix qemu_thread_set_name() race in qemu_thread_create=
() (Caoxinhua)
8a65625: ui/vnc: Fix problem with sending too many bytes as server name (Th=
omas Huth)
9f6cb91: scsi-block: fix direction of BYTCHK test for VERIFY commands (Paol=
o Bonzini)
dc659e3: ui/gtk: fix crash at startup when no console is available (Herv=C3=
=A9 Poussineau)
87ede19: pc: fix crash in rtc_set_memory() if initial cpu is marked as hotp=
lugged (Igor Mammedov)
da95bfe: 9pfs: fix crash when fsdev is missing (Greg Kurz)
7830be7: virtio: fix vq->inuse recalc after migr (Halil Pasic)
620a65d: pci: fix error message for express slots (Michael S. Tsirkin)
9d14f0c: balloon: Don't balloon roms (Dr. David Alan Gilbert)
04cde53: machine: Convert abstract typename on compat_props to subclass nam=
es (Eduardo Habkost)
a15785c: 9pfs: fix vulnerability in openat_dir() and local_unlinkat_common(=
) (Greg Kurz)
3731a25: 9pfs: fix O_PATH build break with older glibc versions (Greg Kurz)
7e9a1c4: 9pfs: don't use AT_EMPTY_PATH in local_set_cred_passthrough() (Gre=
g Kurz)
059f751: 9pfs: fail local_statfs() earlier (Greg Kurz)
bb07a37: 9pfs: fix fd leak in local_opendir() (Greg Kurz)
719e6dd: 9pfs: fix bogus fd check in local_remove() (Greg Kurz)
05a92c2: 9pfs: local: drop unused code (Greg Kurz)
9c5cb58: 9pfs: local: open2: don't follow symlinks (Greg Kurz)
c8c9aab: 9pfs: local: mkdir: don't follow symlinks (Greg Kurz)
5b24a96: 9pfs: local: mknod: don't follow symlinks (Greg Kurz)
9f4ba82: 9pfs: local: symlink: don't follow symlinks (Greg Kurz)
62d1dbb: 9pfs: local: chown: don't follow symlinks (Greg Kurz)
ea9e59b: 9pfs: local: chmod: don't follow symlinks (Greg Kurz)
e314b1b: 9pfs: local: link: don't follow symlinks (Greg Kurz)
d7322e1: 9pfs: local: improve error handling in link op (Greg Kurz)
d93d06a: 9pfs: local: rename: use renameat (Greg Kurz)
0f3490f: 9pfs: local: renameat: don't follow symlinks (Greg Kurz)
cfe40e1: 9pfs: local: lstat: don't follow symlinks (Greg Kurz)
3439290: 9pfs: local: readlink: don't follow symlinks (Greg Kurz)
ec10ead: 9pfs: local: truncate: don't follow symlinks (Greg Kurz)
d3c54bf: 9pfs: local: statfs: don't follow symlinks (Greg Kurz)
91225c6: 9pfs: local: utimensat: don't follow symlinks (Greg Kurz)
4286f58: 9pfs: local: remove: don't follow symlinks (Greg Kurz)
0bb9955: 9pfs: local: unlinkat: don't follow symlinks (Greg Kurz)
a9f46b8: 9pfs: local: lremovexattr: don't follow symlinks (Greg Kurz)
ed6083a: 9pfs: local: lsetxattr: don't follow symlinks (Greg Kurz)
d10142c: 9pfs: local: llistxattr: don't follow symlinks (Greg Kurz)
6c1e3a1: 9pfs: local: lgetxattr: don't follow symlinks (Greg Kurz)
acf22d2: 9pfs: local: open/opendir: don't follow symlinks (Greg Kurz)
54f951d: 9pfs: local: keep a file descriptor on the shared folder (Greg Kur=
z)
984bd0a: 9pfs: introduce relative_openat_nofollow() helper (Greg Kurz)
52d43ff: 9pfs: remove side-effects in local_open() and local_opendir() (Gre=
g Kurz)
e103f9e: 9pfs: remove side-effects in local_init() (Greg Kurz)
2c4f0f6: 9pfs: local: move xattr security ops to 9p-xattr.c (Greg Kurz)
