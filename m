Received: from eggs.gnu.org ([2001:4830:134:3::10]:43739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJa4y-0004tc-TD
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJa4v-0004iZ-O8
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:41:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:49369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dJa4v-0004iB-Il
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:40:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dJa4u-0004Ub-KX
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 06:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 910972E80E6
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 06:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Jun 2017 06:35:36 -0000
From: Thomas Huth <1639322@bugs.launchpad.net>
Reply-To: Bug 1639322 <1639322@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161104181436.19841.43234.malonedeb@soybean.canonical.com>
Message-Id: <149707653760.10153.5728458340613086006.launchpad@wampee.canonical.com>
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

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639322

Title:
  pasting into ppc64 serial console kills qemu

Status in QEMU:
  Fix Released

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
