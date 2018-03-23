Received: from eggs.gnu.org ([2001:4830:134:3::10]:57150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezQI5-0006Rv-Pv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ezQI2-0002fZ-DZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:47308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ezQI2-0002e3-6d
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ezQI1-0002CK-7b
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 372D32E8D36
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Mar 2018 17:00:20 -0000
From: Lukas Jirkovsky <1191326@bugs.launchpad.net>
Reply-To: Bug 1191326 <1191326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130615151015.21597.4187.malonedeb@chaenomeles.canonical.com>
Message-Id: <152182442013.756.11947723187398316733.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1191326] Re: QNX 4 doesn't boot on qemu >= 1.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is still a problem with QEMU 2.11.

Note that the problem in #10 is unrelated to the issue (though GUI works
for with the the demo floppy). The problem mentioned in this bug is
related to a QNX that is already installed to a disk. Unfortunately the
QNX demo floppy that was once free and which can be still found on the
internet does not allow installation to disk, so it can't be used to
reproduce the bug.

At work we still maintain an application for QNX 4.25 so I can help
debugging it, but I don't know where to start. Currently we use
VirtualBox and VMware, but I personally would prefer QEMU much more.

Please let me know if there is any way how I could help to sort this
issue out.

** Changed in: qemu
       Status: Expired =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1191326

Title:
  QNX 4 doesn't boot on qemu >=3D 1.3

Status in QEMU:
  Confirmed

Bug description:
  I am using virtual machine with QNX4 operating system installed on it.  I=
 updated my qemu from version
  to newer and QNX4 doesn't start any more. All is ok on version 1.2 but wh=
en I try to use any newer version
  (1.3, 1.4, 1.5)  QNX4 doesn't boot.  I tried on windows and linux ubuntu =
hosts - effects are the same.

  When virtual machine boots qnx bootloader loads and starts operating syst=
em. In the next step
  qnx starts its ide driver, which detects qemu harddisk and cdrom. Problem=
 starts when operating system
  tries mount partition - an error occur and qnx stop booting procedure:

  mount -p "No bios signature in partition sector on /dev/hd0"

  I have tried install qnx from cdrom but it seems that there is the same p=
roblem. QNX installer boot from
  cdrom, detects hard disk and cdrom, but cdrom can't be mounted in the nex=
t step of installation procedure.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1191326/+subscriptions
