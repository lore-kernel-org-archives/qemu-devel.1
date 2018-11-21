Received: from eggs.gnu.org ([2001:4830:134:3::10]:56087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gPUZy-0000Qh-II
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gPUZv-0001dl-8a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:38:14 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gPUZv-0001b2-31
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:38:11 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so5293722otk.8
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 07:38:10 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <154281467407.7171.7221037041514336978@sif>
Date: Wed, 21 Nov 2018 09:37:54 -0600
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0-rc2 is now available
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
third release candidate for the QEMU 3.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.1.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-3.1.0-rc2.tar.xz.sig

A note from the maintainer:

  Some known issues that seem worth flagging up as not-yet-fixed:
   * QEMU crashes at startup on older AMD systems with
     "error: failed to set MSR 0x10a to 0x0"
   * QEMU does not work on the new OSX "Mojave" release

You can help improve the quality of the QEMU 3.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.1

Please add entries to the ChangeLog for the 3.1 release below:

  http://wiki.qemu.org/ChangeLog/3.1

Thank you to everyone involved!

Changes since rc1:

47c1cc30e4: Update version for v3.1.0-rc2 release (Peter Maydell)
4a93722f9c: hw/i386: add pc-i440fx-3.1 & pc-q35-3.1 (Marc-Andr=C3=A9 Lureau)
5b3c77aa58: 9p: take write lock on fid path updates (CVE-2018-19364) (Greg =
Kurz)
ced09f9b07: qtest: log QEMU command line (Paolo Bonzini)
af51dbed38: update seabios to 1.12 (Gerd Hoffmann)
3b6b0a8ae7: tests/ide: Free pcibus when finishing a test (Thomas Huth)
61793a627d: tests: add qmp/missing-any-arg test (Marc-Andr=C3=A9 Lureau)
8cedcffdc1: iotests: Drop use of bash keyword 'function' (Eric Blake)
bb39c47d70: iotests: Also test I/O over NBD TLS (Eric Blake)
afcd1c2f2d: tests: exercise NBD server in TLS mode (Daniel P. Berrang=C3=A9)
a46b684106: tests: add iotests helpers for dealing with TLS certificates (D=
aniel P. Berrang=C3=A9)
b39b58d5d0: tests: check if qemu-nbd is still alive before waiting (Daniel =
P. Berrang=C3=A9)
e6d5d6fdd4: tests: pull qemu-nbd iotest helpers into common.nbd file (Danie=
l P. Berrang=C3=A9)
a2458b6f69: io: return 0 for EOF in TLS session read after shutdown (Daniel=
 P. Berrang=C3=A9)
3e99ebb9d3: nbd/server: Ignore write errors when replying to NBD_OPT_ABORT =
(Eric Blake)
0b0bb124bb: nbd: fix whitespace in server error message (Daniel P. Berrang=
=C3=A9)
4a9e751f61: qemu-iotests: Modern shell scripting (use $() instead of ``) (M=
ao Zhongyi)
e8d81a61e1: qemu-iotests: convert `pwd` and $(pwd) to $PWD (Mao Zhongyi)
bf22957309: qemu-iotests: remove unused variable 'here' (Mao Zhongyi)
a00d7f2048: MAINTAINERS: list myself as maintainer for various Arm boards (=
Peter Maydell)
9e6e9247a4: hw/block/onenand: use qemu_log_mask() for reporting (Peter Mayd=
ell)
fcf5787c02: hw/block/onenand: Fix off-by-one error allowing out-of-bounds r=
ead (Peter Maydell)
7760da729a: target/arm: fix smc incorrectly trapping to EL3 when secure is =
off (Luc Michel)
dd5d693ecf: hw/arm/stm32f205: Fix the UART and Timer region size (Seth Kint=
igh)
95a5db3ae5: MAINTAINERS: Add entries for missing ARM boards (Thomas Huth)
3c3efcf7da: target/arm: Fill in ARMISARegisters for kvm32 (Richard Henderso=
n)
b653c55fa7: target/arm: Introduce read_sys_reg32 for kvm32 (Richard Henders=
on)
9d60dea960: target/arm: Fill in ARMISARegisters for kvm64 (Richard Henderso=
n)
4674097c32: target/arm: Install ARMISARegisters from kvm host (Richard Hend=
erson)
6d0a4a0fb5: iotests: Test file-posix locking and reopen (Max Reitz)
577a133988: file-posix: Fix shared locks on reopen commit (Max Reitz)
9ad08c4456: block: Always abort reopen after prepare succeeded (Max Reitz)
3b94c343f9: iotests: Add new test 220 for max compressed cluster offset (Er=
ic Blake)
77d6a21558: qcow2: Don't allow overflow during cluster allocation (Eric Bla=
ke)
d3e1a7eb4c: qcow2: Document some maximum size constraints (Eric Blake)
443ba6befa: vvfat: Fix memory leak (Kevin Wolf)
441f6692ec: fdc: fix segfault in fdctrl_stop_transfer() when DMA is disable=
d (Mark Cave-Ayland)
5e3c0220d7: nvme: fix oob access issue(CVE-2018-16847) (Li Qiang)
9436e082de: MAINTAINERS: clarify some of the tags (Cornelia Huck)
90b27c4c3b: MAINTAINERS: Add Stefan Markovic as a MIPS reviewer (Aleksandar=
 Markovic)
