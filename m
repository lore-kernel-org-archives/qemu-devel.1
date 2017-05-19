Received: from eggs.gnu.org ([2001:4830:134:3::10]:34573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfG1-0003DE-MD
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfFy-0000J3-F4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:35:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:49148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBfFy-0000Ip-8l
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:35:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBfFx-0001m6-0m
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:35:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5FED2E8050
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 10:22:59 -0000
From: Thomas Huth <1162227@bugs.launchpad.net>
Reply-To: Bug 1162227 <1162227@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130330141128.20806.35847.malonedeb@wampee.canonical.com>
Message-Id: <149518937954.12752.7978205902152640346.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1162227] Re: Mouse works badly when connecting to
 host via vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As you mentioned already, the solution is to use an USB tablet instead
of a mouse device, and as far as I can see, it is also mentioned in the
documentation of the "-vnc" parameter, so I'm closing this ticket now...

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1162227

Title:
  Mouse works badly when connecting to host via vnc

Status in QEMU:
  Invalid

Bug description:
  Let's assume we have some physical host A. This host runs qemu guest B lo=
cally without any options like "-vnc" etc.
  Then I connect from some physical host C to the host A via VNC or Teamvie=
wer ( www.teamviewer.com ). And then I try to remote control (via this vnc =
connection) qemu guest. But I cannot do this because my mouse disappears wh=
en I click at my qemu guest. I see little black square only. (This square i=
s vnc feature, it automatically appears when mouse disappears.) When I clic=
k to some objects inside guest I will instead click to another random objec=
t inside guest.

  I saw this bug in the following configurations:
  * A: Debian squeeze 64-bit, Teamviewer 8, Qemu 1.1.2, C: Ubuntu precise 6=
4-bit, Teamviewer 8, B: Windows 7 32-bit, command line:
  qemu-system-x86_64 --enable-kvm -m 2048  -daemonize -localtime -drive cac=
he=3Dnone,file=3D/root/vm/w7-sp1-i386-en.cow
  * A: Debian squeeze 64-bit, Teamviewer 8, Qemu 1.1.2, C: Ubuntu precise 6=
4-bit, Teamviewer 8, B: Debian squeeze 64-bit, command line:
  qemu-system-x86_64 -enable-kvm -m 256 -daemonize -snapshot -net none -dri=
ve cache=3Dnone,file=3D/dev/sda
  * A: Debian squeeze 64-bit, x11vnc 0.9.10, Qemu 1.1.2, C: Ubuntu precise =
64-bit, xvnc4viewer 4.1.1, B: Windows 7 32-bit, command line:
  qemu-system-x86_64 --enable-kvm -m 2048  -daemonize -localtime -drive cac=
he=3Dnone,file=3D/root/vm/w7-sp1-i386-en.cow

  Also, if I add "-usbdevice tablet" option, this bug will disappear.
  So, probably, this bug is not a bug. But in this case you should
  document it. I. e. you should add to docs something like "add
  -usbdevice tablet if you remote control qemu host".

  Also, if I use "-vnc" option (in the text above I didn't use it!) my
  mouse doesn't work as expected, too. The pointers don't line up, i. e.
  are not synced. But if I add "-usbdevice tablet" option, mouse will
  work. As far as I know this is not a bug. But then document it, too.
  Qemu's man page already says "It is very useful to enable the usb
  tablet device when using this option (option -usbdevice tablet)" in
  qemu 1.1.2. But I think this is not enough. The man page should say:
  "You should add -usbdevice tablet option and your guest OS should
  support tablet device or your mouse will not work".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1162227/+subscriptions
