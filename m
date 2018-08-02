Received: from eggs.gnu.org ([2001:4830:134:3::10]:39981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1flMeV-0001Ct-0W
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 19:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1flMeT-0000DY-7U
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 19:05:02 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <153325108446.11567.12369909590160279618@sif>
Date: Thu, 02 Aug 2018 18:04:44 -0500
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.12.1 Stable released
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

I am pleased to announce that the QEMU v2.12.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v2.12.1 is now tagged in the official qemu.git repository,
and the stable-2.12 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.12

This update contains new mitigation functionality for CVE-2018-3639
(Speculative Store Bypass) in x86. There are also bug fixes for
migration, Intel IOMMU emulation, block layer/image handling, ARM
emulation, and various other areas.

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

e22f675bdd: Update version for 2.12.1 release (Michael Roth)
aae299a68d: file-posix: Handle EINTR in preallocation=3Dfull write (Fam Zhe=
ng)
b102aea574: qcow: fix a reference leak (KONRAD Frederic)
336cd382dc: s390x/sclp: fix maxram calculation (Christian Borntraeger)
bf1cb819e9: qga: process_event() simplification and leak fix (Marc-Andr=C3=
=A9 Lureau)
08c4a51c65: qmp: De-duplicate error response building (Markus Armbruster)
441784598e: qobject: New qdict_from_jsonf_nofail() (Markus Armbruster)
90b2d94123: ccid-card-passthru: fix regression in realize() (Marc-Andr=C3=
=A9 Lureau)
c16427177a: pc-bios/s390-ccw.img: update image for stable (Cornelia Huck)
e8488edcb3: tcg/i386: Mark xmm registers call-clobbered (Richard Henderson)
3afe55ff38: qemu-img: avoid overflow of min_sparse parameter (Peter Lieven)
1b817abcd4: tap: fix memory leak on success to create a tap device (Yunjian=
 Wang)
0935356e43: target/ppc: set is_jmp on ppc_tr_breakpoint_check (Emilio G. Co=
ta)
d109f8eb7e: virtio-rng: process pending requests on DRIVER_OK (Pankaj Gupta)
2379ac134a: iscsi: Avoid potential for get_status overflow (Eric Blake)
f8b3b02933: nbd/server: Reject 0-length block status request (Eric Blake)
78747264b9: tcg: Reduce max TB opcode count (Richard Henderson)
d8a7ec1deb: migration/block-dirty-bitmap: fix dirty_bitmap_load (Vladimir S=
ementsov-Ogievskiy)
2cb041a82d: vfio/pci: Default display option to "off" (Alex Williamson)
6d3ed3798b: replace functions which are only available in glib-2.24 (Olaf H=
ering)
58119514f5: nfs: Remove processed options from QDict (Kevin Wolf)
008ffc7a2f: mux: fix ctrl-a b again (Marc-Andr=C3=A9 Lureau)
5e10c00f61: hw/isa/superio: Fix inconsistent use of Chardev->be (Philippe M=
athieu-Daud=C3=A9)
ca11f0ab77: target/arm: Fix sqrt_f16 exception raising (Alex Benn=C3=A9e)
ffc3a15018: target/arm: Implement FMOV (immediate) for fp16 (Alex Benn=C3=
=A9e)
f3816879f9: target/arm: Implement FCSEL for fp16 (Alex Benn=C3=A9e)
246dad2f3c: target/arm: Implement FCMP for fp16 (Alex Benn=C3=A9e)
0819a17250: target/arm: Implement FP data-processing (3 source) for fp16 (R=
ichard Henderson)
7133cd4cfe: target/arm: Implement FP data-processing (2 source) for fp16 (R=
ichard Henderson)
d1ed4a60ba: target/arm: Introduce and use read_fp_hreg (Richard Henderson)
7c38f3703d: target/arm: Implement FCVT (scalar, fixed-point) for fp16 (Rich=
ard Henderson)
baa552e54f: target/arm: Implement FCVT (scalar, integer) for fp16 (Richard =
Henderson)
4ec6a17a04: target/arm: Implement FMOV (general) for fp16 (Richard Henderso=
n)
781cde6d94: fpu/softfloat: Fix conversion from uint64 to float128 (Petr Tes=
arik)
e5af958dd2: target/arm: Clear SVE high bits for FMOV (Richard Henderson)
c708ce7d6e: target/arm: Fix float16 to/from int16 (Richard Henderson)
0aaf1cca02: target/arm: Implement vector shifted FCVT for fp16 (Richard Hen=
derson)
994b0cf997: target/arm: Implement vector shifted SCVF/UCVF for fp16 (Richar=
d Henderson)
e653eee8d8: fpu/softfloat: Don't set Invalid for float-to-int(MAXINT) (Pete=
r Maydell)
fbaeb1068c: target/arm: Fix fp_status_f16 tininess before rounding (Peter M=
aydell)
0779afdc89: blockjob: expose error string via query (John Snow)
4a67f4a953: RISC-V: Minimal QEMU 2.12 fix for sifive_u machine (Michael Cla=
rk)
9363c34825: tcg: Limit the number of ops in a TB (Richard Henderson)
51d5decb32: softfloat: Handle default NaN mode after pickNaNMulAdd, not bef=
ore (Peter Maydell)
0e4b4b4fd3: tcg/i386: Fix dup_vec in non-AVX2 codepath (Peter Maydell)
6951158023: nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply =
(Eric Blake)
b129914a8d: riscv: requires libfdt (KONRAD Frederic)
db6f66eff7: riscv: htif: increase the priority of the htif subregion (KONRA=
D Frederic)
26cf05c1a1: riscv: spike: allow base =3D=3D 0 (KONRAD Frederic)
7bc615f88f: iotests: Add test for cancelling a mirror job (Max Reitz)
1eddfab31c: block/mirror: Make cancel always cancel pre-READY (Max Reitz)
3882183fda: qapi: fill in CpuInfoFast.arch in query-cpus-fast (Laszlo Ersek)
3b52d47418: migration/block-dirty-bitmap: fix memory leak in dirty_bitmap_l=
oad_bits (Vladimir Sementsov-Ogievskiy)
f155487bef: nbd/client: fix nbd_negotiate_simple_meta_context (Vladimir Sem=
entsov-Ogievskiy)
54eb6cc6d7: cpus: tcg: fix never exiting loop on unplug (C=C3=A9dric Le Goa=
ter)
9eb3e5a8a8: block/mirror: honor ratelimit again (Stefan Hajnoczi)
05a3e663b1: vnc: fix use-after-free (Gerd Hoffmann)
073198b8e8: usb/dev-mtp: Fix use of uninitialized values (Philippe Mathieu-=
Daud=C3=A9)
5da7e93f51: usb: correctly handle Zero Length Packets (Philippe Mathieu-Dau=
d=C3=A9)
c5dd07b529: arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers ba=
nked by GICR_IPRIORITYR (Shannon Zhao)
396d79c36c: iotests: Add test 221 to catch qemu-img map regression (Eric Bl=
ake)
26cdf35f69: qemu-img: Fix assert when mapping unaligned raw file (Eric Blak=
e)
fb7f173c2c: vhost-user: delete net client if necessary (linzhecheng)
2f2b189235: tap: set vhostfd passed from qemu cli to non-blocking (Brijesh =
Singh)
43163837d3: i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-36=
39) (Konrad Rzeszutek Wilk)
3129ddb943: i386: Define the Virt SSBD MSR and handling of it (CVE-2018-363=
9) (Konrad Rzeszutek Wilk)
8a302f42a5: i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639) (Dani=
el P. Berrang=C3=A9)
ef67e67388: throttle: Fix crash on reopen (Alberto Garcia)
081eac8b30: iotests: Add case for a corrupted inactive image (Max Reitz)
5aa76f3a8c: qcow2: Do not mark inactive images corrupt (Max Reitz)
bd64fec665: block: Make bdrv_is_writable() public (Max Reitz)
5459c0c458: arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by G=
ICR (Shannon Zhao)
5c9266fa97: ahci: fix PxCI register race (John Snow)
df00a166c4: Fix libusb-1.0.22 deprecated libusb_set_debug with libusb_set_o=
ption (John Thomson)
77df190051: arm_gicv3_kvm: increase clroffset accordingly (Shannon Zhao)
f4b4095a8f: intel-iommu: rework the page walk logic (Peter Xu)
08aa25f5f8: util: implement simple iova tree (Peter Xu)
d5c60a950a: intel-iommu: trace domain id during page walk (Peter Xu)
78b85a98a3: intel-iommu: pass in address space when page walk (Peter Xu)
28048f7bcd: intel-iommu: introduce vtd_page_walk_info (Peter Xu)
1e5b93f620: intel-iommu: only do page walk for MAP notifiers (Peter Xu)
5cf61b56a4: intel-iommu: add iommu lock (Peter Xu)
d64604326f: intel-iommu: remove IntelIOMMUNotifierNode (Peter Xu)
93a53137be: intel-iommu: send PSI always even if across PDEs (Peter Xu)
91f6149592: hw/intc/arm_gicv3: Fix APxR<n> register dispatching (Jan Kiszka)
81e46e3c82: console: Avoid segfault in screendump (Michal Privoznik)
a5c8fbbeac: s390x/ccw: make sure all ccw devices are properly reset (Cornel=
ia Huck)
c9bb077871: virtio-ccw: common reset handler (Cornelia Huck)
3372a3168a: pc-bios/s390-ccw: struct tpi_info must be declared as aligned(4=
) (Thomas Huth)
87efdb9820: s390x/css: disabled subchannels cannot be status pending (Corne=
lia Huck)
51691e9244: raw: Check byte range uniformly (Fam Zheng)
4f9df08749: lm32: take BQL before writing IP/IM register (Michael Walle)
ca3150da6d: iotests: Add test for -U/force-share conflicts (Max Reitz)
9e724c05a0: qemu-img: Use only string options in img_open_opts (Max Reitz)
e8d8f6a3aa: qemu-io: Use purely string blockdev options (Max Reitz)
b3a18683f9: iotests: Add test for rebasing with relative paths (Max Reitz)
f9e0e53add: qemu-img: Resolve relative backing paths in rebase (Max Reitz)
f81672a5c6: configure: recognize more rpmbuild macros (Olaf Hering)
9ec09b6542: qxl: fix local renderer crash (Gerd Hoffmann)
2dbaba7af0: spapr: don't advertise radix GTSE if max-compat-cpu < power9 (G=
reg Kurz)
62f7a38610: target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack =
(Greg Kurz)
1ace462f9b: target/arm: Implement v8M VLLDM and VLSTM (Peter Maydell)
b90c93106e: tcg/arm: Fix memory barrier encoding (Henry Wertz)
38b7a3ea72: s390-ccw: force diag 308 subcode to unsigned long (Cornelia Huc=
k)
cb7a41f3f9: nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE (Eric=
 Blake)
8ca471da10: ccid: Fix dwProtocols advertisement of T=3D0 (Jason Andryuk)
1783745673: device_tree: Increase FDT_MAX_SIZE to 1 MiB (Geert Uytterhoeven)
4319ae939c: tests: fix tpm-crb tpm-tis tests race (Marc-Andr=C3=A9 Lureau)