823f2897bd: target/mips: Disable R5900 support (Aleksandar Markovic)
874b287970: target/mips: Rename MMI-related functions (Aleksandar Markovic)
baa609db75: target/mips: Rename MMI-related opcodes (Aleksandar Markovic)
c8341e0000: target/mips: Rename MMI-related masks (Aleksandar Markovic)
992e8176d3: target/mips: Guard check_insn with INSN_R5900 check (Fredrik No=
ring)
55fc7a69aa: target/mips: Guard check_insn_opc_user_only with INSN_R5900 che=
ck (Fredrik Noring)
9dc324ce66: target/mips: Fix decoding mechanism of special R5900 opcodes (F=
redrik Noring)
c42171c3bf: target/mips: Fix decoding mechanism of R5900 DIV1 and DIVU1 (Fr=
edrik Noring)
86efbfb619: target/mips: Fix decoding mechanism of R5900 MFLO1, MFHI1, MTLO=
1 and MTHI1 (Fredrik Noring)
6456c51081: linux-user: Update MIPS specific prctl() implementation (Stefan=
 Markovic)
144aaa990e: help: Provide help for egl-headless (Erik Skultety)
91e61947eb: ui: Allow specifying 'rendernode' display option for egl-headle=
ss (Erik Skultety)
d4dc4ab133: qapi: Add "rendernode" display option for egl-headless (Erik Sk=
ultety)
013a62020a: net/filter-rewriter.c: Fix coverity static analysis issue (Zhan=
g Chen)
bba390cb9e: linux-user/sparc/signal.c: Remove dead code (Peter Maydell)
3fccd3f26e: make-release: add skiboot .version file (Michael Roth)
5e58b58c47: tests: tpm: Use g_test_message rather than fprintf (Stefan Berg=
er)
6a50bb98f2: tpm: use loop iterator to set sts data field (Prasad J Pandit)
1f442da51e: tests/tcg/multiarch: fix 32bit linux-test on 64bit host (Lauren=
t Vivier)
adcf96830d: .travis.yml: split MacOSX builds and reduce target list (Alex B=
enn=C3=A9e)
3502dc824a: RISC-V: Respect fences for user-only emulators (Palmer Dabbelt)
6573777306: target/riscv: Fix sfence.vm/a both available in any priv versio=
n (Bastian Koppelmann)
40cf6a54c9: target/riscv: Fix FCLASS_D being treated as RV64 only (Bastian =
Koppelmann)
632fb2792b: hw/riscv/virt: Free the test device tree node name (Alistair Fr=
ancis)
b6e67ecc7b: s390x/pci: properly fail if the zPCI device cannot be created (=
David Hildenbrand)
