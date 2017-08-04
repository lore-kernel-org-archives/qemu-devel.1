Received: from eggs.gnu.org ([2001:4830:134:3::10]:51565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddchp-0000l0-Q9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddcgl-0006At-IB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:31:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:35353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddcgl-00068S-6y
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddcgj-0007Ql-QJ
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 13:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B944C2E8054
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 13:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Aug 2017 13:19:12 -0000
From: Divine E <1708551@bugs.launchpad.net>
Reply-To: Bug 1708551 <1708551@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150180124657.25828.11815849760914128130.malonedeb@chaenomeles.canonical.com>
	<150182828908.3687.6398256505959138792.malone@gac.canonical.com>
Message-Id: <11039F26-BBBC-40A3-A376-941C9B8557F5@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1708551] Re: macOS Guest Reading USB 3.0 Bus
 as USB 2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Doing so returns:
`qemu-system-x86_64: -device usb-tablet,bus=3Dusb-bus.0: Bus 'usb-bus.0' no=
t found`

> On Aug 4, 2017, at 2:31 AM, Thomas Huth <1708551@bugs.launchpad.net> wrot=
e:
> =

> Could you please try to run QEMU without the "-usb" option here? "-usb"
> automatically creates an EHCI and UHCI controller on the q35 machine, so
> that might be the reason that your USB devices get connected as USB 2.0
> instead.
> =

> ** Changed in: qemu
>       Status: New =3D> Incomplete
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1708551
> =

> Title:
>  macOS Guest Reading USB 3.0 Bus as USB 2.0
> =

> Status in QEMU:
>  Incomplete
> =

> Bug description:
>  Description:
>  I'm having trouble with USB Passthrough. Running `system_profiler SPUSBD=
ataType` on macOS guest confirms that the system "sees" my device, and that=
 qemu is passing *something* through. However, the system sees my connectio=
n as USB 2.0, even though i'm passing through XHCI controllers (nec-usb-xhc=
i/qemu-xhci). I suspect this is the reason why my guest is unable to recogn=
ize my iPhone in XCode & iTunes.
> =

>  Parameters:
>  QEMU release version: 2.10.0-rc0
>  Bios: [patched version of OVMF](https://github.com/gsomlo/edk2/tree/macb=
oot)]
>  Command Line: https://pastebin.com/pBSYbrW1
>  Host: Arch Linux
>  Guest: macOS v10.12.6
>  Guest System Info: https://pastebin.com/U1Tihxei
> =

>  Notes:
>  1. Observed sometime after late-May-early-June of this year.
> =

>  2. Due to [a defect in qemu v2.8 which affected GTK
>  users](https://bugs.launchpad.net/qemu/+bug/1578192), and [a recent
>  change to macOS' booting process conflicting with qemu
>  v2.9](https://lists.nongnu.org/archive/html/qemu-
>  devel/2017-03/msg06366.html), i'm forced to use qemu v2.10.0-rc0 (as
>  -rc1 fails to load OVMF right now).
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1708551/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708551

Title:
  macOS Guest Reading USB 3.0 Bus as USB 2.0

Status in QEMU:
  Incomplete

Bug description:
  Description:
  I'm having trouble with USB Passthrough. Running `system_profiler SPUSBDa=
taType` on macOS guest confirms that the system "sees" my device, and that =
qemu is passing *something* through. However, the system sees my connection=
 as USB 2.0, even though i'm passing through XHCI controllers (nec-usb-xhci=
/qemu-xhci). I suspect this is the reason why my guest is unable to recogni=
ze my iPhone in XCode & iTunes.

  Parameters:
  QEMU release version: 2.10.0-rc0
  Bios: [patched version of OVMF](https://github.com/gsomlo/edk2/tree/macbo=
ot)]
  Command Line: https://pastebin.com/pBSYbrW1
  Host: Arch Linux
  Guest: macOS v10.12.6
  Guest System Info: https://pastebin.com/U1Tihxei

  Notes:
  1. Observed sometime after late-May-early-June of this year.

  2. Due to [a defect in qemu v2.8 which affected GTK
  users](https://bugs.launchpad.net/qemu/+bug/1578192), and [a recent
  change to macOS' booting process conflicting with qemu
  v2.9](https://lists.nongnu.org/archive/html/qemu-
  devel/2017-03/msg06366.html), i'm forced to use qemu v2.10.0-rc0 (as
  -rc1 fails to load OVMF right now).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708551/+subscriptions
