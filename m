Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLbaO-0004AW-6S
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLbaK-0004rA-VT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:46:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:52738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLbaK-0004pe-PF
	for qemu-devel@nongnu.org; Wed, 23 May 2018 17:46:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLbaJ-00067v-HB
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 21:46:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 490E12E80CD
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 21:46:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2018 21:32:46 -0000
From: Fabiano Rosas <1614521@bugs.launchpad.net>
Reply-To: Bug 1614521 <1614521@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160818130339.29660.13425.malonedeb@gac.canonical.com>
Message-Id: <152711116699.25648.11191762622258626909.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1614521] Re: -display accepts "none[a-z,
 0-9]*" instead of 'none'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2c9498c3e44cd5574

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1614521

Title:
  -display accepts "none[a-z,0-9]*" instead of 'none'

Status in QEMU:
  Fix Committed

Bug description:
  When using the '-display' option the parameter 'none' is not the only
  string that causes the behaviour of 'none'. I can use '-display
  noneMICKEYMOUSE' and still have the none behaviour.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1614521/+subscriptions
