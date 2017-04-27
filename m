Received: from eggs.gnu.org ([2001:4830:134:3::10]:39381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbG-00071b-Vm
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbD-0002xa-85
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lbD-0002xB-1h
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lbC-0008HV-3P
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16F292E80C6
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:33:23 -0000
From: Thomas Huth <1184089@bugs.launchpad.net>
Reply-To: Bug 1184089 <1184089@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130525082911.27253.67454.malonedeb@gac.canonical.com>
Message-Id: <20170427153324.22759.53723.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1184089] Re: [Feature request] loadvm snapshot as
 read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1184089

Title:
  [Feature request] loadvm snapshot as read-only

Status in QEMU:
  New

Bug description:
  There are many ways to take and manage snapshots in QEMU, but one main
  feature that's missing is the ability to 'loadvm' a LIVE snapshot and
  have all future changes redirected to a temporary file.  This would
  effectively be combining the -loadvm and -snapshot switches and make
  the snapshot read-only.  With this feature, users would be provided a
  "sandbox" and be able to start and restart the same live snapshot
  without corrupting the image in doing so.

  I found a lot of discussion about this topic on the mailing list years
  ago, including some patch submissions, but none of the conversations
  panned out.

  http://lists.gnu.org/archive/html/qemu-discuss/2011-10/msg00011.html
  http://copilotco.com/mail-archives/qemu.2008/msg00072.html
  http://web.archiveorange.com/archive/v/1XS1vcusGInZKG2e0ImX
  http://marc.info/?l=3Dqemu-devel&m=3D117191084713590

  What would it take for this feature to be added, and can we use the
  patches submitted by Eddie Kohler to enable this feature?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1184089/+subscriptions
