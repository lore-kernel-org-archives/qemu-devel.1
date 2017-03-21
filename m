Received: from eggs.gnu.org ([2001:4830:134:3::10]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqPRg-0006nT-06
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 15:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqPRc-0005zE-MP
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 15:27:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqPRc-0005xb-CG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 15:27:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LJOGIV084707
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 15:27:45 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vhha98-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 15:27:45 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 13:27:44 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 14:26:51 -0500
Message-Id: <149012441191.1400.11976806642372904230@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc1 is now available
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
second release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc1.tar.xz.sig

A note from the maintainer:

  This release candidate includes changes to the configure script
  so that it will now report some host operating systems and
  platforms as "unsupported". These are host setups which we do not
  have access to and are thus unable to test. They will continue
  to work in this 2.9 release (though configure will warn you about
  the unsupported status), but in a future QEMU release we may
  drop support for those hosts unless somebody volunteers to help
  us with maintaining them (and can provide build/CI machines).
  =

  This affects the CPU architectures:
       * ia64
       * sparc
  and the OSes:
       * GNU/kFreeBSD
       * DragonFly BSD
       * NetBSD
       * OpenBSD
       * Solaris
       * AIX
       * Haiku
  (We've been fairly ruthless here in marking unsupported anything
  that we don't have working build/test support for right now. We
  may move some of these back to the 'supported' category before
  2.9 final release if we get help in getting them working. In any
  case they will still work in 2.9 as well as they ever have;
  configure will just be noisy about them.)

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

Changes since rc0:

55a19ad: Update version for v2.9.0-rc1 release (Peter Maydell)
898be3e: configure: Warn about deprecated hosts (Peter Maydell)
cc720a5: add opengl_cflags to QEMU_CFLAGS (Gerd Hoffmann)
262169a: 9pfs: proxy: assert if unmarshal fails (Greg Kurz)
d5f2af7: 9pfs: don't try to flush self and avoid QEMU hang on reset (Greg K=
urz)
373967b: audio: catch missing sdl support (Gerd Hoffmann)
c864575: configure: remove Cygwin (Paolo Bonzini)
b28b337: arm: Fix APSR writes via M profile MSR (Peter Maydell)
3d54026: arm: Enforce should-be-1 bits in MRS decoding (Peter Maydell)
43ac657: arm: Don't decode MRS(banked) or MSR(banked) for M profile (Peter =
Maydell)
001b3ca: arm: HVC and SMC encodings don't exist for M profile (Peter Maydel=
l)
b3d3a42: hax: fix breakage in locking (Vincent Palatin)
659f42d: MAINTAINERS: update for MIPS devices (Yongbok Kim)
1b393b3: dma/rc4030: fix a mixed declarations and code warning (Yongbok Kim)
c627e75: dma/rc4030: translate memory accesses only when they occur (Herv=
=C3=A9 Poussineau)
c0a3172: dma: rc4030: limit interval timer reload value (Prasad J Pandit)
075a1fe: target/mips: fix delay slot detection in gen_msa_branch() (Yongbok=
 Kim)
b44a7fb: target-mips: replace few LOG_DISAS() with trace points (Philippe M=
athieu-Daud=C3=A9)
3570d7f: target-mips: replace break by goto cp0_unimplemented (Philippe Mat=
hieu-Daud=C3=A9)
965447e: target-mips: log bad coprocessor0 register accesses with LOG_UNIMP=
 (Philippe Mathieu-Daud=C3=A9)
989f2aa: target-mips: remove old & unuseful comments (Philippe Mathieu-Daud=
=C3=A9)
def74c0: target-mips: fix compiler warnings (clang 5) (Philippe Mathieu-Dau=
d=C3=A9)
3c788eb: s390x/css: reassign subchannel if schid is changed after migration=
 (Dong Jia Shi)
7bc4f08: vnc: fix a qio-channel leak (Marc-Andr=C3=A9 Lureau)
732a802: configure: remove Cygwin (Paolo Bonzini)
6b827cc: xen: do not build backends for targets that do not support xen (St=
efano Stabellini)
53fabd4: qemu-ga: obey LISTEN_PID when using systemd socket activation (Pao=
lo Bonzini)
ebedf0f: nios2: iic: Convert CPU prop to qom link (Marek Vasut)
6b3cca7: oslib-posix: fix compilation on OpenBSD (Paolo Bonzini)
eb04802: curl: fix compilation on OpenBSD (Paolo Bonzini)
c2b6428: block: quiesce AioContext when detaching from it (Paolo Bonzini)
b7a745d: thread-pool: add missing qemu_bh_cancel in completion function (Pe=
ter Lieven)
8cd1a3e: block: Propagate error in bdrv_open_backing_file (Fam Zheng)
184dd9c: blockdev: fix bitmap clear undo (John Snow)
c1cef67: block: Always call bdrv_child_check_perm first (Fam Zheng)
fed414d: file-posix: Don't leak fd in hdev_get_max_segments (Fam Zheng)
37a9051: replication: clarify permissions (Changlong Xie)
6958349: file-posix: clean up max_segments buffer termination (Stefan Hajno=
czi)
f019722: cirrus: fix off-by-one in cirrus_bitblt_rop_bkwd_transp_*_16 (Gerd=
 Hoffmann)
