Received: from eggs.gnu.org ([2001:4830:134:3::10]:54161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsERn-0005GL-0Y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsERj-0004Y2-2s
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:39:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsERi-0004XV-Sy
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:39:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsERg-00053b-HH
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 20:39:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6F81B2E848A
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 20:39:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 20:26:39 -0000
From: Herbert Poetzl <herbert@13thfloor.at>
Reply-To: Bug 932490 <932490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120215021135.22747.33099.malonedeb@soybean.canonical.com>
Message-Id: <150533439952.29770.6916525037248043204.malone@chaenomeles.canonical.com>
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

Sorry, it has been more than five years and I don't have a system with a
floppy disk to test anymore.

Best,
Herbert

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
