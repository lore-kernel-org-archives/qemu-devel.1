Received: from eggs.gnu.org ([2001:4830:134:3::10]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7bp-00072z-NL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7bk-0003kv-Rh
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:51088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7bk-0003kS-LO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:45:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7bj-0008Hq-DJ
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F9472E8F3A
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:30:29 -0000
From: Thomas Huth <1425597@bugs.launchpad.net>
Reply-To: Bug 1425597 <1425597@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150225170051.24385.73738.malonedeb@wampee.canonical.com>
Message-Id: <152699582914.2820.4360837946455559567.malone@gac.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU, using SDL2? Or could we close this
ticket nowadays? In case the problem persists, please also specify which
host system (Linux? Window manager? Or Windows?) you are using!

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1425597

Title:
  moving window + changing screen resolution =3D bug

Status in QEMU:
  Incomplete

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
