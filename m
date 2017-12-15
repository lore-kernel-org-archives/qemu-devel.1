Received: from eggs.gnu.org ([2001:4830:134:3::10]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePswO-0000NP-Tg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePswN-0003vg-U0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:34:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePswN-0003uR-Nv
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:34:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePswL-0007y6-RI
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:34:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 928452E80DC
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:34:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:24:17 -0000
From: Thomas Huth <855630@bugs.launchpad.net>
Reply-To: Bug 855630 <855630@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110921150616.12335.44343.malonedeb@gac.canonical.com>
Message-Id: <151335505735.18606.11136160777586532876.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 855630] Re: Cant Run Wine (posix not nptl) past
 0.14.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... The problem with the SDL static linking has lik=
ely been fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5f37e6d4a7b22ccf1bb8f=
a4
Can you still reproduce the other issue with the latest version of QEMU? Or=
 could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/855630

Title:
  Cant Run Wine (posix not nptl) past 0.14.1

Status in QEMU:
  Incomplete

Bug description:
  when trying to build qemu I can build with ./configure --static
  --target-list=3Di386-linux-user just fine with 0.14.1

  But when I try to go on 0.15.0 or higher (tested on 0.15.0). About to
  test on 0.15.5 from git

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/855630/+subscriptions
