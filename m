Received: from eggs.gnu.org ([2001:4830:134:3::10]:40972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaTx-0008UF-Pz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaTu-0006Zh-Ir
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:51:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:45023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctaTu-0006Yr-CW
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:51:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctaTq-0005vO-Pe
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:51:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8CECD2E8322
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:50:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 13:39:03 -0000
From: luigiburdo <intermediadc@hotmail.com>
Reply-To: Bug 1675549 <1675549@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170323202936.30994.35916.malonedeb@wampee.canonical.com>
Message-Id: <20170330133904.26275.29878.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1675549] Re: tcg softmmu i386 crashes on BE
 hardware
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1675549

Title:
  tcg  softmmu i386 crashes on BE hardware

Status in QEMU:
  Fix Released

Bug description:
  Hi,
  today i try to test qemu 2.9rc 1 with qemu-system-i386 if i set display a=
s sdl and i push a key on keyboard qemu exit with an error =


  translate-common.c:34:tcg_handle_interrupt: assertion failed:
  (qemu_mutex_iothread_locked())

  This issue was not present on qemu 2.8.0

  Test Machine PowerMac G5 Quad Fedora 25 Server PPC64
  Qemu build with target-list=3Di386-softmuu --with-sdlabi=3D2.0 =


  Ciao =

  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1675549/+subscriptions
