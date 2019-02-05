Received: from eggs.gnu.org ([209.51.188.92]:41430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGX-0006Dx-Mk
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGV-0004EC-N3
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:54236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gqvGR-0004CU-P6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gqvGQ-0000vH-5N
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:35:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 21C342E8033
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 07:35:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Feb 2019 07:23:50 -0000
From: Thomas Huth <1545024@bugs.launchpad.net>
Reply-To: Bug 1545024 <1545024@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160212151339.32708.72568.malonedeb@gac.canonical.com>
Message-Id: <154935143094.31409.16159299515528756520.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1545024] Re: compiling on armv7 crashes compile
 qlx.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1545024

Title:
  compiling on armv7 crashes compile qlx.o

Status in QEMU:
  Incomplete

Bug description:
  If i try to compile qemu on armv7 cpu i get this error:

    LINK  qemu-nbd
    CC    qemu-img.o
    LINK  qemu-img
    LINK  qemu-io
    LINK  qemu-bridge-helper
    CC    qmp-marshal.o
    CC    hw/display/qxl.o
  {standard input}: Assembler messages:
  {standard input}:1704: Error: bad instruction `lock'
  {standard input}:1704: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:1864: Error: bad instruction `lock'
  {standard input}:1864: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:5239: Error: bad instruction `lock'
  {standard input}:5239: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:5731: Error: bad instruction `lock'
  {standard input}:5731: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:11923: Error: bad instruction `lock'
  {standard input}:11923: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:13960: Error: bad instruction `lock'
  {standard input}:13960: Error: bad instruction `addl $0,0(%rsp)'
  {standard input}:14349: Error: bad instruction `lock'
  {standard input}:14349: Error: bad instruction `addl $0,0(%rsp)'
  /home/fleixi/git/qemu/rules.mak:57: recipe for target 'hw/display/qxl.o' =
failed
  make: *** [hw/display/qxl.o] Error 1

  Build options are:

   ./configure --target-list=3Di386-softmmu
  Install prefix    /usr/local
  BIOS directory    /usr/local/share/qemu
  binary directory  /usr/local/bin
  library directory /usr/local/lib
  module directory  /usr/local/lib/qemu
  libexec directory /usr/local/libexec
  include directory /usr/local/include
  config directory  /usr/local/etc
  local state directory   /usr/local/var
  Manual directory  /usr/local/share/man
  ELF interp prefix /usr/gnemul/qemu-%M
  Source path       /home/fleixi/git/qemu
  C compiler        cc
  Host C compiler   cc
  C++ compiler      c++
  Objective-C compiler cc
  ARFLAGS           rv
  CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -pthread -I=
/usr/include/glib-2.0 -I/usr/lib/arm-linux-gnueabihf/glib-2.0/include  -g -=
mcpu=3Dcortex-a15.cortex-a7 -mfloat-abi=3Dhard -mfpu=3Dneon-vfpv4 -O2 -pipe=
 -ffast-math -ftree-vectorize -mvectorize-with-neon-quad -fstack-protector =
--param=3Dssp-buffer-size=3D4
  QEMU_CFLAGS       -I/usr/include/pixman-1   -Werror  -D_GNU_SOURCE -D_FIL=
E_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decl=
s -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -=
fno-common  -Wendif-labels -Wmissing-include-dirs -Wempty-body -Wnested-ext=
erns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-=
style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-st=
rong   -I/usr/include/libpng12  -I/usr/local/include/spice-server -I/usr/lo=
cal/include -I/usr/local/include/spice-1 -I/usr/include/glib-2.0 -I/usr/lib=
/arm-linux-gnueabihf/glib-2.0/include -I/usr/include/pixman-1 =

  LDFLAGS           -Wl,--warn-common -g =

  make              make
  install           install
  python            python -B
  smbd              /usr/sbin/smbd
  module support    no
  host CPU          arm
  host big endian   no
  target list       i386-softmmu
  tcg debug enabled no
  gprof enabled     no
  sparse enabled    no
  strip binaries    yes
  profiler          no
  static build      no
  pixman            system
  SDL support       no
  GTK support       yes
  GTK GL support    no
  GNUTLS support    no
  GNUTLS hash       no
  libgcrypt         no
  nettle            no
  libtasn1          no
  VTE support       no
  curses support    no
  virgl support     no
  curl support      yes
  mingw32 support   no
  Audio drivers     oss
  Block whitelist (rw) =

  Block whitelist (ro) =

  VirtFS support    no
  VNC support       yes
  VNC SASL support  yes
  VNC JPEG support  yes
  VNC PNG support   yes
  xen support       no
  brlapi support    no
  bluez  support    yes
  Documentation     no
  PIE               no
  vde support       no
  netmap support    no
  Linux AIO support no
  ATTR/XATTR support yes
  Install blobs     yes
  KVM support       yes
  RDMA support      no
  TCG interpreter   no
  fdt support       no
  preadv support    yes
  fdatasync         yes
  madvise           yes
  posix_madvise     yes
  sigev_thread_id   yes
  uuid support      no
  libcap-ng support no
  vhost-net support yes
  vhost-scsi support yes
  Trace backends    log
  spice support     yes (0.12.10/0.12.6)
  rbd support       no
  xfsctl support    no
  smartcard support no
  libusb            no
  usb net redir     no
  OpenGL support    no
  libiscsi support  no
  libnfs support    no
  build guest agent yes
  QGA VSS support   no
  QGA w32 disk info no
  QGA MSI support   no
  seccomp support   no
  coroutine backend ucontext
  coroutine pool    yes
  GlusterFS support no
  Archipelago support no
  gcov              gcov
  gcov enabled      no
  TPM support       yes
  libssh2 support   no
  TPM passthrough   no
  QOM debugging     yes
  vhdx              no
  lzo support       no
  snappy support    no
  bzip2 support     yes
  NUMA host support no
  tcmalloc support  no
  jemalloc support  no

  testet with  qemu-git branch stable-2.4 and git master

  Shoulded the configure detecting "bigendian" too?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1545024/+subscriptions
