Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eEhdM-0005sk-Tg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eEhdH-0003qF-Sn
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:16:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eEhdH-0003pQ-Jm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:16:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAEKFT2b053589
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:16:25 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e82u4pu5v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:16:24 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 14 Nov 2017 13:16:23 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 14 Nov 2017 14:16:15 -0600
Message-Id: <151069057582.22232.4118052106540833971@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc1 is now available
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
second release candidate for the QEMU 2.11 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.11.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-2.11.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 2.11 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.11

Please add entries to the ChangeLog for the 2.11 release below:

  http://wiki.qemu.org/ChangeLog/2.11

Changes since rc0:

1fa0f627d0: Update version for v2.11.0-rc1 release (Peter Maydell)
8b2d7c364d: qemu-iotests: update unsupported image formats in 194 (Jeff Cod=
y)
1d0f37cf21: block/parallels: add migration blocker (Jeff Cody)
6c7d390b99: block/parallels: Do not update header or truncate image when IN=
MIGRATE (Jeff Cody)
7479bf07c4: block/vhdx.c: Don't blindly update the header (Jeff Cody)
d04c155503: iotests: 077: Filter out 'resume' lines (Fam Zheng)
04dec3c3ae: block/snapshot: dirty all dirty bitmaps on snapshot-switch (Vla=
dimir Sementsov-Ogievskiy)
bcb5270c75: qcow2: Check that corrupted images can be repaired in iotest 06=
0 (Alberto Garcia)
147b44be49: iotests: Use new-style NBD connections (Eric Blake)
19026817f7: iotests: Make 136 less flaky (Max Reitz)
ddc7093eec: iotests: Make 083 less flaky (Max Reitz)
bc11aee2ac: iotests: Make 055 less flaky (Max Reitz)
51c493c5cc: iotests: Add missing 'blkdebug::' in 040 (Max Reitz)
dca9b6a2b1: iotests: Make 030 less flaky (Max Reitz)
c9b83e9c23: qcow2: Assert that the crypto header does not overlap other met=
adata (Alberto Garcia)
ef083f61af: qcow2: Add iotest for an empty refcount table (Alberto Garcia)
5a45da5ef8: qcow2: Add iotest for an image with header.refcount_table_offse=
t =3D=3D 0 (Alberto Garcia)
951053a9ec: qcow2: Don't open images with header.refcount_table_clusters =
=3D=3D 0 (Alberto Garcia)
8aa34834d5: qcow2: Prevent allocating compressed clusters at offset 0 (Albe=
rto Garcia)
9883975050: qcow2: Prevent allocating L2 tables at offset 0 (Alberto Garcia)
6bf45d59f9: qcow2: Prevent allocating refcount blocks at offset 0 (Alberto =
Garcia)
6350b2a09b: seabios: update to 1.11 final (Gerd Hoffmann)
dcb556fc6a: xics/kvm: synchonize state before 'info pic' (Greg Kurz)
e05fba5004: target/ppc: correct htab shift for hash on radix (Sam Bobroff)
0761562687: qemu-iotests: Test I/O limits with removable media (Alberto Gar=
cia)
c89bcf3af0: block: Leave valid throttle timers when removing a BDS from a b=
ackend (Alberto Garcia)
48bf7ea81a: block: Check for inserted BlockDriverState in blk_io_limits_dis=
able() (Alberto Garcia)
dc868fb03b: throttle-groups: drain before detaching ThrottleState (Stefan H=
ajnoczi)
632a773543: block: all I/O should be completed before removing throttle tim=
ers. (Zhengui)
d25f2a7227: accel/tcg/translate-all: expand cpu_restore_state addr check (A=
lex Benn=C3=A9e)
7264961934: hw: add .min_cpus and .default_cpus fields to machine_class (Em=
ilio G. Cota)
1342b0355e: xlnx-zcu102: Specify the max number of CPUs for the EP108 (Emil=
io G. Cota)
83926ad527: xlnx-zcu102: Add an info message deprecating the EP108 (Alistai=
r Francis)
6908ec448b: xlnx-zynqmp: Properly support the smp command line option (Alis=
tair Francis)
2dda635410: qom: move CPUClass.tcg_initialize to a global (Emilio G. Cota)
670bc4cbda: MAINTAINERS: Add entries for Smartfusion2 (Subbaraya Sundeep)
c5c752af8c: highbank: validate register offset before access (Prasad J Pand=
it)
5ca66278c8: arm/translate-a64: mark path as unreachable to eliminate warnin=
g (Emilio G. Cota)
bb160b571f: net/socket: fix coverity issue (Jens Freimann)
5e89dc0113: Add new PCI ID for i82559a (Mike Nawrocki)
1865e288a8: Fix eepro100 simple transmission mode (Mike Nawrocki)
8fa5ad6dfb: colo: Consolidate the duplicate code chunk into a routine (Mao =
Zhongyi)
3463218c6c: colo-compare: Fix comments (Mao Zhongyi)
8ec1440202: colo-compare: compare the packet in a specified Connection (Mao=
 Zhongyi)
