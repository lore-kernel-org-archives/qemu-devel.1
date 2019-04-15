Received: from eggs.gnu.org ([209.51.188.92]:39015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFwvs-0005ev-8L
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFwvq-0006aT-U2
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFwvq-0006ZZ-La
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFwvp-00024g-1p
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 08C872E80C8
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 08:13:44 -0000
From: TimeMaster <timemaster@trillinis.com>
Reply-To: Bug 1824768 <1824768@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155531602468.14046.8896369782282114161.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824768] [NEW] Qemu ARMv7 TCG MultiThreading for
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

Public bug reported:

Using any Linux image (in this case Alpine Linux iso) I want to utilise
all cores of my Raspberry with --accel,thread=3Dmulti. I know there is a
probably still problem with memory ordering of the host, but I have also
seen some very old commits which could potentially help with it.

But anyway, with version qemu-i386 version 3.1.0 (Debian 1:3.1+dfsg-7)
I can see OpenRC starting up services and then the kernel crash.

With version QEMU emulator version 3.1.93 (v4.0.0-rc3-dirty)
The whole machine crash with this error:
Illegal instruction

Using command:
./qemu-system-i386 -cdrom alpine.iso --accel tcg,thread=3Dmulti

Full Console Output:
qemu-system-i386: warning: Guest expects a stronger memory ordering than th=
e host provides
This may cause strange/hard to debug errors
Illegal instruction

Kernel:
Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv7l=
 GNU/Linux

CPU:
ARMv7 Processor rev 5 (v7l)
Features: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfp=
d32 lpae evtstrm
4 cores

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: multithreading raspberry tcg

** Description changed:

- Using any Linux image (in this case Alpine Linux iso) and want to use
+ Using any Linux image (in this case Alpine Linux iso) I want to utilise
  all cores of my Raspberry with --accel,thread=3Dmulti. I know there is a
- probably still problem with memory ordering of the host but I have also
+ probably still problem with memory ordering of the host, but I have also
  seen some very old commits which could potentially help with it.
  =

  But anyway, with version qemu-i386 version 3.1.0 (Debian 1:3.1+dfsg-7)
  I can see OpenRC starting up services and then the kernel crash.
  =

  With version QEMU emulator version 3.1.93 (v4.0.0-rc3-dirty)
- The whole machine crash with this error: =

+ The whole machine crash with this error:
  Illegal instruction
- =

  =

  Using command:
  ./qemu-system-i386 -cdrom alpine.iso --accel tcg,thread=3Dmulti
  =

  Full Console Output:
  qemu-system-i386: warning: Guest expects a stronger memory ordering than =
the host provides
  This may cause strange/hard to debug errors
  Illegal instruction
  =

- =

  Kernel:
  Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv=
7l GNU/Linux
  =

  CPU:
  ARMv7 Processor rev 5 (v7l)
- Features: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt v=
fpd32 lpae evtstrm =

+ Features: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt v=
fpd32 lpae evtstrm
  4 cores

** Summary changed:

- Qemu ARMv7 TCG MultiThreading doesn't work
+ Qemu ARMv7 TCG MultiThreading for i386 guest doesn't work

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824768

Title:
  Qemu ARMv7 TCG MultiThreading for i386 guest doesn't work

Status in QEMU:
  New

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
