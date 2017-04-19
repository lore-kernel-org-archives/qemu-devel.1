Received: from eggs.gnu.org ([2001:4830:134:3::10]:50535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d0tpT-0003F5-7j
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d0tpO-00028P-C1
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:55:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:47789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d0tpO-000282-5p
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:55:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d0tpM-0002pu-27
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 17:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0E57E2E80C7
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 17:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Apr 2017 17:45:35 -0000
From: Rolando Zappacosta <zappacor@hotmail.com>
Reply-To: Bug 1684239 <1684239@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170419174535.1860.64403.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1684239] [NEW] vvfat core dump when enabling RW
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

Hi guys,

I'm getting this qemu crash message:
>>> qemu-system-x86_64: /build/qemu-TziMIO/qemu-2.5+dfsg/block/vvfat.c:2290=
: commit_direntries: Assertion `!strncmp(s->directory.pointer, "QEMU", 4)' =
failed.
>>> Aborted (core dumped)
when launching qemu with this options for a VVFAT drive:
>>> -drive file=3Dfat:rw:./ROOT,if=3Dvirtio
(same happens when using cache=3Dnone and/or if=3Dide)

"uname -a" system info is:
>>> Linux RJZ-WRK-LNX 4.4.0-72-generic #93-Ubuntu SMP Fri Mar 31 14:07:41 U=
TC 2017 x86_64 x86_64 x86_64 GNU/Linux
and "qemu --version" is:
>>> QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.10), Copyright=
 (c) 2003-2008 Fabrice Bellard

Not sure what logs to attach but I'll be glad to upload whatever needed.

Thanks in advance for you help,
Rolando

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: directory.pointer direntries vvfat

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1684239

Title:
  vvfat core dump when enabling RW

Status in QEMU:
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
https://bugs.launchpad.net/qemu/+bug/1684239/+subscriptions
