Received: from eggs.gnu.org ([2001:4830:134:3::10]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCKWR-0001LE-NM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCKWM-0007O3-Pi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:11:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCKWM-0007Nb-G0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:11:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCKWL-0007SJ-EF
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:11:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 62AB22E8059
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 07:11:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 06:59:24 -0000
From: Dmitry <354554@gmail.com>
Reply-To: Bug 1268279 <1268279@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140112093140.25014.62573.malonedeb@chaenomeles.canonical.com>
	<150919889491.4565.7842826674061681988.malone@gac.canonical.com>
Message-Id: <CAGN1iHr+J_61y=ZFD=DGcpwuyezp46RAH_MVA4g7bTx0k9P46A@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1268279] Re: Windows 7 x86 does not start on
 1.7.50 from git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ticket have to been closed

2017-10-28 16:54 GMT+03:00 Thomas Huth <1268279@bugs.launchpad.net>:

> Triaging old bug tickets... can you still reproduce this issue with the
> latest version of QEMU? Or could we close this ticket nowadays?
>
> ** Changed in: qemu
>        Status: New =3D> Incomplete
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1268279
>
> Title:
>   Windows 7 x86 does not start on 1.7.50 from git
>
> Status in QEMU:
>   Incomplete
>
> Bug description:
>   I have "Debian 7.2 x64".
>
>   Install last QEMU from git:
>
>   aptitude install git gcc make autoconf libglib2.0-dev libcurl4-gnutls-
>   dev libpixman-1-dev libcap-dev  libaio-dev libcap-ng-dev libjpeg8-dev
>   libpng12-dev libssh2-1-dev uuid-dev
>
>   #cd /usr/src
>   #git clone git://git.qemu.org/qemu.git
>   #cd qemu
>   # ./configure --prefix=3D/usr  --sysconfdir=3D/etc
> --target-list=3Dx86_64-softmmu  --enable-kvm
>   Install prefix    /usr
>   BIOS directory    /usr/share/qemu
>   binary directory  /usr/bin
>   library directory /usr/lib
>   libexec directory /usr/libexec
>   include directory /usr/include
>   config directory  /etc
>   local state directory   /usr/var
>   Manual directory  /usr/share/man
>   ELF interp prefix /usr/gnemul/qemu-%M
>   Source path       /usr/src/qemu
>   C compiler        cc
>   Host C compiler   cc
>   C++ compiler      c++
>   Objective-C compiler cc
>   ARFLAGS           rv
>   CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
>   QEMU_CFLAGS       -Werror -fPIE -DPIE -m64 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing  -Wendif-labels -Wmissing-include-dirs -Wempty-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
> -Wtype-limits -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12     -I/usr/include/pixman-1
>   LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
>   make              make
>   install           install
>   python            python -B
>   smbd              /usr/sbin/smbd
>   host CPU          x86_64
>   host big endian   no
>   target list       x86_64-softmmu
>   tcg debug enabled no
>   gprof enabled     no
>   sparse enabled    no
>   strip binaries    yes
>   profiler          no
>   static build      no
>   -Werror enabled   yes
>   pixman            system
>   SDL support       yes
>   GTK support       no
>   curses support    no
>   curl support      yes
>   mingw32 support   no
>   Audio drivers     oss
>   Block whitelist (rw)
>   Block whitelist (ro)
>   VirtFS support    yes
>   VNC support       yes
>   VNC TLS support   yes
>   VNC SASL support  no
>   VNC JPEG support  yes
>   VNC PNG support   yes
>   VNC WS support    yes
>   xen support       no
>   brlapi support    no
>   bluez  support    no
>   Documentation     yes
>   GUEST_BASE        yes
>   PIE               yes
>   vde support       no
>   netmap support    no
>   Linux AIO support yes
>   ATTR/XATTR support yes
>   Install blobs     yes
>   KVM support       yes
>   RDMA support      no
>   TCG interpreter   no
>   fdt support       no
>   preadv support    yes
>   fdatasync         yes
>   madvise           yes
>   posix_madvise     yes
>   sigev_thread_id   yes
>   uuid support      yes
>   libcap-ng support yes
>   vhost-net support yes
>   vhost-scsi support yes
>   Trace backend     nop
>   Trace output file trace-<pid>
>   spice support     no (/)
>   rbd support       no
>   xfsctl support    no
>   nss used          no
>   libusb            no
>   usb net redir     no
>   GLX support       yes
>   libiscsi support  no
>   build guest agent yes
>   QGA VSS support   no
>   seccomp support   no
>   coroutine backend ucontext
>   coroutine pool    yes
>   GlusterFS support no
>   virtio-blk-data-plane yes
>   gcov              gcov
>   gcov enabled      no
>   TPM support       no
>   libssh2 support   yes
>   TPM passthrough   no
>   QOM debugging     yes
>   vhdx              yes
>   #make && make install
>
>   QEMU is successfully builded and installed:
>
>   # /usr/bin/qemu-system-x86_64 --version
>   QEMU emulator version 1.7.50, Copyright (c) 2003-2008 Fabrice Bellard
>
>   Create virtual HDD:
>
>   # qemu-img create -f qcow2 /kvm/vm/test.img 50G
>   Formatting '/kvm/vm/test.img', fmt=3Dqcow2 size=3D53687091200 encryptio=
n=3Doff
> cluster_size=3D65536 lazy_refcounts=3Doff
>
>   Start virtual machine:
>
>    # /usr/bin/qemu-system-x86_64 -cpu qemu64 -M pc -smp 1 -m 1024
>   -monitor tcp:127.0.0.1:4444,server,nowait -drive
>   file=3D/kvm/vm/test.img,cache=3Dwriteback,aio=3Dnative -boot
>   order=3Ddc,menu=3Don -enable-kvm -vnc 127.0.0.1:14 -localtime -no-hpet
>   -rtc-td-hack -global kvm-pit.lost_tick_policy=3Ddiscard -daemonize -usb
>   -device usb-tablet,id=3Dinput0 -runas kvm
>
>   Connect ISO image:
>
>   # nc 127.0.0.1 4444
>   QEMU 1.7.50 monitor - type 'help' for more information
>   (qemu) change ide1-cd0 http://someiso.host.com/ru_
> windows_7_professional_with_sp1_x86_dvd.iso
>   change ide1-cd0 http://someiso.host.com/ru_windows_7_professional_with_
> sp1_x86_dvd.iso
>   (qemu)
>
>   Open NVC console to VM, reboot and boot (F12) from connected ISO.
>   Windows installation start and successfully goes to first reboot.
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   After reboot it hangs on "Starting windows" with 100%  load on one of
> CPU cores for many hours.
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Other Windows OS (XP, Server 2003, Server 2008 R2) are installed and
>   work good.
>
>   Is this a QEMU BUG? Could you please try reproduce it?
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1268279/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1268279

