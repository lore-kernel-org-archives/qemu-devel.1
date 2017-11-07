Received: from eggs.gnu.org ([2001:4830:134:3::10]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvX3-0005bz-Tt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBvX0-0005vA-Lg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBvX0-0005u2-FN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 23:30:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBvWz-0000LB-K7
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:30:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 954FA2E80C3
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 04:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 04:17:32 -0000
From: Launchpad Bug Tracker <1355644@bugs.launchpad.net>
Reply-To: Bug 1355644 <1355644@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140812073520.4928.24191.malonedeb@gac.canonical.com>
Message-Id: <151002825241.21207.15891612641998670189.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1355644

Title:
  windows7 reboot bluesreen 0x0000005c

Status in QEMU:
  Expired

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
