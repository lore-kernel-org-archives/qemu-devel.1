Received: from eggs.gnu.org ([2001:4830:134:3::10]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfV-00044o-46
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCfS-0008Th-3u
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:51934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCfR-0008T9-Tx
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:45:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCfQ-0006O7-Fx
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 751042E80C2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:45:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:35:57 -0000
From: Thomas Huth <1639322@bugs.launchpad.net>
Reply-To: Bug 1639322 <1639322@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161104181436.19841.43234.malonedeb@soybean.canonical.com>
Message-Id: <20170111063557.21322.95237.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1639322] Re: pasting into ppc64 serial console
 kills qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

FWIW, the crash should be fixed by this commit here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7bacfd7f7289192c83330
(but we still need to fix the gtk side, too, to only send as much character=
s at once as the receiving side can take)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639322

Title:
  pasting into ppc64 serial console kills qemu

Status in QEMU:
  Confirmed

Bug description:
  - run qemu-system-ppc64
  - when X window appears press Ctrl+Alt+3
  - paste any text longer than 16 characters

  =

  qemu-system-ppc64: /home/abuild/rpmbuild/BUILD/qemu-2.6.1/hw/char/spapr_v=
ty.c:40: vty_receive: Assertion `(dev->in - dev->out) < 16' failed.
  Aborted (core dumped)

  Broken in SUSE Leap 42.2 and git
  4eb28abd52d48657cff6ff45e8dbbbefe4dbb414

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1639322/+subscriptions
