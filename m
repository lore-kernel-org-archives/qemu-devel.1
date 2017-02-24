Received: from eggs.gnu.org ([2001:4830:134:3::10]:52962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chCMy-0003ni-Bm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chCMu-000105-Bg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:40:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1chCMt-0000zz-SL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:40:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1chCMs-0006u8-Rd
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B3AC12E80CA
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2017 09:34:56 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1667613 <1667613@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170224093456.30105.18077.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1667613] [NEW] Qemu 2.8 on PPC64 issue with input
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

Hi devs,
on my PPC64 machine if i start qemu with gtk,gl=3Don or with sdl,gl=3Don i =
have issue with pointer and keyboard. pratically not input at all.
This issue is present in tgc and in kvm

without gl=3Don option in kvm with mate as guest i have the input device
work in the beginning but after some time the usb goes "unplugged" (i
see this message on the serial log of qemu usb unplugged) and the
keyboard and mouse dont work.

On Debian jessie kvm i dont have input working at all.

my machine is a G5 quad with Fedora 25 PPC64

thanks
Luigi

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1667613

Title:
  Qemu 2.8  on PPC64 issue with input

Status in QEMU:
  New

Bug description:
  Hi devs,
  on my PPC64 machine if i start qemu with gtk,gl=3Don or with sdl,gl=3Don =
i have issue with pointer and keyboard. pratically not input at all.
  This issue is present in tgc and in kvm

  without gl=3Don option in kvm with mate as guest i have the input device
  work in the beginning but after some time the usb goes "unplugged" (i
  see this message on the serial log of qemu usb unplugged) and the
  keyboard and mouse dont work.

  On Debian jessie kvm i dont have input working at all.

  my machine is a G5 quad with Fedora 25 PPC64

  thanks
  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1667613/+subscriptions
