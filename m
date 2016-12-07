Received: from eggs.gnu.org ([2001:4830:134:3::10]:54168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEjj2-0000zS-QZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEjiz-0000hQ-Je
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:26:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:50489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEjiz-0000gm-DZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:26:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEjiw-0006WL-DA
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 21:25:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 627442E80E0
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 21:25:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2016 21:08:05 -0000
From: Stefan Weil <538808@bugs.launchpad.net>
Reply-To: Bug 538808 <538808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100314203151.2911.69634.malonedeb@wampee.canonical.com>
Message-Id: <20161207210805.11926.5003.malone@wampee.canonical.com>
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

I think that QEMU did not crash, but simply was not able to allocate the
block of memory which was requested. This is an inherent problem of the
fragmented memory of 32 bit applications on Windows.

QEMU reports problems with memory allocation, but QEMU for Windows tries
to send those messages to stderr which is redirected to a file when QEMU
was built with SDL2.

So no crash and silently by design.

64 bit versions don't have that problem, nor do my pre-built 32 bit
binaries which include a patch to use upper memory. And in my latest
binaries I dropped SDL support.

I close this issue - please re-open if you think this was wrong.

** Changed in: qemu
       Status: Incomplete =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/538808

Title:
  qemu-system-x86_64 0.12.2 crashes with -m 967 under Windows

Status in QEMU:
  Invalid

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
