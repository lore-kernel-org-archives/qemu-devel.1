Received: from eggs.gnu.org ([209.51.188.92]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ1uZ-00046R-7B
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ1uS-000183-AZ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:20:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:57058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ1uF-0000vU-BU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:20:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ1u8-0001i7-QB
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 20:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3B7A2E80C8
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 20:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 20:12:31 -0000
From: "mike@papersolve.com" <mike@papersolve.com>
Reply-To: Bug 1759338 <1759338@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152217198529.30594.10454069952660679046.malonedeb@gac.canonical.com>
Message-Id: <155605035154.17547.2881432107973210089.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759338] Re: qemu-system-sparc w/ SS-20 ROM does
 not add processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As of QEMU 4 OpenBIOS can boot Solaris again, and it does properly
allocate multiple CPUs. Of course, it's a whole lot slower on multiple
CPUs which I wasn't really anticipating, but it does work.  (And single
CPU is so fast anyway compared to the actual hardware it's emulating!)
So this bug while still applicable can be closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759338

Title:
  qemu-system-sparc w/ SS-20 ROM does not add processors

Status in QEMU:
  New

Bug description:
  When booting a SPARCstation-20 with the original ROM, qemu does not
  set the number of processors in a way that this ROM can understand it,
  and the ROM always reports only 1 processor installed:

  =

   ~/qemu =EE=82=B0 /usr/local/bin/qemu-system-sparc -bios ./ss20_v2.25_rom=
 -M SS-20 -cpu "TI SuperSparc 60" -smp 2 -nographic

  Power-ON Reset


  =

             SMCC SPARCstation 10/20 UP/MP POST version VRV3.45 (09/11/95)

  =

  CPU_#0       TI, TMS390Z50(3.x)       0Mb External cache

  CPU_#1       ******* NOT installed *******
  CPU_#2       ******* NOT installed *******
  CPU_#3       ******* NOT installed *******

      <<< CPU_00000000 on MBus Slot_00000000 >>> IS RUNNING (MID =3D
  00000008)

  =

  ...

  Cpu #0 TI,TMS390Z50 =

  Cpu #1 Nothing there =

  Cpu #2 Nothing there =

  Cpu #3 Nothing there =


  ...

  SPARCstation 20 (1 X 390Z50), No Keyboard
  ROM Rev. 2.25, 128 MB memory installed, Serial #1193046.
  Ethernet address 52:54:0:12:34:56, Host ID: 72123456.


  =

  (It is necessary use SS-20 since it is the only sun4m model that supports=
 512MB RAM, and I can't get Solaris to install on the SS-20 using OpenBIOS.=
) =


  When booting with OpenBIOS I can't seem to boot any version of Solaris
  though I had heard this did work.  Solaris 8 and 9 do work nicely with
  this ROM, but I am opening this to see if it is possible to fix this
  to allow the original OBP ROM to see multiple processors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759338/+subscriptions
