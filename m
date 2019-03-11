Received: from eggs.gnu.org ([209.51.188.92]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h3O9c-00037v-Ol
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h3O76-0006eU-0v
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:49:22 -0400
Received: from mail-eopbgr720108.outbound.protection.outlook.com
	([40.107.72.108]:36736
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h3O75-0006dZ-Cn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:49:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 11 Mar 2019 16:49:15 +0000
Message-ID: <BN6PR2201MB1251DCE836425EF883AC650EC6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [build-error] possible build error at the tip of the
 trunk? (dtc-related?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello, all

All of the sudden, the latest code doesn't build on my host: (the code from=
 several days ago builds fine)

Do you know what would be the culprit? Is it my environment, or a genuine b=
uild error?

Thanks in advance!
Aleksandar


rtrk@rtrkw774-lin:~/qemu-tot$ ./configure
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /home/rtrk/qemu-tot
GIT binary        git
GIT submodules    ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/be=
rkeley-softfloat-3 dtc capstone slirp
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g=20
QEMU_CFLAGS       -I/usr/include/pixman-1 -I$(SRC_PATH)/dtc/libfdt -Werror =
 -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/incl=
ude -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGE=
FILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-str=
ings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=3Dg=
nu99  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value -Wno-=
missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wform=
at-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style=
-definition -Wtype-limits -fstack-protector-strong  -I/usr/include/libpng12=
 -I$(SRC_PATH)/capstone/include
LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g=20
QEMU_LDFLAGS      -L$(BUILD_DIR)/dtc/libfdt=20
make              make
install           install
python            python -B (2.7.12)
slirp support     git=20
smbd              /usr/sbin/smbd
module support    no
host CPU          x86_64
host big endian   no
target list       aarch64-softmmu alpha-softmmu arm-softmmu cris-softmmu hp=
pa-softmmu i386-softmmu lm32-softmmu m68k-softmmu microblaze-softmmu microb=
lazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu mipsel-softmmu =
moxie-softmmu nios2-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu riscv32-=
softmmu riscv64-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softm=
mu sparc64-softmmu tricore-softmmu unicore32-softmmu x86_64-softmmu xtensa-=
softmmu xtensaeb-softmmu aarch64-linux-user aarch64_be-linux-user alpha-lin=
ux-user arm-linux-user armeb-linux-user cris-linux-user hppa-linux-user i38=
6-linux-user m68k-linux-user microblaze-linux-user microblazeel-linux-user =
mips-linux-user mips64-linux-user mips64el-linux-user mipsel-linux-user mip=
sn32-linux-user mipsn32el-linux-user nios2-linux-user or1k-linux-user ppc-l=
inux-user ppc64-linux-user ppc64abi32-linux-user ppc64le-linux-user riscv32=
-linux-user riscv64-linux-user s390x-linux-user sh4-linux-user sh4eb-linux-=
user sparc-linux-user sparc32plus-linux-user sparc64-linux-user tilegx-linu=
x-user x86_64-linux-user xtensa-linux-user xtensaeb-linux-user
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
SDL support       no=20
SDL image support no
GTK support       no=20
GTK GL support    no
VTE support       no=20
TLS priority      NORMAL
GNUTLS support    no
libgcrypt         no
nettle            no=20
libtasn1          no
PAM               no
curses support    no
virgl support     no=20
curl support      no
mingw32 support   no
Audio drivers     pa oss
Block whitelist (rw)=20
Block whitelist (ro)=20
VirtFS support    yes
Multipath support no
VNC support       yes
VNC SASL support  no
VNC JPEG support  yes
VNC PNG support   yes
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               yes
vde support       no
netmap support    no
Linux AIO support no
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
HVF support       no
WHPX support      no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
malloc trim support yes
RDMA support      no
PVRDMA support    no
fdt support       git
membarrier        no
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
posix_memalign    yes
libcap-ng support no
vhost-net support yes
vhost-crypto support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no=20
rbd support       no
xfsctl support    no
smartcard support no
libusb            no
usb net redir     no
OpenGL support    no
OpenGL dmabufs    no
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
mutex debugging   no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh2 support   no
TPM passthrough  =20
TPM emulator     =20
QOM debugging     yes
Live block migration yes
lzo support       yes
snappy support    no
bzip2 support     no
lzfse support     no
NUMA host support yes
libxml2           no
tcmalloc support  no
jemalloc support  no
avx2 optimization yes
replication support yes
VxHS block device no
bochs support     yes
cloop support     yes
dmg support       yes
qcow v1 support   yes
vdi support       yes
vvfat support     yes
qed support       yes
parallels support yes
sheepdog support  yes
capstone          git
docker            no
libpmem support   no
libudev           no
default devices   yes

NOTE: cross-compilers enabled:  'cc' 'cc'


rtrk@rtrkw774-lin:~/qemu-tot$ make
  GEN     aarch64-softmmu/config-devices.mak.tmp
  GEN     aarch64-softmmu/config-devices.mak
  GEN     alpha-softmmu/config-devices.mak.tmp
  GEN     alpha-softmmu/config-devices.mak
  GEN     arm-softmmu/config-devices.mak.tmp
  GEN     arm-softmmu/config-devices.mak
  GEN     cris-softmmu/config-devices.mak.tmp
  GEN     cris-softmmu/config-devices.mak
  GEN     hppa-softmmu/config-devices.mak.tmp
  GEN     hppa-softmmu/config-devices.mak
  GEN     i386-softmmu/config-devices.mak.tmp
  GEN     i386-softmmu/config-devices.mak
  GEN     lm32-softmmu/config-devices.mak.tmp
  GEN     lm32-softmmu/config-devices.mak
  GEN     m68k-softmmu/config-devices.mak.tmp
  GEN     m68k-softmmu/config-devices.mak
  GEN     microblaze-softmmu/config-devices.mak.tmp
  GEN     microblaze-softmmu/config-devices.mak
  GEN     microblazeel-softmmu/config-devices.mak.tmp
  GEN     microblazeel-softmmu/config-devices.mak
  GEN     mips-softmmu/config-devices.mak.tmp
  GEN     mips-softmmu/config-devices.mak
  GEN     mips64-softmmu/config-devices.mak.tmp
  GEN     mips64-softmmu/config-devices.mak
  GEN     mips64el-softmmu/config-devices.mak.tmp
  GEN     mips64el-softmmu/config-devices.mak
  GEN     mipsel-softmmu/config-devices.mak.tmp
  GEN     mipsel-softmmu/config-devices.mak
  GEN     moxie-softmmu/config-devices.mak.tmp
  GEN     moxie-softmmu/config-devices.mak
  GEN     nios2-softmmu/config-devices.mak.tmp
  GEN     nios2-softmmu/config-devices.mak
  GEN     or1k-softmmu/config-devices.mak.tmp
  GEN     or1k-softmmu/config-devices.mak
  GEN     ppc-softmmu/config-devices.mak.tmp
  GEN     ppc-softmmu/config-devices.mak
  GEN     ppc64-softmmu/config-devices.mak.tmp
  GEN     ppc64-softmmu/config-devices.mak
  GEN     riscv32-softmmu/config-devices.mak.tmp
  GEN     riscv32-softmmu/config-devices.mak
  GEN     riscv64-softmmu/config-devices.mak.tmp
  GEN     riscv64-softmmu/config-devices.mak
  GEN     s390x-softmmu/config-devices.mak.tmp
  GEN     s390x-softmmu/config-devices.mak
  GEN     sh4-softmmu/config-devices.mak.tmp
  GEN     sh4-softmmu/config-devices.mak
  GEN     sh4eb-softmmu/config-devices.mak.tmp
  GEN     sh4eb-softmmu/config-devices.mak
  GEN     sparc-softmmu/config-devices.mak.tmp
  GEN     sparc-softmmu/config-devices.mak
  GEN     sparc64-softmmu/config-devices.mak.tmp
  GEN     sparc64-softmmu/config-devices.mak
  GEN     tricore-softmmu/config-devices.mak.tmp
  GEN     tricore-softmmu/config-devices.mak
  GEN     unicore32-softmmu/config-devices.mak.tmp
  GEN     unicore32-softmmu/config-devices.mak
  GEN     x86_64-softmmu/config-devices.mak.tmp
  GEN     x86_64-softmmu/config-devices.mak
  GEN     xtensa-softmmu/config-devices.mak.tmp
  GEN     xtensa-softmmu/config-devices.mak
  GEN     xtensaeb-softmmu/config-devices.mak.tmp
  GEN     xtensaeb-softmmu/config-devices.mak
  GEN     config-all-devices.mak
  GEN     config-host.h
make[1]: Entering directory '/home/rtrk/qemu-tot/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/rtrk/qemu-tot/slirp'
make[1]: *** No rule to make target 'libfdt/libfdt.a'.  Stop.
Makefile:456: recipe for target 'subdir-dtc' failed
make: *** [subdir-dtc] Error 2


rtrk@rtrkw774-lin:~/qemu-tot$ git log --oneline -50 --reverse
b74b1ad iotests: use iotests.VM in 238
af39bd0 qcow2: Default to 4KB for the qcow2 cache entry size
ce090f6 iotests: open notrun files in text mode
9ac404c block: iterate_format with account of whitelisting
57ed557 iotests: ask QEMU for supported formats
d9df28e iotests: check whitelisted formats
a03700f tests/multiboot: Improve portability by searching bash in the $PATH
d683758 tests/bios-tables: Improve portability by searching bash in the $PA=
TH
11a82d1 qemu-iotests: Improve portability by searching bash in the $PATH
bde36af qemu-iotests: Ensure GNU sed is used
97f94cb qemu-iotests: Test qcow2 preallocation modes
c5e86eb qcow2: Simplify preallocation code
65a3d07 qcow2: Extend spec for external data files
93c2493 qcow2: Basic definitions for external data files
808c2bb qcow2: Pass bs to qcow2_get_cluster_type()
a4ea184 qcow2: Prepare qcow2_get_cluster_type() for external data file
b8c8353 qcow2: Prepare count_contiguous_clusters() for external data file
c6d619c qcow2: Don't assume 0 is an invalid cluster offset
77e023f qcow2: Return 0/-errno in qcow2_alloc_compressed_cluster_offset()
37be140 qcow2: Prepare qcow2_co_block_status() for data file
966b000 qcow2: External file I/O
aa8b34c qcow2: Return error for snapshot operation with data file
e9f5b6d qcow2: Support external data file in qemu-img check
0e8c08b qcow2: Add basic data-file infrastructure
dcc9868 qcow2: Creating images with external data file
9b890bd qcow2: Store data file name in the image
6c3944d qcow2: Implement data-file-raw create option
c35896c qemu-iotests: Preallocation with external data file
76b90e2 qemu-iotests: General tests for qcow2 with external data file
ac40260 qemu-iotests: amend with external data file
377213f ahci-test: Add dependency to qemu-img tool
9c2b28e qemu-iotests: Add dependency to qemu-nbd tool
e88153e qcow2 spec: Describe string header extensions
6bbbe16 Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault=
' into staging
06a1564 Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream-qgr=
aph' into staging
62cfabb Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20190307' =
into staging
234afe7 Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request=
-2019-03-08' into staging
1eb5da3 Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore=
-2019-03-08' into staging
4c76137 Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into=
 staging
f5b4c31 Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-requ=
est' into staging
e2a1863 Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-0=
8' into staging
633786f Reduce curses escdelay from 1s to 25ms
459a707 curses: support wide input
bbcdeb6 vnc: fix update stalls
55cf09a vnc: allow specifying a custom authorization object name
0143840 monitor: deprecate acl_show, acl_reset, acl_policy, acl_add, acl_re=
move
1290e67 Makefile: Fix Sphinx documentation builds for in-tree builds
81f3340 Makefile: Fix 'make distclean'
336cfef Makefile: Don't install non-sphinx files in sphinx docs install
79d8b1d Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190311-v2-pu=
ll-request' into staging
