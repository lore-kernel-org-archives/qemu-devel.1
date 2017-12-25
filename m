Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPN-0008FX-7S
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPK-0003Jj-4D
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:54794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTKPJ-0003Ii-Ts
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTKPH-00072G-LA
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9EAAA2E8050
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Dec 2017 04:17:38 -0000
From: Launchpad Bug Tracker <1374905@bugs.launchpad.net>
Reply-To: Bug 1374905 <1374905@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140928043504.32411.389.malonedeb@gac.canonical.com>
Message-Id: <151417545874.5133.266242400739054494.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1374905] Re: Pixelation issue in 16-bit color VGA
 graphics
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
https://bugs.launchpad.net/bugs/1374905

Title:
  Pixelation issue in 16-bit color VGA graphics

Status in QEMU:
  Expired

Bug description:
  What happened:
  I ran the 9front installation ISO (here: http://r-36.net/9front/9front-38=
53.02ebd469f43a.iso.bz2) in QEMU, with a blank qcow2, using `qemu-system-i3=
86 -hda 9front.qcow2.img -cdrom 9front-3853.02ebd469f43a.iso -boot d -vga s=
td -m 1G`. During the console boot, I accept the default display settings (=
1024x768x16, VESA, PS2 mouse), and 9front proceeds to the GUI boot. However=
, every pixel is blurred, making text illegible and the GUI unusable.

  What I expected:
  Normal pixel rendering / normal display.

  Step by step instructions:
  0. Install QEMU 2.1.2 (I use Homebrew's bottle, `brew install qemu`)
  1. Download 9front ISO (9front-3853.02ebd469f43a.iso.bz2)
  2. Create new QEMU image: `qemu-img create -f qcow2 9front.qcow2.img 20G`.
  3. Boot 9front ISO: `qemu-system-i386 -hda 9front.qcow2.img -cdrom 9front=
-3853.02ebd469f43a.iso -boot d -vga std -m 1G`
  4. It displays a console boot screen; accept default args (local, glenda,=
 1024x768x16, vesa, ps2, etc...)
  5. GUI is drawn.
  6. Pixel are blurred and unreadable

  Details:
  This bug does not occur when 32 bit color is used, using the 1024x768x32.=
 This bug does not occur when QEMU is built with SDL (in Homebrew, `brew in=
stall qemu --with-sdl`), although the console portion of 9front's boot runs=
 significantly slower.

  System:
  OS X 10.9.5 x86-64
  Macbook Retina Late 2012
  Intel i7 Ivy Bridge dual core.

  Build:
  Homebrew's QEMU 2.1.2 bottle, which is build without GTK, SDL, or VDE.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1374905/+subscriptions