8850d4caa7: colo-compare: Insert packet into the suitable position of packe=
t queue directly (Mao Zhongyi)
ff86d57625: net: fix check for number of parameters to -netdev socket (Jens=
 Freimann)
2e9a856570: ui: use QEMU_IS_ALIGNED macro (Philippe Mathieu-Daud=C3=A9)
cf7040e284: vmsvga: use ARRAY_SIZE macro (Philippe Mathieu-Daud=C3=A9)
115788d7a7: vga: fix region checks in wraparound case (Gerd Hoffmann)
777c5f1e43: ui: fix dcl unregister (Gerd Hoffmann)
c53f5b89f1: virtio-gpu: fix bug in host memory calculation. (Tao Wu)
990132cda9: slirp: don't zero the whole ti_i when m =3D=3D NULL (Tao Wu)
ef8c887ee0: nbd/server: Fix structured read of length 0 (Eric Blake)
b4176cb314: nbd-client: Stricter enforcing of structured reply spec (Eric B=
lake)
9d8f818cde: nbd-client: Short-circuit 0-length operations (Eric Blake)
efdc0c103d: nbd: Fix struct name for structured reads (Eric Blake)
079d3266c7: nbd/client: Nicer trace of structured reply (Eric Blake)
1104d83c72: nbd-client: Refuse read-only client with BDRV_O_RDWR (Eric Blak=
e)
e659fb3b99: nbd-client: Fix error message typos (Eric Blake)
fdaae35143: target/s390x: Finish implementing RISBGN (Richard Henderson)
9f81aeb5da: Makefile: Capstone: Add support for cross compile ranlib (Alist=
air Francis)
15fa1a0ae0: disas: Dump insn bytes along with capstone disassembly (Richard=
 Henderson)
46321d6b5f: nbd/server: fix nbd_negotiate_handle_info (Vladimir Sementsov-O=
gievskiy)
ef6dada8b4: util/async: use atomic_mb_set in qemu_bh_cancel (Sergio Lopez)
f1710638ed: crypto: afalg: fix a NULL pointer dereference (Longpeng)
b417a7624c: tests: Run the luks tests in test-crypto-block only if encrypti=
on is available (Thomas Huth)
2c28c49057: s390x/pci: let pci devices start in configured mode (Christian =
Borntraeger)
fb0c43f34e: tests-aio-multithread: fix /aio/multi/schedule race condition (=
Stefan Hajnoczi)
6423795efc: docker: correctly escape $BACKEND in the help output (Philippe =
Mathieu-Daud=C3=A9)
c1958e9d54: docker: Improved image checksum (Fam Zheng)
c91c187f71: e500: ppce500_init_mpic() return device instead of IRQ array (M=
ichael Davidsaver)
79b217dedb: hw/display/sm501: Fix comment in sm501_sysbus_class_init() (Tho=
mas Huth)
e4f0c6bb1a: ppc: fix setting of compat mode (Greg Kurz)
