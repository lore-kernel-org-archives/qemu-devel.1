Received: from eggs.gnu.org ([2001:4830:134:3::10]:50716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caETV-0003xY-Gx
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caETS-0007F1-QA
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:46453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caETS-0007Er-KE
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 23:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caETR-0006pz-Cs
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 04:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A4262E80CD
	for <qemu-devel@nongnu.org>; Sun,  5 Feb 2017 04:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Feb 2017 04:17:37 -0000
From: Launchpad Bug Tracker <1243639@bugs.launchpad.net>
Reply-To: Bug 1243639 <1243639@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131023102254.14749.56805.malonedeb@wampee.canonical.com>
Message-Id: <20170205041737.20738.4424.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1243639] Re: qemu-1.5.3 segment fault with -vga
 qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1243639

Title:
  qemu-1.5.3   segment fault  with  -vga qxl

Status in QEMU:
  Expired

Bug description:
  execute " qemu-system-x86_64    -enable-kvm -machine accel=3Dkvm:tcg -m
  1G  -drive file=3D/dev/sda  --full-screen -spice
  addr=3D127.0.0.1,port=3D5900,disable-ticketing -vga qxl "  on shell will
  get  segment fault  after  a few seconds   if  I  don't connect to it
  with  spicec client  immediately.

  IF  excute  "spicec -h 127.0.0.1 -p 5900 "  immediately !!!!    after
  the  qemu-system-x86_64  execution, then  no segment fault happens
  and  it runs well.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  GDB output:

  root@kali-john:~# gdb /usr/local/bin/qemu-system-x86_64
  GNU gdb (GDB) 7.4.1-debian
  (gdb) run -enable-kvm -machine accel=3Dkvm:tcg -m 1G  -drive file=3D/dev/=
sda  --full-screen -spice addr=3D127.0.0.1,port=3D5900,disable-ticketing -v=
ga qxl

  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7ffff3737700 (LWP 14797)]
  [New Thread 0x7ffff2d54700 (LWP 14798)]
  [New Thread 0x7ffff0fff700 (LWP 14799)]

  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff683ad70 in pixman_image_get_data () from /usr/lib/x86_64-linux=
-gnu/libpixman-1.so.0
  (gdb) bt
  #0  0x00007ffff683ad70 in pixman_image_get_data () from /usr/lib/x86_64-l=
inux-gnu/libpixman-1.so.0
  #1  0x000055555581060a in surface_data (s=3D0x5555566183a0) at /zh-downlo=
ad/QEMU/qemu-1.5.3/include/ui/console.h:235
  #2  0x0000555555818616 in vga_draw_graphic (s=3D0x55555662c778, full_upda=
te=3D1) at /zh-download/QEMU/qemu-1.5.3/hw/display/vga.c:1788
  #3  0x0000555555818c6a in vga_update_display (opaque=3D0x55555662c778) at=
 /zh-download/QEMU/qemu-1.5.3/hw/display/vga.c:1917
  #4  0x000055555580eb15 in qxl_hw_update (opaque=3D0x55555662bd70) at /zh-=
download/QEMU/qemu-1.5.3/hw/display/qxl.c:1766
  #5  0x00005555557bd6bc in graphic_hw_update (con=3D0x555556618d00) at ui/=
console.c:254
  #6  0x00005555557c8426 in qemu_spice_display_refresh (ssd=3D0x55555662c41=
8) at ui/spice-display.c:417
  #7  0x000055555580eff0 in display_refresh (dcl=3D0x55555662c420) at /zh-d=
ownload/QEMU/qemu-1.5.3/hw/display/qxl.c:1886
  #8  0x00005555557c0cb1 in dpy_refresh (s=3D0x555556618370) at ui/console.=
c:1436
  #9  0x00005555557bd3af in gui_update (opaque=3D0x555556618370) at ui/cons=
ole.c:192
  #10 0x0000555555797f20 in qemu_run_timers (clock=3D0x5555565b5a30) at qem=
u-timer.c:394
  #11 0x0000555555798183 in qemu_run_all_timers () at qemu-timer.c:453
  #12 0x0000555555760bb7 in main_loop_wait (nonblocking=3D0) at main-loop.c=
:470
  #13 0x00005555557cd19c in main_loop () at vl.c:2029
  #14 0x00005555557d43f2 in main (argc=3D13, argv=3D0x7fffffffe2b8, envp=3D=
0x7fffffffe328) at vl.c:4419
  (gdb) =


  =

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  http://www.spice-space.org/download/releases/spice-0.12.4.tar.bz2
  http://www.spice-space.org/download/releases/spice-protocol-0.12.6.tar.bz2
  spice  compiling =

        ./configure --enable-smartcard=3Dno   && make

  qemu-1.5.3
  compiling =

      ./configure \
  --disable-strip  --enable-debug \
  --target-list=3Dx86_64-softmmu,x86_64-linux-user  \
  --disable-sdl  --audio-drv-list=3Dalsa --disable-vnc --disable-xen --disa=
ble-libiscsi  \
  	--disable-seccomp --disable-glusterfs --disable-libssh2 --disable-smartc=
ard-nss  \
  	--disable-usb-redir --disable-brlapi --disable-curl  --disable-bsd-user =
		    \
    \
  --enable-kvm --enable-spice --enable-system --enable-guest-agent --enable=
-vhost-net =


  =

  root@kali-john:~# qemu-system-x86_64 -version
  QEMU emulator version 1.5.3, Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1243639/+subscriptions
