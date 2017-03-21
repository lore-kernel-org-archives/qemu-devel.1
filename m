Received: from eggs.gnu.org ([2001:4830:134:3::10]:50820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqBSP-0003H8-U4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqBSK-0001Jx-UE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqBSK-0001Gw-PE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqBSI-0003js-Jb
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:31:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EE2E32E81A0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:31:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Mar 2017 04:17:27 -0000
From: Launchpad Bug Tracker <665743@bugs.launchpad.net>
Reply-To: Bug 665743 <665743@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101023233336.5102.72622.malonedeb@palladium.canonical.com>
Message-Id: <20170321041727.27578.87250.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/665743

Title:
  Cocoa video corruption when guest uses RGB565 mode

Status in QEMU:
  Expired

Bug description:
  The cocoa video driver doesn't currently support when the guest uses
  RGB565 or HighColor mode resulting in corrupted video.  The initial
  graphics screen of recent Ubuntu installs is an example.  The attached
  patch against 0.13.0-release seems to fix the problem by introducing
  an indirect data provider that translates from RGB565 to RGB888, a
  mode that core graphics supports.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/665743/+subscriptions
