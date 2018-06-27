Received: from eggs.gnu.org ([2001:4830:134:3::10]:50723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fYGd6-0007q1-E8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fYGd3-0002Ui-3t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fYGd2-0002Tf-SV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5RJs9d4105611
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 16:01:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jve0rg87s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 16:01:22 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 27 Jun 2018 14:01:20 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 27 Jun 2018 15:01:09 -0500
Message-Id: <153012966960.5776.10771687706278921098@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.2 Stable released
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

I am pleased to announce that the QEMU v2.11.2 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v2.11.2 is now tagged in the official qemu.git repository,
and the stable-2.11 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.11

This update contains new mitigation functionality for CVE-2018-3639
(Speculative Store Bypass) in x86, and security fixes for vga emulation
(CVE-2018-7550). There's also broad range of bug/security fixes for
migration, Intel IOMMU emulation, block layer/image handling, memory
management, and various other areas/architectures.

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

0982a56a55 Update version for 2.11.2 release
aba59705d9 usb/dev-mtp: Fix use of uninitialized values
17e3fcbc51 usb: correctly handle Zero Length Packets
9e4fa091ee gdbstub: fix off-by-one in gdb_handle_packet()
728d6c602e pc-bios/s390-ccw.img: update image for stable
1e13e7d93b tpm: lookup cancel path under tpm device class
a36591fa62 tpm-passthrough: don't save guessed cancel_path in options
0f04a8bba6 s390-ccw-virtio: allow for systems larger that 7.999TB
2ab0ce6e8d crypto: ensure we use a predictable TLS priority setting
8bbb76e050 qapi: ensure stable sort ordering when checking QAPI entities
6622e94897 arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers ban=
ked by GICR_IPRIORITYR
99e051b290 iotests: Add test 221 to catch qemu-img map regression
9c5a8433ce qemu-img: Fix assert when mapping unaligned raw file
d8a919ffc7 vhost-user: delete net client if necessary
f4e93bbd2e tap: set vhostfd passed from qemu cli to non-blocking
afa43eb63e i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-363=
9)
73521f60f4 i386: Define the Virt SSBD MSR and handling of it (CVE-2018-3639)
4ce0b750a2 i386: define the 'ssbd' CPUID feature bit (CVE-2018-3639)
84cfae0b6f vga: fix region calculation
d80b60fc24 throttle: Fix crash on reopen
f647a4fc44 iotests: Add case for a corrupted inactive image
f91f44fcd1 qcow2: Do not mark inactive images corrupt
62891cad12 block: Make bdrv_is_writable() public
5d639531b7 arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GI=
CR
deabb454dc ahci: fix PxCI register race
16238325f1 Fix libusb-1.0.22 deprecated libusb_set_debug with libusb_set_op=
tion
e55c6b6795 arm_gicv3_kvm: increase clroffset accordingly
8da7a171c0 intel-iommu: rework the page walk logic
bdb6f9b6bc util: implement simple iova tree
e2c44fc580 intel-iommu: trace domain id during page walk
e8aa1dc816 intel-iommu: pass in address space when page walk
04e0e11628 intel-iommu: introduce vtd_page_walk_info
21962e6958 intel-iommu: only do page walk for MAP notifiers
3585497e86 intel-iommu: add iommu lock
99fc962b62 intel-iommu: remove IntelIOMMUNotifierNode
6c403b72b4 intel-iommu: send PSI always even if across PDEs
0b250250b7 intel-iommu: Extend address width to 48 bits
d45364e6d4 intel-iommu: Redefine macros to enable supporting 48 bit address=
 width
