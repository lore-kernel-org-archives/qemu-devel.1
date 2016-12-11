Received: from eggs.gnu.org ([2001:4830:134:3::10]:32937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFuvE-0007Tw-TH
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFuvB-0000Z0-Pp
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:35:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:55753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFuvB-0000Ys-Jh
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:35:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFuvA-000669-BB
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 03:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36F752E80C8
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 03:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Dec 2016 03:26:00 -0000
From: LPNow <77777@tutanota.de>
Reply-To: Bug 1649042 <1649042@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161211032601.16375.45078.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649042] [NEW] Ubuntu 16.04.1 LightDM Resolution
 Not Correct
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

My Specs:

Slackware 14.2 x86_64 > Host
Nvidia GPU GTX660M
nvidia-driver-352.63
QEMU 2.7.0

Ubuntu 16.04.1 x86_64 > Guest
Unity
Xorg nouveau - 1:1.0.12-1build2

These are the startup options for Ubuntu:

qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
-cpu host \
--enable-kvm \
-smp 2 \
-m 4096 \
-vga vmware \
-soundhw ac97 \
-usbdevice tablet \
-rtc base=3Dlocaltime \
-usbdevice host:0781:5575

Unity desktop resolution set for 1440x900.

I noticed when I come to the login screen to enter my password the
LightDM resolution fills my entire desktop.

I searched online and found this solution;

cp ~/.config/monitor.xml /var/lib/lightdm/.config

For now I'm assuming this step should not be needed and the resolution
should be correctly detected and set?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649042

Title:
  Ubuntu 16.04.1 LightDM Resolution Not Correct

Status in QEMU:
  New

Bug description:
  My Specs:

  Slackware 14.2 x86_64 > Host
  Nvidia GPU GTX660M
  nvidia-driver-352.63
  QEMU 2.7.0

  Ubuntu 16.04.1 x86_64 > Guest
  Unity
  Xorg nouveau - 1:1.0.12-1build2

  These are the startup options for Ubuntu:

  qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
  -cpu host \
  --enable-kvm \
  -smp 2 \
  -m 4096 \
  -vga vmware \
  -soundhw ac97 \
  -usbdevice tablet \
  -rtc base=3Dlocaltime \
  -usbdevice host:0781:5575

  Unity desktop resolution set for 1440x900.

  I noticed when I come to the login screen to enter my password the
  LightDM resolution fills my entire desktop.

  I searched online and found this solution;

  cp ~/.config/monitor.xml /var/lib/lightdm/.config

  For now I'm assuming this step should not be needed and the resolution
  should be correctly detected and set?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649042/+subscriptions
