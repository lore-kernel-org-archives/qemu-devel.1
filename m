Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEj5e-0006yz-KE
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEj5b-0000iW-Iy
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:45:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:56187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEj5b-0000iC-E4
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:45:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEj5Z-00066F-15
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 20:45:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 640802E80BF
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 20:45:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2016 20:27:07 -0000
From: Thomas Huth <538808@bugs.launchpad.net>
Reply-To: Bug 538808 <538808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100314203151.2911.69634.malonedeb@wampee.canonical.com>
Message-Id: <20161207202707.12688.29018.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 538808] Re: qemu-system-x86_64 0.12.2 crashes
 with -m 967 under Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/538808

Title:
  qemu-system-x86_64 0.12.2 crashes with -m 967 under Windows

Status in QEMU:
  Incomplete

Bug description:
  qemu 0.12.2 and 0.12.3 exit silently under Windows XP when using an -m va=
lue higher than 967.  Any value below 967 works fine.  Affects both qemu.ex=
e and qemu-system-x86_64.exe (the only binaries currently available).
  qemu 0.12.3 under Linux (Ubuntu 8.10) works fine.
  Version 0.9.0 for Windows does not have this problem.  I do not have any =
other binaries to test.

  Command used:
  qemu-system-x86_64 -L . -m 967 -hda linux.img -localtime -M pc

  There is plenty of available RAM on the host PC (see attached systeminfo).
  Not sure what debugging options to use, but will attach whatever is neces=
sary.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/538808/+subscriptions
