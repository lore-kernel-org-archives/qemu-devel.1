Received: from eggs.gnu.org ([2001:4830:134:3::10]:39141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f6MM7-0007Ex-Tk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 16:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f6MM2-0008LM-SS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 16:28:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f6MM2-0008Ko-J3
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 16:28:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3BKSIA0045723
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 16:28:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h9n6j387w-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 16:28:27 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 11 Apr 2018 16:28:25 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 15:28:06 -0500
Message-Id: <152347848670.15508.1646517335003672507@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc3 is now available
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
fourth release candidate for the QEMU 2.12 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.12.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-2.12.0-rc3.tar.xz.sig

A note from the maintainer:

  If no further release critical bugs are found, we'll do the
  final release next week on the 17th; otherwise we will likely
  roll an rc4 on the 17th and do final release on the 24th.

You can help improve the quality of the QEMU 2.12 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.12

Please add entries to the ChangeLog for the 2.12 release below:

  http://wiki.qemu.org/ChangeLog/2.12

Changes since rc2:

38e83a71d0: Update version for v2.12.0-rc3 release (Peter Maydell)
6670b494fd: hw/char/cmsdk-apb-uart.c: Correctly clear INTSTATUS bits on wri=
tes (Peter Maydell)
afd46fcad2: icount: fix cpu_restore_state_from_tb for non-tb-exit cases (Pa=
vel Dovgalyuk)
46a1ee4f39: linux-user: implement HWCAP bits on MIPS (James Cowgill)
947aeab311: linux-user: add microblaze/microblazeel magic numbers in qemu-b=
infmt-conf.sh (Laurent Vivier)
a31e7605dd: linux-user: fix microblaze get_sp_from_cpustate() (Laurent Vivi=
er)
c1de5696d6: qemu-iotests: update 185 output (Stefan Hajnoczi)
2fe4bba19b: commit/stream: Reset delay_ns (Kevin Wolf)
ad53ea42fe: qemu-iotests: Remove _supported_fmt dmg (Kevin Wolf)
e819edd090: iotests: blacklist bochs and cloop for 205 and 208 (Vladimir Se=
mentsov-Ogievskiy)
f48351d2f3: iotests.py: improve verify_image_format helper (Vladimir Sement=
sov-Ogievskiy)
07c13a7172: hw/block/pflash_cfi: fix off-by-one error (Philippe Mathieu-Dau=
d=C3=A9)
febc8c865f: iotests.py: support unsupported_fmts in main() (Vladimir Sement=
sov-Ogievskiy)
a18a73d747: Revert "migration: Don't activate block devices if using -S" (D=
r. David Alan Gilbert)
951702f39c: monitor: bind dispatch bh to iohandler context (Peter Xu)
1554434927: iothread: workaround glib bug which hangs qmp-test (Peter Xu)
c3988519c4: iotests: fix wait_until_completed() (Peter Xu)
bd49e6027c: fpu: Fix rounding mode for floatN_to_uintM_round_to_zero (Richa=
rd Henderson)
9743cd5736: tcg: Introduce tcg_set_insn_start_param (Richard Henderson)
7f0f4208b3: linux-user/signal.c: Ensure AArch64 signal frame isn't too smal=
l (Peter Maydell)
c52e7132d7: cpus.c: ensure running CPU recalculates icount deadlines on tim=
er expiry (Peter Maydell)
8aec759b45: target/arm: Report unsupported MPU region sizes more clearly (P=
eter Maydell)
f640a5914f: hw/arm/fsl-imx: Fix introspection problem with fsl-imx6 and fsl=
-imx7 (Thomas Huth)
8aabc5437b: hw/arm/allwinner-a10: Do not use nd_table in instance_init func=
tion (Thomas Huth)
f3d9fe8f95: hw/sd/bcm2835_sdhost: Don't raise spurious interrupts (Peter Ma=
ydell)
b318f3265c: hw/sd/bcm2835_sdhost: Add tracepoints (Peter Maydell)
c4869ca630: target-arm: Check undefined opcodes for SWP in A32 decoder (Onu=
r Sahin)
8720daad47: hw/arm/integratorcp: Don't do things that could be fatal in the=
 instance_init (Thomas Huth)
