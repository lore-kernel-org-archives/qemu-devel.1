Received: from eggs.gnu.org ([2001:4830:134:3::10]:36685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfQ3-0000p8-6F
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfQ1-0003ls-Tk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:50126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBfQ1-0003lf-F1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBfQ0-0002nL-08
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:46:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A651E2E804F
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 10:29:34 -0000
From: Thomas Huth <685096@bugs.launchpad.net>
Reply-To: Bug 685096 <685096@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101204070046.21747.93608.malonedeb@gandwana.canonical.com>
Message-Id: <149518977394.11822.16507775486911103210.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 685096] Re: USB Passthrough not working for
 Windows 7 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If I get the previous comments right, this is just about using the right
configuration, and not a real bug? If so, I assume we can close this
ticket nowadays?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/685096

Title:
  USB Passthrough not working for Windows 7 guest

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Confirmed
Status in qemu package in Debian:
  New

Bug description:
  USB Passthrough from host to guest is not working for a 32-bit Windows
  7 guest, while it works perfectly for a 32-bit Windows XP guest.

  The device appears in the device manager of Windows 7, but with "Error
  code 10: device cannot start". I have tried this with numerous USB
  thumbdrives and a USB wireless NIC, all with the same result. The
  device name and functionality is recognized, so at least some USB
  negotiation is taking place.

  I am trying this with the latest git-pull of QEMU-KVM.

  The command line to launch qemu-kvm for win7 is:
  sudo /home/user/local_install/bin/qemu-system-x86_64 -cpu core2duo -m 102=
4 -smp 2 -vga std -hda ./disk_images/win7.qcow -vnc :1 -boot c -usb -usbdev=
ice tablet -usbdevice host:0781:5150

  The command line to launch qemu-kvm for winxp is:
  sudo /home/user/local_install/bin/qemu-system-x86_64 -cpu core2duo -m 102=
4 -smp 2 -usb -vga std -hda ./winxpsp3.qcow -vnc :0 -boot c -usbdevice tabl=
et -usbdevice host:0781:5150

  Any help is appreciated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/685096/+subscriptions
