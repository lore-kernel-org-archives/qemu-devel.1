Received: from eggs.gnu.org ([209.51.188.92]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIapD-0007bf-HW
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIapC-00006b-A0
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:25:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:46430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIapC-0008Vf-4w
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:25:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIap8-0005fD-Qb
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C2D5E2E804F
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Apr 2019 15:18:27 -0000
From: TimeMaster <timemaster@trillinis.com>
Reply-To: Bug 1824768 <1824768@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155531602468.14046.8896369782282114161.malonedeb@gac.canonical.com>
Message-Id: <155594630727.13658.11371645770469576454.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824768] Re: Qemu ARMv7 TCG MultiThreading for
 i386 guest doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>> ./qemu-system-i386 -cdrom alpine.iso --accel tcg,thread=3Dmulti

I tried both, with -smp 4 and without..

In stable Qemu release, there is just a guest kernel panic, in
v4.0.0-rc3-dirty, there is also Illegal instruction error reported

> on an x-gene system, compiled for aarch32.
Yes, this should be Raspberry Pi 3, but I am not sure. Anyway, I can test t=
his in one week when I receive one of those boards.

>Just so we're clear, which raspberry pi revision are you using?
>Based on comments I'm assuming pi 2, with the 4 core cortex-a7.

I am using Raspberry Pi 2, 4 cores, not sure where is the difference
between cortex-a7 and ARMv7, in my case it is just ARMv7.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824768

Title:
  Qemu ARMv7 TCG MultiThreading for i386 guest doesn't work

Status in QEMU:
  Incomplete

Bug description:
  Using any Linux image (in this case Alpine Linux iso) I want to
  utilise all cores of my Raspberry with --accel,thread=3Dmulti. I know
  there is a probably still problem with memory ordering of the host,
  but I have also seen some very old commits which could potentially
  help with it.

  But anyway, with version qemu-i386 version 3.1.0 (Debian 1:3.1+dfsg-7)
  I can see OpenRC starting up services and then the kernel crash.

  With version QEMU emulator version 3.1.93 (v4.0.0-rc3-dirty)
  The whole machine crash with this error:
  Illegal instruction

  Using command:
  ./qemu-system-i386 -cdrom alpine.iso --accel tcg,thread=3Dmulti

  Full Console Output:
  qemu-system-i386: warning: Guest expects a stronger memory ordering than =
the host provides
  This may cause strange/hard to debug errors
  Illegal instruction

  Kernel:
  Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv=
7l GNU/Linux

  CPU:
  ARMv7 Processor rev 5 (v7l)
  Features: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt v=
fpd32 lpae evtstrm
  4 cores

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824768/+subscriptions
