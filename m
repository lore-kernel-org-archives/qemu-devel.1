Received: from eggs.gnu.org ([2001:4830:134:3::10]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gSC72-0002TD-6g
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gSC6x-0005fK-T8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:31:32 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gSC6x-0005Tu-Gw
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:31:27 -0500
Received: by mail-oi1-x242.google.com with SMTP id h25so369700oig.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 18:31:24 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <154345867529.31899.2146042300046355270@sif>
Date: Wed, 28 Nov 2018 20:31:15 -0600
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0-rc3 is now available
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
fourth release candidate for the QEMU 3.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.1.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-3.1.0-rc3.tar.xz.sig

A note from the maintainer:

  If no remaining critical issues crop up, we'll release 3.1.0 next week
  with no further changes; otherwise we'll do an rc4 and release after
  that.

You can help improve the quality of the QEMU 3.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.1

Please add entries to the ChangeLog for the 3.1 release below:

  http://wiki.qemu.org/ChangeLog/3.1

Thank you to everyone involved!

Changes since rc2:

4750e1a888: Update version for v3.1.0-rc3 release (Peter Maydell)
3f2f3b33db: target/arm/sve_helper: Fix compilation with clang 3.4 (Thomas H=
uth)
ea066d39ac: hw/arm/aspeed: Fix build issue with clang 3.4 (Thomas Huth)
86100290cb: hostmem: no need to check for host_memory_backend_mr_inited() i=
n alloc() (Marc-Andr=C3=A9 Lureau)
039d4e3df0: scsi: Address spurious clang warning (John Snow)
549b50a31d: vfio-helpers: Fix qemu_vfio_open_pci() crash (Markus Armbruster)
36ea397956: hostmem-memfd: honour share=3Don/off property (Marc-Andr=C3=A9 =
Lureau)
15ffb43cbf: MAINTAINERS: Add an entry for the Firmware Configuration (fw_cf=
g) device (Philippe Mathieu-Daud=C3=A9)
9681ad3e2b: MAINTAINERS: Add some missing entries related to accelerators (=
Thomas Huth)
e84fcd7f66: target/i386: Generate #UD when applying LOCK to a register dest=
ination (Richard Henderson)
f1e35acf78: checkpatch: g_test_message does not need a trailing newline (Pa=
olo Bonzini)
d4c7e7e7e0: vl.c: remove outdated comment (Li Qiang)
8f1d22d970: vhost-user-bridge: fix recvmsg iovlen (Marc-Andr=C3=A9 Lureau)
353c7d58b9: vl: Improve error message when we can't load fw_cfg from file (=
Li Qiang)
03fee66fde: vmstate: constify VMStateField (Marc-Andr=C3=A9 Lureau)
5aaac46793: migration: savevm: consult migration blockers (Paolo Bonzini)
56333e69ee: lsi: Reselection needed to remove pending commands from queue (=
George Kennedy)
a8efa60633: cpus: run work items for all vCPUs if single-threaded (Paolo Bo=
nzini)
d98f26073b: target/i386: kvm: add VMX migration blocker (Paolo Bonzini)
2264faa55f: hw/virt/arm: Add support for Cortex-A72 in virt (ZhiPeng Lu)
6da021815e: nvme: Fix spurious interrupts (Keith Busch)
330ca111ea: iotests: Test migration with -blockdev (Kevin Wolf)
9e37271f50: block: Don't inactivate children before parents (Kevin Wolf)
e1ca8f7e19: qapi: add query-display-options command (Gerd Hoffmann)
933d2d4bf2: usb-host: set ifs.detached as true if kernel driver is not acti=
ve (linzhecheng)
7ec9106759: audio/hda: fix guest triggerable assert (Gerd Hoffmann)
b7ee9e4970: cirrus_vga/migration: update the bank offset before use (Wang X=
in)
d2e550a828: ps2kbd: default to scan enabled after reset (Herv=C3=A9 Poussin=
eau)
30a759b61a: hw/hyperv: fix NULL dereference with pure-kvm SynIC (Roman Kaga=
n)
aec5e9c3a9: kvm: Use KVM_GET_MSR_INDEX_LIST for MSR_IA32_ARCH_CAPABILITIES =
support (Bandan Das)
58102ce7fb: net: cadence_gem: Remove incorrect assert() (Edgar E. Iglesias)
49154ea0bf: MAINTAINERS: Add an ARM SMMU section (Eric Auger)
123a069ae6: MAINTAINERS: Assign some more files in the hw/arm/ directory (T=
homas Huth)
57ac4a7a28: fmops: fix off-by-one in AR_TABLE and DR_TABLE array size (Gerd=
 Hoffmann)
1d20398694: 9p: fix QEMU crash when renaming files (Greg Kurz)
895e4897e2: MAINTAINERS: add missing xtensa patterns (Max Filippov)
6bd858b311: block: Update BlockDriverState.inherits_from on bdrv_drop_inter=
mediate() (Alberto Garcia)
0065c455f9: block: Update BlockDriverState.inherits_from on bdrv_set_backin=
g_hd() (Alberto Garcia)
a237dea330: iotests: Enhance 223 to cover multiple bitmap granularities (Er=
ic Blake)
ad3a7e4555: nvme: fix bug with PCI IRQ pins on teardown (Logan Gunthorpe)
71a86ddece: nvme: fix CMB endianness confusion (Paolo Bonzini)
2067d39e5e: Revert "nvme: fix oob access issue(CVE-2018-16847)" (Kevin Wolf)
87ad860c62: nvme: fix out-of-bounds access to the CMB (Paolo Bonzini)
6bf7463615: nvme: call blk_drain in NVMe reset code to avoid lockups (Igor =
Druzhinin)
e4c8f2925d: iotests: fix nbd test 233 to work correctly with raw images (Da=
niel P. Berrang=C3=A9)
2a3d4331fa: block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_op=
tions() (Alberto Garcia)
1c7f618f68: scsi-disk: Fix crash if underlying host file or disk returns er=
ror (Richard W.M. Jones)
59b5e9bbea: target/xtensa: xtfpga: provide default memory sizes (Max Filipp=
ov)
3ecd5a4f19: qemu-img: Fix leak (Max Reitz)
f0998879e0: qemu-img: Fix typo (Max Reitz)
155af09d44: iotests: Skip 233 if certtool not installed (Eric Blake)
7e934f5b27: migration/migration.c: Add COLO dependency checks (Zhang Chen)
3ebb9c4f52: migration/colo.c: Fix compilation issue when disable replicatio=
n (Zhang Chen)
fa1cfb4026: iotests: Replace assertEquals() with assertEqual() (Kevin Wolf)
d8336c6b28: iotests: Replace time.clock() with Timeout (Kevin Wolf)
7da9111e77: target/xtensa: drop num_[core_]regs from dc232b/dc233c configs =
(Max Filippov)
4614f0f8bd: target/xtensa: gdbstub fix register counting (Max Filippov)
