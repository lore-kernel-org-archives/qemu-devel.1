Received: from eggs.gnu.org ([2001:4830:134:3::10]:40258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSV6-00030N-UT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhSV4-0000MC-Af
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:38504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhSV4-0000Jn-3M
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 00:31:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhSV2-0006px-4M
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E63212E80D4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 04:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jul 2018 04:17:20 -0000
From: Launchpad Bug Tracker <1425597@bugs.launchpad.net>
Reply-To: Bug 1425597 <1425597@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150225170051.24385.73738.malonedeb@wampee.canonical.com>
Message-Id: <153231944091.16639.7069584972765554181.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1425597] Re: moving window + changing screen
 resolution = bug
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
https://bugs.launchpad.net/bugs/1425597

Title:
  moving window + changing screen resolution =3D bug

Status in QEMU:
  Expired

Bug description:
  Steps to reproduce:
  1. Run qemu (sdl)
  2. Start moving the window
  3. At that moment the virtualized OS should change its screen resolution =
(for example, when switching from initial qemu screen to grub)

  What I see:
  Window size doesn't change, but internal screen resolution changes, so, i=
mage scale stops to be 1:1, now I see virtualized OS in wrong scale.

  What I expected to see:
  Window size changes so, that it keeps synchronized with internal resoluti=
on (as usual)

  This bug preserves at lastest git version at the moment, i. e.
  3d30395f7fb3315e4ecf0de4e48790e1326bbd47

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1425597/+subscriptions
