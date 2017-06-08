Received: from eggs.gnu.org ([2001:4830:134:3::10]:44609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIxWY-0006SY-T3
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIxWV-00016P-PF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIxWV-000155-JA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIxWT-0006he-4P
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 13:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EAF12E8199
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2017 13:25:15 -0000
From: Nathan Rennie-Waldock <1696746@bugs.launchpad.net>
Reply-To: Bug 1696746 <1696746@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149692831501.10366.4878345375882367011.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696746] [NEW] netdev user,
 restrict=on prevents forwarded ports from being accessed from other
 systems
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

I've got a guest only network and I'm wanting to access SSH on one of the g=
uests externally.
I'm using -netdev user,id=3Dusernet0,hostfwd=3Dtcp::2222-:22,restrict=3Dyes=
 -device virtio-net-pci,netdev=3Dusernet0
to forward 2222 to 22 in the guest.

The docs state:
restrict=3Don|off

    If this option is enabled, the guest will be isolated, i.e. it will
not be able to contact the host and no guest IP packets will be routed
over the host to the outside. This option does not affect any explicitly
set forwarding rules.


However, with restrict=3Don, the forwarded port is only accessible from the=
 host. Other systems receive no data.

This was tested with qemu 2.8. Changelog for 2.9 doesn't mention any
(relevant) user networking changes, so that should also fail.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696746

Title:
  netdev user,restrict=3Don prevents forwarded ports from being accessed
  from other systems

Status in QEMU:
  New

Bug description:
  I've got a guest only network and I'm wanting to access SSH on one of the=
 guests externally.
  I'm using -netdev user,id=3Dusernet0,hostfwd=3Dtcp::2222-:22,restrict=3Dy=
es -device virtio-net-pci,netdev=3Dusernet0
  to forward 2222 to 22 in the guest.

  The docs state:
  restrict=3Don|off

      If this option is enabled, the guest will be isolated, i.e. it
  will not be able to contact the host and no guest IP packets will be
  routed over the host to the outside. This option does not affect any
  explicitly set forwarding rules.

  =

  However, with restrict=3Don, the forwarded port is only accessible from t=
he host. Other systems receive no data.

  This was tested with qemu 2.8. Changelog for 2.9 doesn't mention any
  (relevant) user networking changes, so that should also fail.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696746/+subscriptions
