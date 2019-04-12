Received: from eggs.gnu.org ([209.51.188.92]:48355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hEx8k-0000FC-UA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hEx8j-00065Z-2d
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:26:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37202
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hEx8i-000564-S4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:26:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3CEPXqs018631
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 10:25:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rtu4wc6vu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 10:25:33 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 12 Apr 2019 15:25:14 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri, 12 Apr 2019 09:24:58 -0500
Message-Id: <155507909853.1979.17826210808794518502@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.0.1 Stable released
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

I am pleased to announce that the QEMU v3.0.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v3.0.1 is now tagged in the official qemu.git repository,
and the stable-3.0 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-3.0

This update contains bug/security fixes for a number of areas, and the
following CVE fixes:

  CVE-2018-17963 (networking)
  CVE-2019-6778  (usermode networking)
  CVE-2018-18954 (PowerNV emulation)
  CVE-2018-18849 (LSI SCSI emulation)
  CVE-2018-15746 (seccomp)
  CVE-2018-16872 (usb-mtp)
  CVE-2018-16867 (usb-mtp)
  CVE-2018-19489 (virtio-9p/virtfs)
  CVE-2018-16847 (nvme emulation)

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

1dfcf652e6: Update version for 3.0.1 release (Michael Roth)
a4a5021413: vhost-user: Fix userfaultfd leak (Ilya Maximets)
a0380bdae9: vhost-user: Don't ask for reply on postcopy mem table set (Ilya=
 Maximets)
8d25276172: ppc/pnv: check size before data buffer access (Prasad J Pandit)
345fab6ffe: slirp: check data length while emulating ident function (Prasad=
 J Pandit)
bd6dd4eaa6: lsi53c895a: check message length value is valid (Prasad J Pandi=
t)
f43a6b314a: seccomp: set the seccomp filter to all threads (Marc-Andr=C3=A9=
 Lureau)
9d01327689: configure: require libseccomp 2.2.0 (Marc-Andr=C3=A9 Lureau)
9ad3314fa3: seccomp: prefer SCMP_ACT_KILL_PROCESS if available (Marc-Andr=
=C3=A9 Lureau)
8eba63e1d2: seccomp: use SIGSYS signal instead of killing the thread (Marc-=
Andr=C3=A9 Lureau)
7347a04da3: usb-mtp: use O_NOFOLLOW and O_CLOEXEC. (Gerd Hoffmann)
61f87388af: usb-mtp: outlaw slashes in filenames (Gerd Hoffmann)
d086829e5b: 9p: fix QEMU crash when renaming files (Greg Kurz)
e49f868dc0: nvme: fix out-of-bounds access to the CMB (Paolo Bonzini)
2c4f6cabf5: qga: update docs with systemd suspend support info (Daniel Henr=
ique Barboza)
5d64550dc5: bitmap: Update count after a merge (Eric Blake)
7b8e8ff009: tpm_tis: fix loop that cancels any seizure by a lower locality =
(Liam Merwick)
690bb48e40: slirp: check sscanf result when emulating ident (William Bowlin=
g)
f3200c4c20: hw/rdma: another clang compilation fix (Marcel Apfelbaum)
2251d74275: acpi: Make TPM 2.0 with TIS available as MSFT0101 (Stefan Berge=
r)
9f9a3548d3: block: Fix invalidate_cache error path for parent activation (K=
evin Wolf)
4afb0370b9: tpm: Make sure the locality received from backend is valid (Ste=
fan Berger)
66160b7aeb: tpm: Make sure new locality passed to tpm_tis_prep_abort() is v=
alid (Stefan Berger)
3fd92155fd: tpm: use loop iterator to set sts data field (Prasad J Pandit)
69ec5ee5ac: tpm: Zero-init structure to avoid uninitialized variables in va=
lgrind log (Stefan Berger)
16d1300e1a: exec.c: Don't reallocate IOMMUNotifiers that are in use (Peter =
Maydell)
1c9b86daec: s390x: Return specification exception for unimplemented diag 30=
8 subcodes (Janosch Frank)
422bf25df1: linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0=
 (Peter Maydell)
