Received: from eggs.gnu.org ([2001:4830:134:3::10]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQARA-000247-7O
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 05:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQAR7-0005t6-Kt
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 05:10:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQAR7-0005sf-EU
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 05:10:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQAR6-0003GX-HZ
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 10:10:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 828132E80C2
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 10:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Jan 2017 10:01:51 -0000
From: mutedbytes <mutedbytes@gmail.com>
Reply-To: Bug 1654826 <1654826@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170108095922.20152.98230.malonedeb@wampee.canonical.com>
Message-Id: <20170108100151.21645.50076.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1654826] Re: Holding key down using input-linux
 freezes guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thought I might add:

The qemu command line option equivalents for mouse and keyboard:

-object input-linux,id=3Dkbd,evdev=3D/dev/input/by-path/platform-i8042-seri=
o-0-event-kbd,repeat=3Don,grab_all=3Don \
-object input-linux,id=3Dms1,evdev=3D/dev/input/by-id/usb-ROCCAT_ROCCAT_Kon=
e_Pure-event-mouse

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654826

Title:
  Holding key down using input-linux freezes guest

Status in QEMU:
  New

Bug description:
  Qemu release version 2.8.0
  KVM, kernel 4.9.1

  When using the -object input-linux capability in qemu for passthrough
  of input/evdev devices, I found that when a key is held for a few
  seconds or more (such as ctrl key), the guest system freezes until the
  key is released. In some cases, mouse control is also lost following
  one of these "freezes". I also noticed that one of the four cpu cores
  I have the guest pinned to ramps to 100% during these freezes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1654826/+subscriptions
