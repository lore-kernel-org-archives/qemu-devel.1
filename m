Received: from eggs.gnu.org ([2001:4830:134:3::10]:34042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWM66-0003NI-EB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWM61-0003ij-Js
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:41572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWM61-0003iU-9F
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:50:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWM60-0003Bi-2M
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 11:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0BA582E80AE
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 11:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jan 2017 11:37:30 -0000
From: Uqbar <1659267@bugs.launchpad.net>
Reply-To: Bug 1659267 <1659267@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170125113730.12494.46970.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1659267] [NEW] It's not possible to start a VM
 with a network cable unplugged
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

There should be a command line (sub)option to unplug a network cable.
While from the monitor interface I can issue:

set_link virtio-net-pci.0 off

There's no way to fire a VM from command line with that cable already unplu=
gged.
As an example, virtualbox can do it.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1659267

Title:
  It's not possible to start a VM with a network cable unplugged

Status in QEMU:
  New

Bug description:
  There should be a command line (sub)option to unplug a network cable.
  While from the monitor interface I can issue:

  set_link virtio-net-pci.0 off

  There's no way to fire a VM from command line with that cable already unp=
lugged.
  As an example, virtualbox can do it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1659267/+subscriptions
