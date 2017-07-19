Received: from eggs.gnu.org ([2001:4830:134:3::10]:37221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgiA-0005Dv-II
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi9-0001pT-9y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:37927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi9-0001p9-1u
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi8-00048f-0S
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 024922E807D
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:48 -0000
From: Launchpad Bug Tracker <726619@bugs.launchpad.net>
Reply-To: Bug 726619 <726619@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110228160401.29334.5055.malonedeb@wampee.canonical.com>
Message-Id: <150043786871.28289.1975548618974047239.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 726619] Re: loadvm does not load (offline)
 snapshot anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/726619

Title:
  loadvm does not load (offline) snapshot anymore

Status in QEMU:
  Expired

Bug description:
  qemu Version: 0.14.0
  The problem is present in the current code from git master as well.

  Loading a snapshot that was created while qemu was not running (using
  qemu-img) does not seem to work anymore.

  Using "loadvm <snapshot-id>" in the qemu monitor does not have the
  desired effect. Not even an error message is displayed.

  I was able to track down the problem (using git bisect) to this commit:
  http://git.qemu.org/qemu.git/commit/?id=3Df0aa7a8b2d518c54430e4382309281b=
93e51981a

  After reverting that commit in my local git checkout everything is
  workin as expected again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/726619/+subscriptions