8bb93c6: ui/console: ensure graphic updates don't race with TCG vCPUs (Alex=
 Benn=C3=A9e)
699f6c6: dtc: Revert unintentional submodule downgrade from commit c2cabb34=
220d63f9 (Peter Maydell)
8679638: postcopy: Check for shared memory (Dr. David Alan Gilbert)
463a4ac: RAMBlocks: qemu_ram_is_shared (Dr. David Alan Gilbert)
e1e686c: vmstate: fix failed iotests case 68 and 91 (QingFeng Hao)
1cf6aa7: migration/block: Avoid invoking blk_drain too frequently (Lidong C=
hen)
ffaf857: cirrus: stop passing around src pointers in the blitter (Gerd Hoff=
mann)
026aeff: cirrus: stop passing around dst pointers in the blitter (Gerd Hoff=
mann)
e048dac: cirrus: fix cirrus_invalidate_region (Gerd Hoffmann)
827bd51: cirrus: add option to disable blitter (Gerd Hoffmann)
73c1481: cirrus: switch to 4 MB video memory by default (Gerd Hoffmann)
50628d3: cirrus/vnc: zap bitblit support from console code. (Gerd Hoffmann)
215902d: fix :cirrus_vga fix OOB read case qemu Segmentation fault (hangaoh=
uai)
4af245d: migration: use "" as the default for tls-creds/hostname (Daniel P.=
 Berrange)
1ffb5df: Change the method to calculate dirty-pages-rate (Chao Fan)
012b126: qapi: Fix a misleading parser error message (Markus Armbruster)
c261394: qapi: Make pylint a bit happier (Markus Armbruster)
6bbfb12: qapi: Drop unused .check_clash() parameter schema (Markus Armbrust=
er)
768562d: qapi: union_types is a list used like a dict, make it one (Markus =
Armbruster)
ed285bf: qapi: struct_types is a list used like a dict, make it one (Markus=
 Armbruster)
5f01844: qapi: enum_types is a list used like a dict, make it one (Markus A=
rmbruster)
6f05345: qapi: Factor add_name() calls out of the meta conditional (Markus =
Armbruster)
eda43c6: qapi: Simplify what gets stored in enum_types (Markus Armbruster)
062e856: qapi: Drop unused variable events (Markus Armbruster)
a9f396b: qapi: Eliminate check_docs() and drop QAPIDoc.expr (Markus Armbrus=
ter)
816a57c: qapi: Fix detection of bogus member documentation (Markus Armbrust=
er)
f641d06: tests/qapi-schema: Improve coverage of bogus member docs (Markus A=
rmbruster)
bdc001c: tests/qapi-schema: Rename doc-bad-args to doc-bad-command-arg (Mar=
kus Armbruster)
4ea7148: qapi: Move empty doc section checking to doc parser (Markus Armbru=
ster)
2d43323: qapi: Improve error message on @NAME: in free-form doc (Markus Arm=
bruster)
7947016: qapi: Move detection of doc / expression name mismatch (Markus Arm=
bruster)
e7823a2: qapi: Fix detection of doc / expression mismatch (Markus Armbruste=
r)
2028be8: tests/qapi-schema: Improve doc / expression mismatch coverage (Mar=
kus Armbruster)
75b5019: qapi2texi: Use category "Object" for all object types (Markus Armb=
ruster)
c19eaa6: qapi2texi: Generate descriptions for simple union tags (Markus Arm=
bruster)
5169cd8: qapi2texi: Generate documentation for variant members (Markus Armb=
ruster)
88f6346: qapi2texi: Generate reference to base type members (Markus Armbrus=
ter)
691e031: qapi2texi: Include member type in generated documentation (Markus =
Armbruster)
c2dd311: qapi2texi: Implement boxed argument documentation (Markus Armbrust=
er)
2c99f5f: qapi2texi: Don't hide undocumented members and arguments (Markus A=
rmbruster)
5da19f1: qapi2texi: Explain enum value undocumentedness more clearly (Marku=
s Armbruster)
2a1183c: qapi2texi: Present the table of members more clearly (Markus Armbr=
uster)
71d918a: qapi2texi: Plainer enum value and member name formatting (Markus A=
rmbruster)
ef801a9: qapi: Prefer single-quoted strings more consistently (Markus Armbr=
uster)
0fe675a: qapi: Use raw strings for regular expressions consistently (Markus=
 Armbruster)