Title:
  Windows 7 x86 does not start on 1.7.50 from git

Status in QEMU:
  Incomplete

Bug description:
  I have "Debian 7.2 x64".

  Install last QEMU from git:

  aptitude install git gcc make autoconf libglib2.0-dev libcurl4-gnutls-
  dev libpixman-1-dev libcap-dev  libaio-dev libcap-ng-dev libjpeg8-dev
  libpng12-dev libssh2-1-dev uuid-dev

  #cd /usr/src
  #git clone git://git.qemu.org/qemu.git
  #cd qemu
  # ./configure --prefix=3D/usr  --sysconfdir=3D/etc --target-list=3Dx86_64=
-softmmu  --enable-kvm
  Install prefix    /usr
  BIOS directory    /usr/share/qemu
  binary directory  /usr/bin
  library directory /usr/lib
  libexec directory /usr/libexec
  include directory /usr/include
  config directory  /etc
  local state directory   /usr/var
  Manual directory  /usr/share/man
  ELF interp prefix /usr/gnemul/qemu-%M
  Source path       /usr/src/qemu
  C compiler        cc
  Host C compiler   cc
  C++ compiler      c++
  Objective-C compiler cc
  ARFLAGS           rv
  CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
  QEMU_CFLAGS       -Werror -fPIE -DPIE -m64 -D_GNU_SOURCE -D_FILE_OFFSET_B=
ITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -W=
undef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing  -Wendif-la=
bels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-security=
 -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wol=
d-style-definition -Wtype-limits -fstack-protector-all -I/usr/include/p11-k=
it-1    -I/usr/include/libpng12     -I/usr/include/pixman-1
  LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g
  make              make
  install           install
  python            python -B
  smbd              /usr/sbin/smbd
  host CPU          x86_64
  host big endian   no
  target list       x86_64-softmmu
  tcg debug enabled no
  gprof enabled     no
  sparse enabled    no
  strip binaries    yes
  profiler          no
  static build      no
  -Werror enabled   yes
  pixman            system
  SDL support       yes
  GTK support       no
  curses support    no
  curl support      yes
  mingw32 support   no
  Audio drivers     oss
  Block whitelist (rw)
  Block whitelist (ro)
  VirtFS support    yes
  VNC support       yes
  VNC TLS support   yes
  VNC SASL support  no
  VNC JPEG support  yes
  VNC PNG support   yes
  VNC WS support    yes
  xen support       no
  brlapi support    no
  bluez  support    no
  Documentation     yes
  GUEST_BASE        yes
  PIE               yes
  vde support       no
  netmap support    no
  Linux AIO support yes
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
  uuid support      yes
  libcap-ng support yes
  vhost-net support yes
  vhost-scsi support yes
  Trace backend     nop
  Trace output file trace-<pid>
  spice support     no (/)
  rbd support       no
  xfsctl support    no
  nss used          no
  libusb            no
  usb net redir     no
  GLX support       yes
  libiscsi support  no
  build guest agent yes
  QGA VSS support   no
  seccomp support   no
  coroutine backend ucontext
  coroutine pool    yes
  GlusterFS support no
  virtio-blk-data-plane yes
  gcov              gcov
  gcov enabled      no
  TPM support       no
  libssh2 support   yes
  TPM passthrough   no
  QOM debugging     yes
  vhdx              yes
  #make && make install

  QEMU is successfully builded and installed:

  # /usr/bin/qemu-system-x86_64 --version
  QEMU emulator version 1.7.50, Copyright (c) 2003-2008 Fabrice Bellard

  Create virtual HDD:

  # qemu-img create -f qcow2 /kvm/vm/test.img 50G
  Formatting '/kvm/vm/test.img', fmt=3Dqcow2 size=3D53687091200 encryption=
=3Doff cluster_size=3D65536 lazy_refcounts=3Doff

  Start virtual machine:

  =C2=A0# /usr/bin/qemu-system-x86_64 -cpu qemu64 -M pc -smp 1 -m 1024
  -monitor tcp:127.0.0.1:4444,server,nowait -drive
  file=3D/kvm/vm/test.img,cache=3Dwriteback,aio=3Dnative -boot
  order=3Ddc,menu=3Don -enable-kvm -vnc 127.0.0.1:14 -localtime -no-hpet
  -rtc-td-hack -global kvm-pit.lost_tick_policy=3Ddiscard -daemonize -usb
  -device usb-tablet,id=3Dinput0 -runas kvm

  Connect ISO image:

  # nc 127.0.0.1 4444
  QEMU 1.7.50 monitor - type 'help' for more information
  (qemu) change ide1-cd0 http://someiso.host.com/ru_windows_7_professional_=
with_sp1_x86_dvd.iso
  change ide1-cd0 http://someiso.host.com/ru_windows_7_professional_with_sp=
1_x86_dvd.iso
  (qemu)

  Open NVC console to VM, reboot and boot (F12) from connected ISO.
  Windows installation start and successfully goes to first reboot.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  After reboot it hangs on "Starting windows" with 100%  load on one of CPU=
 cores for many hours.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Other Windows OS (XP, Server 2003, Server 2008 R2) are installed and
  work good.

  Is this a QEMU BUG? Could you please try reproduce it?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1268279/+subscriptions
