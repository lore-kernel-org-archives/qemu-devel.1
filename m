Received: from eggs.gnu.org ([2001:4830:134:3::10]:49997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2Zp-0005ho-Io
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dq2Zk-0005P8-Nn
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:35:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dq2Zk-0005OP-HJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:34:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dq2Zj-0001nd-Be
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 19:34:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46D492E8471
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 19:34:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Sep 2017 19:17:55 -0000
From: Thomas Huth <1355644@bugs.launchpad.net>
Reply-To: Bug 1355644 <1355644@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140812073520.4928.24191.malonedeb@gac.canonical.com>
Message-Id: <150481187515.23456.17863365921234540972.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1355644] Re: windows7 reboot bluesreen 0x0000005c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1355644

Title:
  windows7 reboot bluesreen 0x0000005c

Status in QEMU:
  Incomplete

Bug description:
  I have met sevaral blue screen with 0x0000005c(0x0000010b,0x00000003,0x00=
000000,0x00000000) after windows7 reboot.
  It always happens just before the windows iron animation appears.

  my qemu version is qemu-2.1.0
  my guest os is windows7 32bits sp1

  my qemu commandline is =

  ./x86_64-softmmu/qemu-system-x86_64 -m 2048 -hda system.inst -spice port=
=3D5940,disable-ticketing -monitor stdio --enable-kvm

  This bug  doesn't happen always=EF=BC=8Cand i don=E2=80=98t know how to r=
eproduce it.

  But i have a special way to produce such a bluescreen.
  I set nmi dump on and set windows to collect dump file and set auto reboo=
t after system fail on. =

  Then i send a nmi to guest, and then after collecting dump file , windows=
 will auto reboot and then such a blue screen happens.
  And this can be  reproduced always.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1355644/+subscriptions
