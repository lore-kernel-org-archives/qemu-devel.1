Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsY92-0002v2-Ge
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsY8z-00088w-CS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:41:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:38453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsY8z-00088U-5Q
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:41:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsY8w-0006aU-3L
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 17:41:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1E0F52E84DA
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 17:41:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2017 17:21:08 -0000
From: John Snow <932490@bugs.launchpad.net>
Reply-To: Bug 932490 <932490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120215021135.22747.33099.malonedeb@soybean.canonical.com>
Message-Id: <150540966851.12951.12662216254232775729.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 932490] Re: Qemu fails on -fda /dev/fd0 when no
 medium is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Likely the bug as reported still exists, because this attempts to use
the disk image, not the floppy drive as a whole. If there's no floppy
inserted, there's no disk image to use. Later versions of QEMU even
explicitly remove support for pass-through floppy disks.

Basically, what you want to do is to create a normal emulated floppy
drive in QEMU, and then use the block device add commands to use the
/dev/fd0 as a media which can then be virtually inserted into the
virtual floppy device.

QEMU does not have support for doing pass-through of the floppy
controller / drive itself presently. (Uh, unless you have a PCI floppy
controller or something, but... you probably don't!)

We can close this bug as WONTFIX, essentially.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/932490

Title:
  Qemu fails on -fda /dev/fd0 when no medium is present

Status in QEMU:
  Incomplete

Bug description:
  # qemu-system-x86_64 --version
  QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008 Fabrice=
 Bellard

  # qemu-system-x86_64 -fda /dev/fd0
  qemu-system-x86_64: -fda /dev/fd0: could not open disk image /dev/fd0: No=
 such device or address

  Starting with a medium (floppy disk) inserted, then removing or
  changing the medium works fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/932490/+subscriptions
