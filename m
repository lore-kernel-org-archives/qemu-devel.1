Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1daXiN-0005zM-Bw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1daXiI-00029a-FT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:35:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:36491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1daXiI-000291-AZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:35:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1daXiG-0005Wh-Em
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 01:35:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 60A0F2E80CD
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 01:35:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2017 01:21:42 -0000
From: Timothy Pearson <kb9vqf@pearsoncomputing.net>
Reply-To: Bug 1706825 <1706825@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150111850209.31878.14522576992993433144.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1706825] [NEW] qemu-user fails to run wineserver
 on ppc64el host
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

When attempting to run wineserver on a 64-bit ppc64el host via QEMU's
user-mode i386 emulation, a file locking operation fails.

Command line:
qemu-i386-static /usr/lib/wine-development/wineserver32

Output:
wineserver: fcntl /tmp/.wine-0/server-17-14d21bf/lock: Invalid argument

Relevant portion of strace:
fcntl(6, F_SETLK64, 0x3fffe8802218) =3D -1 EINVAL (Invalid argument)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1706825

Title:
  qemu-user fails to run wineserver on ppc64el host

Status in QEMU:
  New

Bug description:
  When attempting to run wineserver on a 64-bit ppc64el host via QEMU's
  user-mode i386 emulation, a file locking operation fails.

  Command line:
  qemu-i386-static /usr/lib/wine-development/wineserver32

  Output:
  wineserver: fcntl /tmp/.wine-0/server-17-14d21bf/lock: Invalid argument

  Relevant portion of strace:
  fcntl(6, F_SETLK64, 0x3fffe8802218) =3D -1 EINVAL (Invalid argument)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1706825/+subscriptions
