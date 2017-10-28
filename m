Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZQ-0006bD-6W
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZN-0003uY-Ej
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:55882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RZN-0003tr-7p
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RZM-0006lp-5Z
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D8B72E80C3
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:42:15 -0000
From: Thomas Huth <1284874@bugs.launchpad.net>
Reply-To: Bug 1284874 <1284874@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140225223220.31805.29833.malonedeb@gac.canonical.com>
Message-Id: <150919813587.20214.17370677462055051224.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1284874] Re: Guest hangs during option rom
 loading with certain cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch seems to have been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D4b9430294ed406a00f045d

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1284874

Title:
  Guest hangs during option rom loading with certain cards

Status in QEMU:
  Fix Released

Bug description:
  With a Broadcom Corporation NetXtreme II BCM57810 10 Gigabit Ethernet
  card, device assignment does not work. The guest hangs during option
  rom execution. Moreover, if an attempt is made to quit qemu when the
  guest is in the hung state, the card gets into an inoperable state.
  Only a powercycle then, restores the card back into working order,
  just unloading/loading the driver does not help.

  Qemu version  - 1.6.2 or current master
  Distribution - FC19
  Kernel Version - 3.12.9-201.fc19.x86_64

  Details of the card - =

   # ethtool -i p2p2
  driver: bnx2x
  version: 1.78.17-0
  firmware-version: bc 7.8.22
  bus-info: 0000:08:00.1
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: yes
  supports-register-dump: yes
  supports-priv-flags: yes

  The output of lspci when the card is broken -
  03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM57810 1=
0 Gigabit Ethernet (rev ff) (prog-if ff)
  	!!! Unknown header type 7f
  	Kernel driver in use: bnx2x
  00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

  I will post if I get a chance to try out a newer  than 7.8.22 for the
  option rom and see if this issue is fixed. However it appears we need
  to have a unified approach to automatically avoid loading the rom
  based on certain criteria.  Manually, looking out for fixes to
  firmware and hard coding decisions based on those is neither desirable
  nor easy to maintain.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1284874/+subscriptions
