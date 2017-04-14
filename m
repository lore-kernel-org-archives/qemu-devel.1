Received: from eggs.gnu.org ([2001:4830:134:3::10]:56524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cz7va-00038S-IY
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 16:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cz7vX-0004JQ-FS
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 16:34:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cz7vX-0004J8-9C
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 16:34:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cz7vU-0006aq-TL
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 20:34:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BFE832E80CD
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 20:34:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2017 20:23:26 -0000
From: Philippe Gauthier <philippe.gauthier@deuxpi.ca>
Reply-To: Bug 986318 <986318@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120420175203.15444.55707.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170414202326.10359.87830.malone@chaenomeles.canonical.com>
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

On current versions (QEMU 2.8, GNOME-Shell 3.22.3 on Wayland), the
screensaver will activate. Cursor control is given to the lock screen,
everything works properly. After the screen is unlocked, the cursor is
given back to QEMU and is still in "mouse grab" mode.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/986318

Title:
  [sdl] Mouse grab breaks GNOME 3 screensaver unlock screen

Status in QEMU:
  Fix Released

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
