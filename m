Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cU81Y-0007Ma-7W
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cU81V-0001Se-3t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:24:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:37583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cU81U-0001R5-Ts
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:24:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cU81T-0008UQ-2r
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:24:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 131082E8019
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:24:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 08:11:30 -0000
From: Thomas Huth <665743@bugs.launchpad.net>
Reply-To: Bug 665743 <665743@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101023233336.5102.72622.malonedeb@palladium.canonical.com>
Message-Id: <20170119081130.27373.96473.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 665743] Re: Cocoa video corruption when guest
 uses RGB565 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU? If
so, could you please rebase your patch to the latest git version and
send it to the mailing list (see http://qemu-
project.org/Contribute/SubmitAPatch for details)? Sorry, we do not take
patches from the bugtracker, they always have got to be discussed on the
qemu-devel mailing list first.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/665743

Title:
  Cocoa video corruption when guest uses RGB565 mode

Status in QEMU:
  Incomplete

Bug description:
  The cocoa video driver doesn't currently support when the guest uses
  RGB565 or HighColor mode resulting in corrupted video.  The initial
  graphics screen of recent Ubuntu installs is an example.  The attached
  patch against 0.13.0-release seems to fix the problem by introducing
  an indirect data provider that translates from RGB565 to RGB888, a
  mode that core graphics supports.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/665743/+subscriptions
