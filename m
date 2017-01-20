Received: from eggs.gnu.org ([2001:4830:134:3::10]:44861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUe2c-0000rw-FV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUe2Y-0006rJ-JV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:36:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:51269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUe2Y-0006qy-De
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:35:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUe2W-0008Ui-IB
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:35:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9483A2E81F1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:35:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 18:17:58 -0000
From: Thomas Huth <954099@bugs.launchpad.net>
Reply-To: Bug 954099 <954099@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120313144218.21504.88722.malonedeb@wampee.canonical.com>
Message-Id: <20170120181758.27340.60857.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 954099] Re: Assertion failed arp_table.c line 41
 on raspberry pi fedora image boot up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since there hasn't been any more complains about later binaries, I
assume we can close this issue nowadays. (Feel free to re-open it
otherwise)

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/954099

Title:
  Assertion failed arp_table.c line 41 on raspberry pi fedora image boot
  up

Status in QEMU:
  Won't Fix

Bug description:
  OS Win XP pro, 32 bit SP3
  Intel Core Duo, 4G RAM.

  Qemu 1.0.1

  Launch command:
  qemu-system-arm.exe -M versatilepb -cpu arm1136-r2 -hda raspberrypi-fedor=
a-remix-14-r1.img -kernel zImage-devtmpfs -m 192 -append "root=3D/dev/sda2"=
 -vga std -net nic -net user -localtime

  Starting HAL daemon: eth0: link up
  Assert fires :
  File : slirp\arp_table.c line 41
  Expression (ip_addr & htonl(~0xf << 28))) 1=3D0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/954099/+subscriptions
