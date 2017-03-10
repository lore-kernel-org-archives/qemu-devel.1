Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmAPD-00039k-Dt
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 21:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cmAP8-0001LC-Ht
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 21:35:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:41087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cmAP8-0001Ks-Ar
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 21:35:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cmAP5-0001ei-6U
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 02:35:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3A4A92E80D7
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 02:35:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Mar 2017 02:28:16 -0000
From: Max Ehrlich <1671677@bugs.launchpad.net>
Reply-To: Bug 1671677 <1671677@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170310022816.24904.27346.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1671677] [NEW] vfio-pci passthrough issue after
 resume from suspend
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


I'm running into a weird issue with the vfio-pci driver through qemu

I use it on a laptop and I passthrough an external GPU connected via PCI
express. In general this works well, however if the laptop has *ever*
suspended since its last boot, then the windows guest reports an error
43 on the card and I get no output on the monitor that it is connected
to. This is really weird to me since it works fine if I boot the latop
from power-off, and hotplug the card. It's only if the laptop has ever
suspended since it's last boot that I see this issue. Even if it was
suspended before the card was ever hotplugged.

In other words:
laptop off -> boot -> hotplug GPU : works great
laptop off -> boot -> do stuff (GPU *NOT* connected) -> sleep -> resume -> =
hotplug GPU: problem
laptop off -> boot -> hotplug GPU -> unplug GPU -> hotplug GPU : works great
laptop off -> boot -> hotplug GPU -> unplug GPU -> sleep -> resume -> hotpl=
ug GPU: problem

Weird stuff...

I'm honestly not sure that vfio-pci/qemu is to blame here since there
are so many moving parts, but im not really sure where else to report
this to

What I have tried is using the sysfs interface to
remove/rescan/poweroff/etc the PCI devices in questions (graphics card
and it's HDMI audio) and this also does help.

QEMU version: 2.6.1

Please let me know what other information I can provide

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1671677

Title:
  vfio-pci passthrough issue after resume from suspend

Status in QEMU:
  New

Bug description:
  =

  I'm running into a weird issue with the vfio-pci driver through qemu

  I use it on a laptop and I passthrough an external GPU connected via
  PCI express. In general this works well, however if the laptop has
  *ever* suspended since its last boot, then the windows guest reports
  an error 43 on the card and I get no output on the monitor that it is
  connected to. This is really weird to me since it works fine if I boot
  the latop from power-off, and hotplug the card. It's only if the
  laptop has ever suspended since it's last boot that I see this issue.
  Even if it was suspended before the card was ever hotplugged.

  In other words:
  laptop off -> boot -> hotplug GPU : works great
  laptop off -> boot -> do stuff (GPU *NOT* connected) -> sleep -> resume -=
> hotplug GPU: problem
  laptop off -> boot -> hotplug GPU -> unplug GPU -> hotplug GPU : works gr=
eat
  laptop off -> boot -> hotplug GPU -> unplug GPU -> sleep -> resume -> hot=
plug GPU: problem

  Weird stuff...

  I'm honestly not sure that vfio-pci/qemu is to blame here since there
  are so many moving parts, but im not really sure where else to report
  this to

  What I have tried is using the sysfs interface to
  remove/rescan/poweroff/etc the PCI devices in questions (graphics card
  and it's HDMI audio) and this also does help.

  QEMU version: 2.6.1

  Please let me know what other information I can provide

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1671677/+subscriptions
