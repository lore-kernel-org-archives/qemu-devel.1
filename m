Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWPEA-00043o-I1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWPE6-0006Xj-IF
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWPE6-0006XT-C9
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:15:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWPE5-0006tR-6z
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3300F2E804E
	for <qemu-devel@nongnu.org>; Tue,  2 Jan 2018 16:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2018 16:07:34 -0000
From: charlet franck <1740887@bugs.launchpad.net>
Reply-To: Bug 1740887 <1740887@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151490925457.26459.4227536724801475724.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1740887] [NEW] qemu-system-arm &
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

Public bug reported:

In Windows 7 64 bit (both 32 & 64 bit QEMU emulator version 2.11.0
(v2.11.0-11693-g21057c841e-dirty)).

With arguments:

qemu-system-arm.exe -M raspi2

It crashes and reports:

ERROR:/home/stefan/src/qemu/repo.or.cz/qemu/ar7/qom/object.c:176:type_get_p=
arent:
assertion failed: (type->parent_type !=3D NULL)

Same goes for qemu-system-aarch64.exe or with -M raspi argument.

Have a nice day,
f.

** Affects: qemu
     Importance: Undecided
         Status: New

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
