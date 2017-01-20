Received: from eggs.gnu.org ([2001:4830:134:3::10]:56074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUb9d-0006gI-Hc
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUb9Y-0002sv-Jp
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:31:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:42201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUb9Y-0002sM-BA
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:31:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUb9W-00088h-H5
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 15:30:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CEF1D2E81A1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 15:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 15:22:18 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1657538 <1657538@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170118175149.27340.89188.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170120152218.21476.11926.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657538] Re: qemu 2.7.x 2.8 softmmu dont work on
 BE machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Thomas,
here the configure .. i made a clean one just with the target for have fast=
est build =

will report soon the result with the nographic just the time of build

src/qemu$ ./configure  --target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu
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
Source path       /home/amigaone/src/qemu
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g =

QEMU_CFLAGS       -I/usr/include/pixman-1    -Werror -DHAS_LIBSSH2_SFTP_FSY=
NC -pthread -I/usr/include/glib-2.0 -I/usr/lib/powerpc-linux-gnu/glib-2.0/i=
nclude   -D_GNU_SOURCE -I/usr/include/ncursesw   -m32 -D_GNU_SOURCE -D_FILE=
_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls=
 -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -f=
no-common -fwrapv  -Wendif-labels -Wno-shift-negative-value -Wmissing-inclu=
de-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit=
-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -=
Wtype-limits -fstack-protector-strong      -I/usr/local/include/libpng12   =
-I/usr/local/include/cacard -I/usr/include/nss -I/usr/include/nspr   -I/usr=
/include/libusb-1.0    =

LDFLAGS           -Wl,--warn-common -m32 -g =

make              make
install           install
python            python -B
smbd              /usr/sbin/smbd
module support    no
host CPU          ppc
host big endian   yes
target list       i386-softmmu ppc-softmmu ppc64-softmmu
tcg debug enabled no
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
pixman            system
SDL support       yes (1.2.15)
GTK support       yes (2.24.30)
GTK GL support    no
VTE support       no =

TLS priority      NORMAL
GNUTLS support    no
GNUTLS rnd        no
libgcrypt         yes
libgcrypt kdf     yes
nettle            no =

nettle kdf        no
libtasn1          no
curses support    yes
virgl support     yes
curl support      yes
mingw32 support   no
Audio drivers     oss
Block whitelist (rw) =

Block whitelist (ro) =

VirtFS support    yes
VNC support       yes
VNC SASL support  yes
VNC JPEG support  yes
VNC PNG support   yes
xen support       no
brlapi support    yes
bluez  support    yes
Documentation     yes
PIE               no
vde support       no
netmap support    no
Linux AIO support yes
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
COLO support      yes
RDMA support      yes
TCG interpreter   no
fdt support       yes
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
libcap-ng support yes
vhost-net support yes
vhost-scsi support yes
vhost-vsock support yes
Trace backends    log
spice support     no =

rbd support       yes
xfsctl support    yes
smartcard support yes
libusb            yes
usb net redir     yes
OpenGL support    yes
OpenGL dmabufs    yes
libiscsi support  yes
libnfs support    yes
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   yes
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
GlusterFS support no
Archipelago support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh2 support   yes
TPM passthrough   no
QOM debugging     yes
lzo support       yes
snappy support    yes
bzip2 support     yes
NUMA host support yes
tcmalloc support  no
jemalloc support  no
avx2 optimization no
replication support yes

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657538

Title:
  qemu 2.7.x 2.8 softmmu dont work on BE machine

Status in QEMU:
  New

Bug description:
  Build on Be machine qemu 2.7.1 and 2.8 in pure softmmu (tgc) dont work on=
 big endian hardware .
  tested with ppc-softmmu,i386-softmmu,arm-softmmu same result:

  with :
   ./qemu-system-i386 =

  Gtk-Message: Failed to load module "overlay-scrollbar"
  qemu-system-i386: Trying to execute code outside RAM or ROM at 0x000a0000
  This usually means one of the following happened:

  (1) You told QEMU to execute a kernel for the wrong machine type, and it =
crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb=
 QEMU machine)
  (2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU execu=
ted a ROM full of no-op instructions until it fell off the end
  (3) Your guest kernel has a bug and crashed by jumping off into nowhere

  This is almost always one of the first two, so check your command line an=
d that you are using the right type of kernel for this machine.
  If you think option (3) is likely then you can try debugging your guest w=
ith the -d debug options; in particular -d guest_errors will cause the log =
to include a dump of the guest register state at this point.

  Execution cannot continue; stopping here.

  =

  I try to add the -L option with ../pc-bios/bios.bin =

  and have the same result.

  note the ppc-softmmu and ppc64-softmmu work in kvm mode only emulated
  mode have issue.

  =

  tested on my hardware a  Qriq P5040 and G5 4x970MP with Ubuntu Mate 16.10 =

  thanks
  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657538/+subscriptions