7128bcb221 hw/intc/arm_gicv3: Fix APxR<n> register dispatching
2e70085eb7 console: Avoid segfault in screendump
b68ef5920a s390x/ccw: make sure all ccw devices are properly reset
b2ca602627 virtio-ccw: common reset handler
f7f5398dc7 s390x/virtio: Convert virtio-ccw from *_exit to *_unrealize
18f59bbc76 qdev: add helpers to be more explicit when using abstract QOM pa=
rent functions
0db89523a6 qdev: rename typedef qdev_resetfn() -> DeviceReset()
ce4e7b03a7 pc-bios/s390-ccw: struct tpi_info must be declared as aligned(4)
435a31ff9a s390x/css: disabled subchannels cannot be status pending
720db5deeb raw: Check byte range uniformly
979e7ea7eb lm32: take BQL before writing IP/IM register
15fb5dbf90 iotests: Add test for -U/force-share conflicts
5704f53ca9 qemu-img: Use only string options in img_open_opts
dbacc54944 qemu-io: Use purely string blockdev options
324bef41d3 iotests: Add test for rebasing with relative paths
1bec53c6f4 qemu-img: Resolve relative backing paths in rebase
088a22455b configure: recognize more rpmbuild macros
ecd54d6670 qxl: fix local renderer crash
1378cb9db5 spapr: don't advertise radix GTSE if max-compat-cpu < power9
0ab2f8e36d target/ppc: always set PPC_MEM_TLBIE in pre 2.8 migration hack
67bacd5be4 target/arm: Implement v8M VLLDM and VLSTM
a27d261fe2 tcg/arm: Fix memory barrier encoding
834a846eee s390-ccw: force diag 308 subcode to unsigned long
0304f75f61 s390: Do not pass inofficial IPL type to the guest
955b77f56e nbd/client: Fix error messages during NBD_INFO_BLOCK_SIZE
f3f01bab82 ccid: Fix dwProtocols advertisement of T=3D0
5648a81dd2 device_tree: Increase FDT_MAX_SIZE to 1 MiB
0580c63b4f hw/char/cmsdk-apb-uart.c: Correctly clear INTSTATUS bits on writ=
es
b17ed3e1d2 tcg: Introduce tcg_set_insn_start_param
44633a272b hw/block/pflash_cfi: fix off-by-one error
8999a5945f vfio-ccw: fix memory leaks in vfio_ccw_realize()
28895d021e cpus.c: ensure running CPU recalculates icount deadlines on time=
r expiry
12fc0de2ab gluster: Fix blockdev-add with server.N.type=3Dunix
bb8d4bb3cc exec: fix memory leak in find_max_supported_pagesize()
2b73d5d348 target/i386: Fix andn instruction
5aac5f6aee tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops
c793a0debd iotests: Test preallocated truncate of 2G image
d315353bed block/file-posix: Fix fully preallocated truncate
332969a64d qemu-pr-helper: Actually allow users to specify pidfile
db9c0d907e virtio_net: flush uncompleted TX on reset
a053477b7c arm/translate-a64: treat DISAS_UPDATE as variant of DISAS_EXIT
7c22c5a3a7 tests/multiboot: Add .gitignore
678a75b8b5 tests/multiboot: Add tests for the a.out kludge
2392a86d2d tests/multiboot: Test exit code for every qemu run
32ccaed1ae multiboot: Check validity of mh_header_addr
31b0eb0dad multiboot: Reject kernels exceeding the address space
bbdcfd2dbc multiboot: fprintf(stderr...) -> error_report()
ddf965ef9d multiboot: Use header names when displaying fields
a030730621 multiboot: Remove unused variables from multiboot.c
059a6962b2 multiboot: bss_end_addr can be zero
ab2dfe8d17 migration/block: reset dirty bitmap before read in bulk phase
cebb7fea7c memory: fix flatview_access_valid RCU read lock/unlock imbalance
aedaf01f8c address_space_rw: address_space_to_flatview needs RCU lock
a7f4d8a105 address_space_map: address_space_to_flatview needs RCU lock
fa876bc97a address_space_access_valid: address_space_to_flatview needs RCU =
lock
f77c231202 address_space_read: address_space_to_flatview needs RCU lock
df04d1f16a address_space_write: address_space_to_flatview needs RCU lock
ac25a3257f memory: inline some performance-sensitive accessors
8e8b73992c openpic_kvm: drop address_space_to_flatview call
499211829d sparc: fix leon3 casa instruction when MMU is disabled
e1f5a04d17 linux-user: fix target_mprotect/target_munmap error return values
8fc971ed1b linux-user: fix assertion in shmdt
1801fabd9b linux-user: fix mmap/munmap/mprotect/mremap/shmat
2ac88347fa target/xtensa: dump correct physical registers
1f4637953e loader: don't perform overlapping address check for memory regio=
n ROM images
e2fc495b4a tpm: Set the flags of the CMD_INIT command to 0
4f81878152 rbd: Fix use after free in qemu_rbd_set_keypairs() error path
6f36bd3969 specs/qcow2: Fix documentation of the compressed cluster descrip=
tor
0430aa089c nbd: Honor server's advertised minimum block size
327d4645a0 spapr: make pseries-2.11 the default machine type
b940928fa0 virtio-balloon: unref the memory region before continuing
c3c44a4fb0 pci-bridge/i82801b11: clear bridge registers on platform reset
82c5191f9c block/ssh: fix possible segmentation fault when .desc is not nul=
l-terminated
72cc467aab spapr: register dummy ICPs later
184da186db spapr: fix missing CPU core nodes in DT when running with TCG
e676038e60 spapr: consolidate the VCPU id numbering logic in a single place
094706e69f spapr: rename spapr_vcpu_id() to spapr_get_vcpu_id()
8c0ec3c398 target/ppc: Clarify compat mode max_threads value
a8074a5895 spapr: move VCPU calculation to core machine code
cc86c46758 spapr: use spapr->vsmt to compute VCPU ids
c30b366d00 spapr: set vsmt to MAX(8, smp_threads)
af65bce409 spapr: Adjust default VSMT value for better migration compatibil=
ity
ad484114d1 spapr: Allow some cases where we can't set VSMT mode in the kern=
el
0a30cae50a sdl: workaround bug in sdl 2.0.8 headers
5892b5a9e3 memfd: fix configure test
