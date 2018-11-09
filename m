Received: from eggs.gnu.org ([2001:4830:134:3::10]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gL1iq-0004qj-Di
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gL1in-0006Hn-0i
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:00:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:48216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gL1im-0006Bc-Lv
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:00:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gL1il-0007S9-2X
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 08:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DFEA82E80CB
	for <qemu-devel@nongnu.org>; Fri,  9 Nov 2018 08:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Nov 2018 07:50:08 -0000
From: Zhaocong <1802465@bugs.launchpad.net>
Reply-To: Bug 1802465 <1802465@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154174980807.2749.13752196954108515323.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802465] [NEW] typing string via VNC is unreliable
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

QEMU version is 3.0.0

# Description

The problem is that, when typing string through VNC, it can be
unreliable -- sometimes some key strokes get skipped, sometimes get
swapped, sometimes get repeated.  There's no problem when typing through
VNC on physical hardware.

# Steps to reproduce

1. Launch virtual machine by:

    qemu-kvm -display vnc=3D:1 -m 2048 opensuse-leap-15.qcow2

2. Connect to VNC by:

    vncviewer -Shared :5901

3. Simulate a series of key strokes by "vncdotool" [1]:

    vncdotool -s 127.0.0.1::5901 typefile strings_to_be_typed.txt

4. Usually after a few hundred keys are typed, something goes wrong.

I attached a screenshot that it mistypes " hello" to "h ello".

[1] https://github.com/sibson/vncdotool

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-vnc-mistype.png"
   https://bugs.launchpad.net/bugs/1802465/+attachment/5210655/+files/qemu-=
vnc-mistype.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1802465

Title:
  typing string via VNC is unreliable

Status in QEMU:
  New

Bug description:
  QEMU version is 3.0.0

  # Description

  The problem is that, when typing string through VNC, it can be
  unreliable -- sometimes some key strokes get skipped, sometimes get
  swapped, sometimes get repeated.  There's no problem when typing
  through VNC on physical hardware.

  # Steps to reproduce

  1. Launch virtual machine by:

      qemu-kvm -display vnc=3D:1 -m 2048 opensuse-leap-15.qcow2

  2. Connect to VNC by:

      vncviewer -Shared :5901

  3. Simulate a series of key strokes by "vncdotool" [1]:

      vncdotool -s 127.0.0.1::5901 typefile strings_to_be_typed.txt

  4. Usually after a few hundred keys are typed, something goes wrong.

  I attached a screenshot that it mistypes " hello" to "h ello".

  [1] https://github.com/sibson/vncdotool

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802465/+subscriptions
