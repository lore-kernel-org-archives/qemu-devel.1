Received: from eggs.gnu.org ([2001:4830:134:3::10]:50479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYFdW-0001VQ-Nv
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 13:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYFdT-0006p7-JV
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 13:25:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:46918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eYFdT-0006og-DV
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 13:25:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eYFdS-000336-C3
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:25:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 56D472E80C8
	for <qemu-devel@nongnu.org>; Sun,  7 Jan 2018 18:25:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jan 2018 18:16:38 -0000
From: Raphael <rtillet@free.fr>
Reply-To: Bug 1740887 <1740887@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151490925457.26459.4227536724801475724.malonedeb@gac.canonical.com>
Message-Id: <151534899881.26758.12192183473956494648.malone@gac.canonical.com>
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

I had to switch back to the following installer "2016-03-03: New QEMU
installers. Fixed, first version with support for Raspberry Pi 1 and 2."
for having a working version with the "-M raspi" option.

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
