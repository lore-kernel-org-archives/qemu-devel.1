Received: from eggs.gnu.org ([2001:4830:134:3::10]:35351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caawQ-00012f-Ea
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caawM-0007qS-NH
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:54061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caawM-0007pI-Gr
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 23:30:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caawJ-0000ao-Hu
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 04:30:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B9172E80DD
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 04:30:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 04:17:35 -0000
From: Launchpad Bug Tracker <584516@bugs.launchpad.net>
Reply-To: Bug 584516 <584516@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100523103713.1735.66820.malonedeb@palladium.canonical.com>
Message-Id: <20170206041735.23021.87724.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 584516] Re: opensuse 11.2 guest hangs after live
 migration with clocksource=kvm-clock
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
https://bugs.launchpad.net/bugs/584516

Title:
  opensuse 11.2 guest hangs after live migration with clocksource=3Dkvm-
  clock

Status in QEMU:
  Expired

Bug description:
  i would like to debug a problem that I encountered some time ago with ope=
nsuse 11.2 and also
  with Ubuntu (karmic/lucid).

  If I run an opensuse guest 64-bit and do not touch the clocksource settin=
gs the guest almost
  everytime hangs after live migration at:

  (gdb) thread apply all bt

  Thread 2 (Thread 0x7f846782a950 (LWP 27356)):
  #0  0x00007f8467d24cd7 in ioctl () from /lib/libc.so.6
  #1  0x000000000042b945 in kvm_run (env=3D0x2468170)
    at /usr/src/qemu-kvm-0.12.4/qemu-kvm.c:921
  #2  0x000000000042cea2 in kvm_cpu_exec (env=3D0x2468170)
    at /usr/src/qemu-kvm-0.12.4/qemu-kvm.c:1651
  #3  0x000000000042d62c in kvm_main_loop_cpu (env=3D0x2468170)
    at /usr/src/qemu-kvm-0.12.4/qemu-kvm.c:1893
  #4  0x000000000042d76d in ap_main_loop (_env=3D0x2468170)
    at /usr/src/qemu-kvm-0.12.4/qemu-kvm.c:1943
  #5  0x00007f8468caa3ba in start_thread () from /lib/libpthread.so.0
  #6  0x00007f8467d2cfcd in clone () from /lib/libc.so.6
  #7  0x0000000000000000 in ?? ()

  Thread 1 (Thread 0x7f84692d96f0 (LWP 27353)):
  #0  0x00007f8467d25742 in select () from /lib/libc.so.6
  #1  0x000000000040c25a in main_loop_wait (timeout=3D1000)
    at /usr/src/qemu-kvm-0.12.4/vl.c:3994
  #2  0x000000000042dcf1 in kvm_main_loop ()
    at /usr/src/qemu-kvm-0.12.4/qemu-kvm.c:2126
  #3  0x000000000040c98c in main_loop () at /usr/src/qemu-kvm-0.12.4/vl.c:4=
212
  #4  0x000000000041054b in main (argc=3D31, argv=3D0x7fffa91351c8,
    envp=3D0x7fffa91352c8) at /usr/src/qemu-kvm-0.12.4/vl.c:6252

  If I run the same guest with kernel parameter clocksource=3Dacpi_pm, the
  migration succeeds reliably.

  The hosts runs:
  /kernel: /2.6.33.3, /bin: /qemu-kvm-0.12.4, /mod: /2.6.33.3

  I invoke qemu-kvm with:
  /usr/bin/qemu-kvm-0.12.4  -net none  -drive file=3D/dev/sdb,if=3Dide,boot=
=3Don,cache=3Dnone,aio=3Dnative  -m 1024 -cpu qemu64,model_id=3D'Intel(R) X=
eon(R) CPU           E5430  @ 2.66GHz'  -monitor tcp:0:4001,server,nowait -=
vnc :1 -name 'test'  -boot order=3Ddc,menu=3Don  -k de  -pidfile /var/run/q=
emu/vm-149.pid  -mem-path /hugepages -mem-prealloc  -rtc base=3Dutc,clock=
=3Dvm -usb -usbdevice tablet

  The Guest is:
  OpenSuse 11.2 64-bit with Kernel 2.6.31.5-0.1-desktop #1 SMP PREEMPT 2009=
-10-26 15:49:03 +0100 x86_64
  The clocksource automatically choosen is kvm-clock.

  Feedback appreciated. I have observed the same problem with 0.12.2 and
  also with old binaries provided by Ubuntu Karmic (kvm-88).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/584516/+subscriptions
