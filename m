Received: from eggs.gnu.org ([2001:4830:134:3::10]:34716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBnzh-0002or-Si
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBnzg-0002IP-6l
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:55:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:58915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBnzg-0002IH-0J
	for qemu-devel@nongnu.org; Fri, 19 May 2017 15:55:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBnzf-0006zz-3z
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 19:55:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D3AB2E8048
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 19:55:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 19:40:42 -0000
From: Thomas Huth <752476@bugs.launchpad.net>
Reply-To: Bug 752476 <752476@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110406124547.32492.80246.malonedeb@gandwana.canonical.com>
Message-Id: <149522284243.12763.3873574633407117417.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 752476] Re: monitor command mouse_button 1 moves
 mouse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you somehow still reproduce this
problem with the latest version of QEMU (currently v2.9), or could we
close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/752476

Title:
  monitor command mouse_button 1 moves mouse

Status in QEMU:
  Incomplete

Bug description:
  via the qemu -monitor interface, it is possible to move and click the mou=
se using
  mouse_move 20000 10000
  mouse_button 1
  but the mouse_button command always moves the mouse to (0,0) making it ra=
ther unusable to (auto-)trigger any widgets in the VM from the outside.

  Would be nice to have this available for my qemu/kvm based os-autoinst
  testing framework.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/752476/+subscriptions
