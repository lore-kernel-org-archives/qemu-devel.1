Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsrnD-0003k5-Ua
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsrn8-0003pu-Rv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:40:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:57809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsrn8-0003pe-LJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:40:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsrn7-0000GB-F2
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 14:40:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 667D32E8037
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 14:40:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Sep 2017 14:24:45 -0000
From: Thomas Huth <1384892@bugs.launchpad.net>
Reply-To: Bug 1384892 <1384892@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141023194249.8096.62457.malonedeb@chaenomeles.canonical.com>
Message-Id: <150548548534.29770.9531568139075199372.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1384892] Re: RTL8168 NIC VFIO not working anymore
 since QEMU 2.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patch that has been mentioned in the last comment has been included her=
e:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D31e6a7b17b35711eb44f0e
... and has been released with QEMU v2.8 already, so marking this as "fix r=
eleased" now.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1384892

Title:
  RTL8168 NIC VFIO not working anymore since QEMU 2.1

Status in QEMU:
  Fix Released

Bug description:
  After upgrading QEMU from 2.0 to 2.1 (and libiscsi from 1.7.0 to 1.12 as =
a dependency) my two RTL8168 NICs stopped working.
  The NICs do not respond to any command and even the LEDs on the network c=
onnection turn off, a few seconds after the VM started.
  To get them back running I had to downgrade to 2.0 and restart the system.
  Unfortunately, I have no clue what to do or how to debug this problem sin=
ce there are no specific errors logged.
  I tried two different VMs: Debian Wheezy and IPFire (see attachment for f=
urther details).
  The QEMU 2.1 changelog states "Support for RTL8168 NICs." so there were s=
ome major changes done, I guess.

  On the IPFire guest the kernel log shows many of these lines:
  r8169 0000:00:07.0 green1: rtl_eriar_cond =3D=3D 1 (loop: 100, delay: 100)
  r8169 0000:00:07.0 green1: rtl_phy_reset_cond =3D=3D 1 (loop: 100, delay:=
 1)

  On the Debian guest there is only:
  r8169 0000:00:07.0: firmware: agent loaded rtl_nic/rtl8168e-3.fw into mem=
ory
  r8169 0000:00:07.0: lan0: link down
  ADDRCONF(NETDEV_UP): lan0: link is not ready

  The commandline for IPFire can be seen in the attachment. It is the same =
for Debian.
  There are also the complete kernel logs for the working (2.0) and non-wor=
king (2.1) cases.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1384892/+subscriptions