89d2237683: linux-user: write(fd, NULL, 0) parity with linux's treatment of=
 same (Tony Garnock-Jones)
1f79226d22: hw/s390x: Fix bad mask in time2tod() (Thomas Huth)
02db60391f: pc:piix4: Update smbus I/O space after a migration (Corey Minya=
rd)
9d61beac23: pcie: set link state inactive/active after hot unplug/plug (Zhe=
ng Xiang)
2ce4635d9b: Changes requirement for "vsubsbs" instruction (Paul A. Clarke)
fc50e1fa79: iotests: make 235 work on s390 (and others) (Christian Borntrae=
ger)
e47e19ed21: iotests: simple mirror test with kvm on 1G image (Vladimir Seme=
ntsov-Ogievskiy)
d02d6dd710: mirror: fix dead-lock (Vladimir Sementsov-Ogievskiy)
32e0caf8ff: nbd/client: Send NBD_CMD_DISC if open fails after connect (Eric=
 Blake)
38490efee0: nbd/client: Make x-dirty-bitmap more reliable (Eric Blake)
e13f56a154: nbd/server: Advertise all contexts in response to bare LIST (Er=
ic Blake)
a69e9049d6: i2c: Add a length check to the SMBus write handling (Corey Miny=
ard)
22acdb9937: i2c: Move typedef of bitbang_i2c_interface to i2c.h (BALATON Zo=
ltan)
93ef995b2c: vfio-helpers: Fix qemu_vfio_open_pci() crash (Markus Armbruster)
e31de8e7bb: fmops: fix off-by-one in AR_TABLE and DR_TABLE array size (Gerd=
 Hoffmann)
c192d40267: qemu-img: Fix leak (Max Reitz)
a36defa3c8: qemu-img: Fix typo (Max Reitz)
81e38ad8d0: fdc: fix segfault in fdctrl_stop_transfer() when DMA is disable=
d (Mark Cave-Ayland)
b528bb2840: net: drop too large packet early (Jason Wang)
53a69e7ee4: make-release: add skiboot .version file (Michael Roth)
ca1b4263d9: vhost-scsi: prevent using uninitialized vqs (yuchenlin)
ef862b9e8e: migration: Stop postcopy fault thread before notifying (Ilya Ma=
ximets)
bbe21c6d30: nbd: fix NBD_FLAG_SEND_CACHE value (Denis V. Lunev)
b7fce72779: intel_iommu: better handling of dmar state switch (Peter Xu)
0a818f87f7: intel_iommu: introduce vtd_reset_caches() (Peter Xu)
92c7eec109: nbd/server: fix NBD_CMD_CACHE (Vladimir Sementsov-Ogievskiy)
6abeb6d85e: target/arm: Correct condition for v8M callee stack push (Peter =
Maydell)
399814e1a1: block-backend: Set werror/rerror defaults in blk_new() (Kevin W=
olf)
ce2c15fdaf: virtio: do not take address of packed members (Paolo Bonzini)
15f40e2e63: virt: Suppress external aborts on virt-2.10 and earlier (Peter =
Maydell)
901d84e675: net: ignore packet size greater than INT_MAX (Jason Wang)
9d9430b75f: pcnet: fix possible buffer overflow (Jason Wang)
b3f1083edb: rtl8139: fix possible out of bound access (Jason Wang)
9971a3fb90: ne2000: fix possible out of bound access in ne2000_receive (Jas=
on Wang)
b05db67c98: target/arm: Fix cpu_get_tb_cpu_state() for non-SVE CPUs (Richar=
d Henderson)
e9d87aa766: block/rbd: add deprecation documentation for filename keyvalue =
pairs (Jeff Cody)
5b2f6925e0: block/rbd: add iotest for rbd legacy keyvalue filename parsing =
(Jeff Cody)
0bc2dc7357: block/rbd: Attempt to parse legacy filenames (Jeff Cody)
22e766bcf3: block/rbd: pull out qemu_rbd_convert_options (Jeff Cody)
481be11cba: clean up callback when del virtqueue (liujunjie)
a8b436c88d: nbd/server: fix bitmap export (Vladimir Sementsov-Ogievskiy)
ccdd67c8d9: target/xtensa: fix s32c1i TCGMemOp flags (Max Filippov)
ef6de9e720: job: Fix nested aio_poll() hanging in job_txn_apply (Fam Zheng)
9e25063bb0: block: Fix use after free error in bdrv_open_inherit() (Alberto=
 Garcia)
