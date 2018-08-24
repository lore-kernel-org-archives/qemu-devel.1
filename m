Received: from eggs.gnu.org ([2001:4830:134:3::10]:55629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ft4ut-0000Vv-M6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ft4uq-0006IN-D0
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:45:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ft4uq-0006Et-5O
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:45:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ft4un-0000wE-LI
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 05:45:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 796472E851E
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 05:45:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Aug 2018 05:31:35 -0000
From: Gerd Hoffmann <1788701@bugs.launchpad.net>
Reply-To: Bug 1788701 <1788701@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153505708215.4220.1958982030702670661.malonedeb@gac.canonical.com>
Message-Id: <153508869526.4268.5521909615047916490.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788701] Re: "Zoom to fit" doesn't work with
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

virtio-vga will adapt the guest display to the window size (once the guest =
drivers are loaded).
Therefore it is not needed to auto-resize the window (to avoid display scal=
ing).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788701

Title:
  "Zoom to fit" doesn't work  with -display gtk -vga virtio

Status in QEMU:
  New

Bug description:
  qemu version: 2.12.1, 3.0.0

  When using -display gtk for all -vga options (std,qxl,vmware,cirrus)
  the option "Zoom To Fit" is unchecked by default and thus auto-
  resizing of the window works well; except for -vga virtio: here "Zoom
  To Fit" is checked and auto-resizing doesn't work.

  Proposal: make "Zoom To Fit" unchecked by default for virtio as well
  Extended proposal: make GTK window options configurable via parameters

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788701/+subscriptions
