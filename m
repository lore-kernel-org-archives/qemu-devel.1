Received: from eggs.gnu.org ([2001:4830:134:3::10]:45357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhrxM-0007U9-0m
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fhrxI-0000La-S3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fhrxI-0000Kv-L6
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:42:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fhrxH-0005ob-5g
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:41:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 155212E80CC
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 07:41:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jul 2018 07:25:31 -0000
From: Thomas Huth <1482425@bugs.launchpad.net>
Reply-To: Bug 1482425 <1482425@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150806231725.25632.66379.malonedeb@chaenomeles.canonical.com>
Message-Id: <153241713168.3011.408814575935022253.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1482425] Re: Qemu crashes on Mac (emulation of
 x86_64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1482425

Title:
  Qemu crashes on Mac (emulation of  x86_64)

Status in QEMU:
  Incomplete

Bug description:
  I used qemu on MAC OS X Yosemite with the latest qemu version (from
  git, 6. august 2015, QEMU emulator version 2.3.94, Copyright (c)
  2003-2008 Fabrice Bellard)

  I configured it with "./configure --enable-vde".

  Sometimes when starting an openwrt instance, the following error
  occurrs in the qemu monitor:

  (qemu) qemu:qemu_cpu_kick_thread: No such process

  I started qemu this way:

  qemu-system-x86_64 -m 128 -serial unix:/tmp/qemu_1.sock,server,nowait
  -nographic -net nic,macaddr=3Daa:aa:aa:aa:00:01 -net
  vde,sock=3D/tmp/vde_switch_1 -watchdog-action poweroff openwrt-x86
  -generic-combined-ext4.img

  The same works on Linux (Ubuntu 14.04, qemu-2.4.0-rc3).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1482425/+subscriptions
