Received: from eggs.gnu.org ([2001:4830:134:3::10]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dPi8K-0001X8-Ho
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dPi8H-00078Q-DM
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:29:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:54527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dPi8H-00078E-6o
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:29:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dPi8E-0001sK-Dp
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 04:29:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 49A1A2E81BA
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 04:29:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jun 2017 04:17:26 -0000
From: Launchpad Bug Tracker <1081416@bugs.launchpad.net>
Reply-To: Bug 1081416 <1081416@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121121031428.20160.15867.malonedeb@wampee.canonical.com>
Message-Id: <149853704673.21109.11493549410335418424.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1081416] Re: Qemu 1.2.0 crashes when using tcp
 serial console and GRUB boots
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
https://bugs.launchpad.net/bugs/1081416

Title:
  Qemu 1.2.0 crashes when using tcp serial console and GRUB boots

Status in QEMU:
  Expired

Bug description:
  When booting OpenWRT Attitude Adjustement ( http://downloads.openwrt.org/=
attitude_adjustment/12.09-beta2/x86/generic/openwrt-x86-generic-combined-ex=
t4.img.gz ) with this command line:
  qemu-system-x86_64 -serial tcp:127.0.0.1:4444 -hda openwrt-x86-generic-co=
mbined-ext4.img

  Qemu crashes as soon as GRUB starts, after network cards start.

  *** buffer overflow detected ***: /usr/bin/qemu-system-x86_64 terminated
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /usr/lib/libc.so.6(__fortify_fail+0x37)[0x7ffff45f2ad7]
  /usr/lib/libc.so.6(+0xf9bb0)[0x7ffff45f0bb0]
  /usr/lib/libc.so.6(+0xfba47)[0x7ffff45f2a47]
  /usr/bin/qemu-system-x86_64[0x46a628]
  /usr/bin/qemu-system-x86_64[0x4e8a14]
  /usr/bin/qemu-system-x86_64[0x4e802b]
  /usr/lib/libc.so.6(__libc_start_main+0xf5)[0x7ffff4518725]
  /usr/bin/qemu-system-x86_64[0x40d949]

  =

  Here is a GDB backtrace:

  Program received signal SIGABRT, Aborted.
  0x00007ffff452bfa5 in raise () from /usr/lib/libc.so.6
  (gdb) bt
  #0  0x00007ffff452bfa5 in raise () from /usr/lib/libc.so.6
  #1  0x00007ffff452d428 in abort () from /usr/lib/libc.so.6
  #2  0x00007ffff456acfb in __libc_message () from /usr/lib/libc.so.6
  #3  0x00007ffff45f2ad7 in __fortify_fail () from /usr/lib/libc.so.6
  #4  0x00007ffff45f0bb0 in __chk_fail () from /usr/lib/libc.so.6
  #5  0x00007ffff45f2a47 in __fdelt_warn () from /usr/lib/libc.so.6
  #6  0x000000000046a628 in qemu_iohandler_poll (readfds=3D0xdb7da0 <rfds>, =

      writefds=3D0xdb7e20 <wfds>, xfds=3D0x6, xfds@entry=3D0xdb7ea0 <xfds>,=
 ret=3D-1, =

      ret@entry=3D1) at iohandler.c:121
  #7  0x00000000004e8a14 in main_loop_wait (nonblocking=3D<optimized out>)
      at main-loop.c:497
  #8  0x00000000004e802b in main_loop ()
      at /usr/src/aur/qemu/src/qemu-1.2.0/vl.c:1643
  #9  main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>)
      at /usr/src/aur/qemu/src/qemu-1.2.0/vl.c:3755
  (gdb) =


  Here is a more useless dump...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1081416/+subscriptions
