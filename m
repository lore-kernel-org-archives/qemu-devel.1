Received: from eggs.gnu.org ([2001:4830:134:3::10]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2a2y-0001OF-7r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d2a2u-0002oA-8l
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:12:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:55003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d2a2u-0002mt-2k
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:12:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d2a2r-000474-R7
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:12:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C92492F621B
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:12:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Apr 2017 08:57:36 -0000
From: Thomas Huth <1684239@bugs.launchpad.net>
Reply-To: Bug 1684239 <1684239@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170419174535.1860.64403.malonedeb@wampee.canonical.com>
Message-Id: <20170424085736.6278.52611.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1684239] Re: vvfat core dump when enabling RW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Moving to QEMU-Ubuntu since you're not using upstream QEMU (and the bug
should have been fixed there as pointed out by Herv=C3=A9 on the qemu-devel
mailing list).

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1684239

Title:
  vvfat core dump when enabling RW

Status in qemu package in Ubuntu:
  New

Bug description:
  Hi guys,

  I'm getting this qemu crash message:
  >>> qemu-system-x86_64: /build/qemu-TziMIO/qemu-2.5+dfsg/block/vvfat.c:22=
90: commit_direntries: Assertion `!strncmp(s->directory.pointer, "QEMU", 4)=
' failed.
  >>> Aborted (core dumped)
  when launching qemu with this options for a VVFAT drive:
  >>> -drive file=3Dfat:rw:./ROOT,if=3Dvirtio
  (same happens when using cache=3Dnone and/or if=3Dide)

  "uname -a" system info is:
  >>> Linux RJZ-WRK-LNX 4.4.0-72-generic #93-Ubuntu SMP Fri Mar 31 14:07:41=
 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
  and "qemu --version" is:
  >>> QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.10), Copyrig=
ht (c) 2003-2008 Fabrice Bellard

  Not sure what logs to attach but I'll be glad to upload whatever
  needed.

  Thanks in advance for you help,
  Rolando

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1684239/+subscriptions
