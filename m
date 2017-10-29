Received: from eggs.gnu.org ([2001:4830:134:3::10]:59637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8m2M-0000Ye-Ij
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8m2J-0003Wc-Em
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:45:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:59116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8m2J-0003VO-7t
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 07:45:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8m2I-0001Xf-2y
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 11:45:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0CC4C2E80CC
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 11:45:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Oct 2017 11:30:54 -0000
From: Dmitry Ilyin <1191326@bugs.launchpad.net>
Reply-To: Bug 1191326 <1191326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130615151015.21597.4187.malonedeb@chaenomeles.canonical.com>
Message-Id: <150927665471.20448.13639351383597766325.malone@soybean.canonical.com>
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

I've just tried to launch QNX 4.25 ISO bootdisk on qemu-system-x86_64 built=
 from current git.
QEMU screen is skewed (see on screenshot). I tried all different options in=
 -vga key - all the same.

** Attachment added: "qemu-qnx4.png"
   https://bugs.launchpad.net/qemu/+bug/1191326/+attachment/4999395/+files/=
qemu-qnx4.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1191326

Title:
  QNX 4 doesn't boot on qemu >=3D 1.3

Status in QEMU:
  Expired

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
