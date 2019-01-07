Received: from eggs.gnu.org ([209.51.188.92]:48842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRUR-0003Dz-V9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggRUQ-0004YK-Co
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:52092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggRUK-0003mT-7g
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggRUA-0005lT-Bu
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:46:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 589A02E8050
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 09:46:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jan 2019 09:33:29 -0000
From: Thomas Huth <1530386@bugs.launchpad.net>
Reply-To: Bug 1530386 <1530386@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151231192039.26257.96801.malonedeb@gac.canonical.com>
Message-Id: <154685360952.5073.3919148440009646593.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1530386] Re: command.com on win95 throws video
 mode out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this issue with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1530386

Title:
  command.com on win95 throws video mode out

Status in QEMU:
  Incomplete

Bug description:
  on a presumed-good copy of Windows 95 obtained from http://forum.xda-
  developers.com/showthread.php?t=3D1960870, the operating system boots
  successfully and shows up fine, but as soon as I double-click the MS-
  DOS icon, the window, while remaining the same size, goes to a
  different resolution and only shows a small portion of what it did,
  with strange colors and artifacts. tried first with the Debian 2.5
  package, then with latest cvs sources, then with the 2.5.0 release,
  all the same problem.

  jcomeau@aspire:/usr/src/qemu-2.5.0/build$ cd /tmp/win95/SDL/
  jcomeau@aspire:/tmp/win95/SDL$ /usr/src/qemu-2.5.0/build/i386-softmmu/qem=
u-system-i386 c.img =

  jcomeau@aspire:/tmp/win95/SDL$ /usr/src/qemu-2.5.0/build/i386-softmmu/qem=
u-system-i386 --version
  QEMU emulator version 2.5.0, Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1530386/+subscriptions
