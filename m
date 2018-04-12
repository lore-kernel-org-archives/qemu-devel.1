Received: from eggs.gnu.org ([2001:4830:134:3::10]:59097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6bEC-0003N1-U8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6bE9-0004pV-Gq
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:21:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:60786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f6bE9-0004mG-8M
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:21:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f6bE7-0003Ht-Ss
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 12:21:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D97722E8025
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 12:21:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Apr 2018 12:13:24 -0000
From: Gonzalo <1734792@bugs.launchpad.net>
Reply-To: Bug 1734792 <1734792@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151183114573.10651.11339653840196724023.malonedeb@wampee.canonical.com>
Message-Id: <152353520476.31596.15662220161538137125.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1734792] Re: qemu-x86_64 fails with unsupported
 syscall 319
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not only qemu-x86_64, but also:

qemu-aarch64 =3D> qemu: Unsupported syscall: 279
qemu-arm =3D> qemu: Unsupported syscall: 385
qemu-mips =3D> qemu: Unsupported syscall: 4354
qemu-mips64 =3D> qemu: Unsupported syscall: 5314
qemu-powerpc =3D> qemu: Unsupported syscall: 360
qemu-powerpc64 =3D> qemu: Unsupported syscall: 360

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1734792

Title:
  qemu-x86_64 fails with unsupported syscall 319

Status in QEMU:
  New

Bug description:
  qemu-x86_66 GIT HEAD fails on a userspace application that requires
  memfd_create with:

  "qemu: Unsupported syscall: 319".

  memfd_create support needs to be implemented in QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1734792/+subscriptions
