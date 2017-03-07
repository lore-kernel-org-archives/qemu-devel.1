Received: from eggs.gnu.org ([2001:4830:134:3::10]:49342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clNcO-0001jo-9a
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 17:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clNcG-0000xM-Nq
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 17:30:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:48540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1clNcG-0000x2-F7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 17:30:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1clNcE-00030M-A1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 22:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BA1692E80CF
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 22:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Mar 2017 22:18:23 -0000
From: Thomas Huth <986318@bugs.launchpad.net>
Reply-To: Bug 986318 <986318@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120420175203.15444.55707.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170307221823.27214.23571.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 986318] Re: [sdl] Mouse grab breaks GNOME 3
 screensaver unlock screen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Does this problem still happen with the latest version of QEMU and
GNOME?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/986318

Title:
  [sdl] Mouse grab breaks GNOME 3 screensaver unlock screen

Status in QEMU:
  Incomplete

Bug description:
  When the GNOME 3 screensaver activates with the mouse cursor over the
  SDL window, the screensaver will not unlock unless the gnome-shell
  process is killed and restarted manually. This seems to be related to
  the fact that the key strokes are grabbed by SDL, but the screensaver
  will not allow the Ctrl and Alt keys to be passed to QEMU to exit the
  mouse grab.

  Qemu-kvm 1.0.1, QEMU 1.0.1, kernel 3.2.15.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/986318/+subscriptions
