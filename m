Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fswYy-0000J0-Az
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fswYt-0003IH-BH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:38926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fswYt-0003Ho-4p
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:50:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fswYs-0000ov-6o
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 20:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 301FA2E805D
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 20:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Aug 2018 20:44:42 -0000
From: Frederick Metzengerstein <1788701@bugs.launchpad.net>
Reply-To: Bug 1788701 <1788701@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153505708215.4220.1958982030702670661.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788701] [NEW] "Zoom to fit" doesn't work with
 -display gtk -vga virtio
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

qemu version: 2.12.1

When using -display gtk for all -vga options (std,qxl,vmware,cirrus) the
option "Zoom To Fit" is unchecked and auto-resizing of the window works
well; except for -vga virtio: here "Zoom To Fit" is checked and auto-
resizing doesn't work.

Proposal: disable "Zoom To Fit" as default for virtio as well

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788701

Title:
  "Zoom to fit" doesn't work  with -display gtk -vga virtio

Status in QEMU:
  New

Bug description:
  qemu version: 2.12.1

  When using -display gtk for all -vga options (std,qxl,vmware,cirrus)
  the option "Zoom To Fit" is unchecked and auto-resizing of the window
  works well; except for -vga virtio: here "Zoom To Fit" is checked and
  auto-resizing doesn't work.

  Proposal: disable "Zoom To Fit" as default for virtio as well

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788701/+subscriptions
