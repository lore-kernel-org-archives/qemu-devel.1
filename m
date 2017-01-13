Received: from eggs.gnu.org ([2001:4830:134:3::10]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1f-00061r-GI
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRx1a-0000kb-Na
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:45265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRx1a-0000kA-HD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRx1Z-0004Ds-Fl
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B21222E80CD
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2017 08:00:23 -0000
From: Thomas Huth <894037@bugs.launchpad.net>
Reply-To: Bug 894037 <894037@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111123154622.32156.92088.malonedeb@gac.canonical.com>
Message-Id: <20170113080023.20935.66126.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 894037] Re: With VNC,
 "-usbdevice tablet" no longer makes mouse pointers line up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to comment #6 this has been fixed in version 1.0 ... is there
still something left to do here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/894037

Title:
  With VNC, "-usbdevice tablet" no longer makes mouse pointers line up

Status in QEMU:
  Incomplete

Bug description:
  I use qemu in VNC mode.  In order to get the client and server mouse
  pointers to line up, I've had to use the "-usbdevice tablet" option.
  This no longer works, and it behaves the same as if the option is not
  there.  This makes my VMs unusable to me.

  Here's how I'm booting WinXP:

  qemu-system-x86_64 -vga std -drive
  cache=3Dwriteback,index=3D0,media=3Ddisk,file=3Dwinxp.img -k en-us -m 2048
  -smp 2 -vnc :3101 -usbdevice tablet -boot c -enable-kvm &

  The Windows install hasn't changed, only qemu.

  I'm running this version of QEMU:

  QEMU emulator version 0.15.0 (qemu-kvm-0.15.0), Copyright (c)
  2003-2008 Fabrice Bellard

  I'll see about upgrading to 0.15.1, but since I haven't seen other
  reports of this particular problem in your DB, I'm assuming that this
  problem has not been fixed between 0.15.0 and 0.15.1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/894037/+subscriptions