84cabd6c6c: tests: update acpi expected files (Michael S. Tsirkin)
f8d4616e62: pc: acpi: revert back to 1 SRAT entry for hotpluggable area (Ig=
or Mammedov)
bda7545118: vhost: fix invalid downcast (Yury Kotov)
70b8acfa0d: slirp: Add sanity check for str option length (Fam Zheng)
2f5c767a82: kvm: add call to qemu_add_opts() for -overcommit option (Prasad=
 Singamsetty)
32a51d0704: target/xtensa: fix FPU2000 bugs (Max Filippov)
a40e71884d: virtio: update MemoryRegionCaches when guest negotiates feature=
s (Paolo Bonzini)
457b0e4761: block: iotest to catch abort on forced blockjob cancel (Jeff Co=
dy)
def983b923: block: for jobs, do not clear user_paused until after the resum=
e (Jeff Cody)
3dceceec72: i386: Disable TOPOEXT by default on "-cpu host" (Eduardo Habkos=
t)
9431827af9: vnc: fix memleak of the "vnc-worker-output" name (Peter Wu)
d1c384fabc: monitor: fix oob command leak (Marc-Andr=C3=A9 Lureau)
8f0e1478d0: aio: Do aio_notify_accept only during blocking aio_poll (Fam Zh=
eng)
98f6f21261: aio-posix: Don't count ctx->notifier as progress when polling (=
Fam Zheng)
ac141891ee: nvme: Fix nvme_init error handling (Fam Zheng)
4b4201206c: qemu-img: fix regression copying secrets during convert (Daniel=
 P. Berrang=C3=A9)
1662d4d490: mirror: Fail gracefully for source =3D=3D target (Kevin Wolf)
c89985bad9: block/qapi: Fix memory leak in qmp_query_blockstats() (Kevin Wo=
lf)
fb661dac05: target/arm: Use FZ not FZ16 for SVE FCVT single-half and double=
-half (Richard Henderson)
aff596dcf4: target/arm: Use fp_status_fp16 for do_fmpa_zpzzz_h (Richard Hen=
derson)
a606615e2f: target/arm: Ignore float_flag_input_denormal from fp_status_f16=
 (Richard Henderson)
fbec38531c: target/arm: Adjust FPCR_MASK for FZ16 (Richard Henderson)
b7f525bf89: spapr_cpu_core: vmstate_[un]register per-CPU data from (un)real=
izefn (Bharata B Rao)
5a49083b1e: target/arm: Add sve-max-vq cpu property to -cpu max (Richard He=
nderson)
192686a800: target/arm: Dump SVE state if enabled (Richard Henderson)
965307a713: target/arm: Reformat integer register dump (Richard Henderson)
3d95093fa7: target/arm: Fix offset scaling for LD_zprr and ST_zprr (Richard=
 Henderson)
e97358cae4: target/arm: Fix offset for LD1R instructions (Richard Henderson)
ca276173c9: target/arm: Fix sign-extension in sve do_ldr/do_str (Richard He=
nderson)
471b5ae011: target/arm: Fix typo in helper_sve_ld1hss_r (Richard Henderson)
d1d2721876: target/arm: Fix typo in helper_sve_movz_d (Richard Henderson)
bfc23fb2f0: target/arm: Reorganize SVE WHILE (Richard Henderson)
f7ddde210a: target/arm: Fix typo in do_sat_addsub_64 (Richard Henderson)
58c4b085ee: target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw (Richard =
Henderson)