1d8bda1: qapi: The #optional tag is redundant, drop (Markus Armbruster)
aa964b7: qapi2texi: Convert to QAPISchemaVisitor (Markus Armbruster)
860e877: qapi: Conjure up QAPIDoc.ArgSection for undocumented members (Mark=
us Armbruster)
069fb5b: qapi: Prepare for requiring more complete documentation (Markus Ar=
mbruster)
4636211: qapi: Fix QAPISchemaEnumType.is_implicit() for 'QType' (Markus Arm=
bruster)
8c0aa61: qapi/rocker: Fix up doc comment notes on optional members (Markus =
Armbruster)
b116fd8: qapi: Avoid unwanted blank lines in QAPIDoc (Markus Armbruster)
42bebcc: qapi2texi: Fix up output around #optional (Markus Armbruster)
4815374: qapi: Fix to reject empty union base gracefully (Markus Armbruster)
707fb2d: tests/qapi-schema: Cover empty union base (Markus Armbruster)
bd7f974: qapi: Clean up build of generated documentation (Markus Armbruster)
2cfbae3: qapi: Have each QAPI schema declare its name rule violations (Mark=
us Armbruster)
1554a8f: qapi: Have each QAPI schema declare its returns white-list (Markus=
 Armbruster)
700dc9f: docs/qapi-code-gen.txt: Drop confusing reference to 'gen' (Markus =
Armbruster)
87c16dc: qapi: Back out doc comments added just to please qapi.py (Markus A=
rmbruster)
bc52d03: qapi: Make doc comments optional where we don't need them (Markus =
Armbruster)
e04dea8: qapi: Factor QAPISchemaParser._include() out of .__init__() (Marku=
s Armbruster)
f880cd6: qmp: allow setting properties to empty string in qmp-shell (Daniel=
 P. Berrange)
597494a: qapi2texi: change texi formatters (Marc-Andr=C3=A9 Lureau)
8755b4a: trace: ensure $(tracetool-y) is defined in top level makefile (Dan=
iel P. Berrange)
4175304: makefile: generate trace-events-all upfront (Daniel P. Berrange)
4f04f13: makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables (D=
aniel P. Berrange)
d68f0f7: ide: ahci: call cleanup function in ahci unit (Li Qiang)
c9f0864: ide: core: add cleanup function (Li Qiang)
44a109c: ide: qdev: register ide bus unrealize function (Li Qiang)
bdf4c4e: virtio-serial-bus: Delete timer from list before free it (zhanghai=
liang)
27ce0f3: hw/virtio: fix Power Management Control Register for PCI Express v=
irtio devices (Marcel Apfelbaum)
d584f1b: hw/virtio: fix Link Control Register for PCI Express virtio device=
s (Marcel Apfelbaum)
c2cabb3: hw/virtio: fix error enabling flags in Device Control register (Ma=
rcel Apfelbaum)
f03d8ea: hw/pcie: fix Extended Configuration Space for devices with no Exte=
nded Capabilities (Marcel Apfelbaum)
111308e: Update OpenBIOS images to f233c3f built from submodule. (Mark Cave=
-Ayland)
60a8d80: virtio-pci: reset modern vq meta data (Jason Wang)
f0edf23: Revert "virtio: unbreak virtio-pci with IOMMU after caching ring t=
ranslations" (Jason Wang)
3716d59: pci: introduce a bus master container (Jason Wang)
e45da65: virtio: validate address space cache during init (Jason Wang)
e0e2d64: virtio: destroy region cache during reset (Jason Wang)
168e4af: virtio: guard against NULL pfn (Jason Wang)
72d9196: Bugfix: Handle error if VM Generation ID device not present (Ben W=
arren)
4d0e723: coverity-model: model address_space_read/write (Paolo Bonzini)
157db29: tests: Use error_free_or_abort() where appropriate (Markus Armbrus=
ter)
9dc44aa: os: don't corrupt pre-existing memory-backend data with prealloc (=
Daniel P. Berrange)
0bcba41: machine: Convert abstract typename on compat_props to subclass nam=
es (Eduardo Habkost)
f289bb0: target/xtensa: fix semihosting argc/argv implementation (Max Filip=
pov)
0e80359: target/xtensa: xtfpga: load DTB only when FDT support is enabled (=
Max Filippov)
