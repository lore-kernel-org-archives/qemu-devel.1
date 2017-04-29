Received: from eggs.gnu.org ([2001:4830:134:3::10]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4Wg3-0005F2-2h
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d4Wfy-0004pg-6H
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:01:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:49575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d4Wfy-0004pI-0I
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d4Wfv-000450-P9
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 18:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A20CC2E80C0
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 18:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Apr 2017 17:53:05 -0000
From: Alamot <1687214@bugs.launchpad.net>
Reply-To: Bug 1687214 <1687214@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170429175305.26812.79902.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687214] [NEW] Rapid tremendous memory hog when
 using -net nic, vlan=0 -net user, vlan=0
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

A rapid tremendous memory hog is occuring when I use -net nic,vlan=3D0
-net user,vlan=3D0. Tested with QEMU 2.8.0 & 2.9.0 in Gentoo. All
available memory (8GB) + swap (over 20GB) is exhausted very rapidly.

This bug is possibly related to =

https://bugs.launchpad.net/qemu/+bug/1310714 =

and maybe to
https://bugs.launchpad.net/qemu/+bug/1288620

The bug IS present wheh I use -net nic,vlan=3D0 -net user,vlan=3D0 (tested
with no model and model=3De1000 and model=3Dvirtio, with all these the bug
is present)

The bug is NOT present with I use this:
-netdev type=3Duser,id=3Dmynet0 -device virtio-net-pci,netdev=3Dmynet0

I tested this bug only using windows guests (Windows XP & Windows 8).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687214

Title:
  Rapid tremendous memory hog when using -net nic,vlan=3D0 -net
  user,vlan=3D0

Status in QEMU:
  New

Bug description:
  A rapid tremendous memory hog is occuring when I use -net nic,vlan=3D0
  -net user,vlan=3D0. Tested with QEMU 2.8.0 & 2.9.0 in Gentoo. All
  available memory (8GB) + swap (over 20GB) is exhausted very rapidly.

  This bug is possibly related to =

  https://bugs.launchpad.net/qemu/+bug/1310714 =

  and maybe to
  https://bugs.launchpad.net/qemu/+bug/1288620

  The bug IS present wheh I use -net nic,vlan=3D0 -net user,vlan=3D0 (tested
  with no model and model=3De1000 and model=3Dvirtio, with all these the bug
  is present)

  The bug is NOT present with I use this:
  -netdev type=3Duser,id=3Dmynet0 -device virtio-net-pci,netdev=3Dmynet0

  I tested this bug only using windows guests (Windows XP & Windows 8).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687214/+subscriptions
