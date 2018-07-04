Received: from eggs.gnu.org ([2001:4830:134:3::10]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fafIz-0000gP-IV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fafIt-0003La-62
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:46:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fafIs-0003JS-Qw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:46:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fafIr-0005KS-HW
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 10:46:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 681242E8198
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 10:46:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jul 2018 10:32:10 -0000
From: Gerd Hoffmann <1191326@bugs.launchpad.net>
Reply-To: Bug 1191326 <1191326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130615151015.21597.4187.malonedeb@chaenomeles.canonical.com>
Message-Id: <153070033102.7467.14067759786727298154.malone@soybean.canonical.com>
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

qemu git master has a prebuilt seabios with CONFIG_ATA_DMA=3Dy now.

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