c39770cd63: hw/arm: Allow manually specified /psci node (Andrey Smirnov)
c6093a05d6: configure: don't warn SDL abi if disabled (Peter Xu)
5a464e6ce8: configure: don't warn GTK if disabled (Peter Xu)
fa2d039b2c: gtk: drop pointless code from gd_window_close (Gerd Hoffmann)
1e70de679d: ui: fix keymap detection under Xwayland (Daniel P. Berrang=C3=
=A9)
5f52353091: e1000: Old machine types, turn new subsection off (Dr. David Al=
an Gilbert)
ff214d427e: e1000: Choose which set of props to migrate (Dr. David Alan Gil=
bert)
5935448478: e1000: Migrate props via a temporary structure (Dr. David Alan =
Gilbert)
46f2a9ec54: e1000: wire new subsection to property (Dr. David Alan Gilbert)
3c4053c52c: e1000: Dupe offload data on reading old stream (Dr. David Alan =
Gilbert)
4ae4bf5bb1: e1000: Convert v3 fields to subsection (Dr. David Alan Gilbert)
9ac225171c: linux-user: fix preadv/pwritev offsets (Max Filippov)
6b3913e085: roms/u-boot-sam460ex: Change to qemu git mirror and update (BAL=
ATON Zoltan)
f8815532dc: sam460ex: Fix timer frequency and clock multipliers (BALATON Zo=
ltan)
99b336cdd9: tests/boot-serial: Test the sam460ex board (Thomas Huth)
127f03e442: spapr: Initialize reserved areas list in FDT in H_CAS handler (=
Alexey Kardashevskiy)
efb7db250a: target/ppc: Fix backwards migration of msr_mask (David Gibson)
ddd835f32a: hw/misc/macio: Fix crash when listing device properties of maci=
o device (Thomas Huth)
e69ba2b489: target/ppc: Initialize lazy_tlb_flush correctly (David Gibson)
e0014d4b3a: Add missing bit for SSE instr in VEX decoding (Eugene Minibaev)
3bd2608db7: maint: Add .mailmap entries for patches claiming list authorshi=
p (Eric Blake)
84c868f6b8: dump: Fix build with newer gcc (Eric Blake)
01366ef9a4: device-crash-test: Remove fixed isa-fdc entry (Thomas Huth)
bd6b1c8324: qemu-pr-helper: Write pidfile more often (Michal Privoznik)
8dc0bf2647: qemu-pr-helper: Daemonize before dropping privileges (Michal Pr=
ivoznik)
9f91022f28: virtio-serial: fix heapover-flow (linzhecheng)
c2b01cfec1: kvmclock: fix clock_is_reliable on migration from QEMU < 2.9 (M=
ichael Chapman)
4968a2c6ed: hw/dma/i82374: Avoid double creation of the 82374 controller (P=
hilippe Mathieu-Daud=C3=A9)
29e560f00e: hw/scsi: support SCSI-2 passthrough without PI (Daniel Henrique=
 Barboza)
2343be0d7e: scsi-disk: allow customizing the SCSI version (Paolo Bonzini)
37c5174189: scsi-disk: Don't enlarge min_io_size to max_io_size (Fam Zheng)
db1b5f135c: configure: Add missing configure options to help text (Thomas H=
uth)
1221f15041: i386/hyperv: error out if features requested but unsupported (R=
oman Kagan)
9445597b6a: i386/hyperv: add hv-frequencies cpu property (Roman Kagan)
7becac84fb: target/i386: WHPX: set CPUID_EXT_HYPERVISOR bit (Justin Terry (=
VM))
d434e5ac5d: virtio-serial: fix heap-over-flow (linzhecheng)
e7b94a84b6: vhost: Allow adjoining regions (Dr. David Alan Gilbert)
ea3e6f5a93: contrib/libvhost-user: add the protocol feature used for SET/GE=
T message (Changpeng Liu)
1c3e5a2617: vhost-user: back SET/GET_CONFIG requests with a protocol featur=
e (Maxime Coquelin)
bc6abcff7c: vhost-user-blk: set config ops before vhost-user init (Maxime C=
oquelin)
9005774b27: gdbstub: fix off-by-one in gdb_handle_packet() (Philippe Mathie=
u-Daud=C3=A9)
b3a184f51f: s390x: load_psw() should only exchange the PSW for KVM (David H=
ildenbrand)
61a17fea6d: s390x/mmu: don't overwrite pending exception in mmu translate (=
David Hildenbrand)
be4d026f64: vfio-ccw: fix memory leaks in vfio_ccw_realize() (Greg Kurz)
c607bb8f8a: pc-bios/s390: update images (Cornelia Huck)
e8c7ef288a: s390: Do not pass inofficial IPL type to the guest (Viktor Miha=
jlovski)
789b5a401b: s390: Ensure IPL from SCSI works as expected (Viktor Mihajlovsk=
i)
11ef6d50fc: s390: Refactor IPL parameter block generation (Viktor Mihajlovs=
ki)
eac53ac598: s390x/kvm: call cpu_synchronize_state() on every kvm_arch_handl=
e_exit() (David Hildenbrand)
648abbfbaa: memfd: fix vhost-user-test on non-memfd capable host (Marc-Andr=
=C3=A9 Lureau)
1458da9131: sdl2: drop dead code (Gerd Hoffmann)
e7824db158: sdl2: drop QEMU_KEY_BACKSPACE special case (Gerd Hoffmann)
3dd2ca54fb: sdl2: enable ctrl modifier keys for text consoles (Gerd Hoffman=
n)
34013c3793: sdl2: track kbd modifier state unconditionally (Gerd Hoffmann)
da024b1ed2: ui: add ctrl modifier support to kbd_put_qcode_console() (Gerd =
Hoffmann)
07fed47417: docker: fedora: test more components (Paolo Bonzini)
185809224a: docker: Inline "prep_fail" in run script (Fam Zheng)
726c9a3b8c: tests: Fix ubuntu.i386 image initialization (Fam Zheng)
0c153b4c6f: docker: dump 'config.log' if ./configure fails (Philippe Mathie=
u-Daud=C3=A9)
5aa4860082: Update seabios-hppa (Richard Henderson)
6cb1d3b851: tcg: Fix out-of-line generic vector compares (Richard Henderson)
057ad0b469: crypto: ensure we use a predictable TLS priority setting (Danie=
l P. Berrang=C3=A9)
00e5e9df29: docs: Document -object tls-creds-x509 priority=3Dxxx (Christoph=
e Fergeau)
5d19a6eae9: docs: update information for TLS certificate management (Daniel=
 P. Berrange)
5c08600547: vfio: Use a trace point when a RAM section cannot be DMA mapped=
 (Eric Auger)
053e45d2f3: scripts/checkpatch.pl: Bug fix (Su Hang)
5cd10051c2: target/i386: Fix andn instruction (Alexandro Sanchez Bach)
d69748463c: sys_membarrier: fix up include directives (Bruce Rogers)
991f366b2f: sdl2: Remove unused epoxy include (Elie Tournier)
