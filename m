Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP0x6-0002zn-Sp
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eP0x2-0001Qa-T0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:55:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:54832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eP0x2-0001QD-Me
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:55:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eP0x1-00010y-JX
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:55:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E30C2E80C8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:55:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2017 06:47:25 -0000
From: MVoloshin <1737883@bugs.launchpad.net>
Reply-To: Bug 1737883 <1737883@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151314764536.10749.10688753671340892012.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737883] [NEW] Cannot boot FreeBSD on versatilepb
 machine
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

I know some years ago it was possible to boot FreeBSD in QEMU versatilepb m=
achine
https://kernelnomicon.org/?p=3D229 (you can download image and kernel using=
 web.archive.org)
Now when I try to do that I get only black screen with no output even in QE=
MU console.
I also added -global versatile_pci.broken-irq-mapping=3D1, but this seem to=
 have no effect.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: freebsd qemu regression versatilepb

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737883

Title:
  Cannot boot FreeBSD on versatilepb machine

Status in QEMU:
  New

Bug description:
  I know some years ago it was possible to boot FreeBSD in QEMU versatilepb=
 machine
  https://kernelnomicon.org/?p=3D229 (you can download image and kernel usi=
ng web.archive.org)
  Now when I try to do that I get only black screen with no output even in =
QEMU console.
  I also added -global versatile_pci.broken-irq-mapping=3D1, but this seem =
to have no effect.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737883/+subscriptions
