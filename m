Received: from eggs.gnu.org ([2001:4830:134:3::10]:50871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYEmO-0002t8-BD
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 12:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYEmJ-0002zD-3C
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 12:30:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:43174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eYEmI-0002yG-SY
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 12:30:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eYEmH-00079I-Ph
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 17:30:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A0FF42E80CB
	for <qemu-devel@nongnu.org>; Sun,  7 Jan 2018 17:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jan 2018 17:25:15 -0000
From: Raphael <rtillet@free.fr>
Reply-To: Bug 1740887 <1740887@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151490925457.26459.4227536724801475724.malonedeb@gac.canonical.com>
Message-Id: <151534591542.32008.3088139854066476756.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1740887] Re: qemu-system-arm &
 qemu-system-aarch64 for windows crash at start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've got th exact same crash under Windows 10 64 bits with QEMU emulator
version 2.10.95 (v2.11.0-rc5-11692-g50cdacc703-dirty)

Any idea how to fix it or is there a previous known working version for
"-M raspi" option?

Thanks.
Rapha=C3=ABl.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1740887

Title:
  qemu-system-arm & qemu-system-aarch64 for windows crash at start

Status in QEMU:
  New

Bug description:
  In Windows 7 64 bit (both 32 & 64 bit QEMU emulator version 2.11.0
  (v2.11.0-11693-g21057c841e-dirty)).

  With arguments:

  qemu-system-arm.exe -M raspi2

  It crashes and reports:

  ERROR:/home/stefan/src/qemu/repo.or.cz/qemu/ar7/qom/object.c:176:type_get=
_parent:
  assertion failed: (type->parent_type !=3D NULL)

  Same goes for qemu-system-aarch64.exe or with -M raspi argument.

  Have a nice day,
  f.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1740887/+subscriptions
