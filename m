Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX1Oq-0006Lc-0C
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX1Oi-0006S3-Bd
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:05:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX1Of-0006P7-O8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:05:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX1Oe-0003rV-1h
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:05:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 046482E807E
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:05:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 09:45:50 -0000
From: Thomas Huth <1528718@bugs.launchpad.net>
Reply-To: Bug 1528718 <1528718@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151223001438.12538.32747.malonedeb@chaenomeles.canonical.com>
Message-Id: <154460795027.1805.15509552448677981116.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1528718] Re: Initial monitor does not output
 anything on Windows (MSYS2 binary)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1528718

Title:
  Initial monitor does not output anything on Windows (MSYS2 binary)

Status in QEMU:
  Incomplete

Bug description:
  When running on Windows error messages before the UI is started are
  not showing up.

  For example when I run:

  qemu-system-i386.exe -L /mingw32/etc/qemu/ -m 20G

  It should display "ram size too large", according to gdb:

  Breakpoint 1, error_report (fmt=3Dfmt@entry=3D0x71bdf6
  <dma_aiocb_info+2426> "ram size too large") at
  C:/build/mingw/mingw-w64-qemu/src/qemu-2.4.0/util/qemu-error.c:233

  However the console does never receive that.

  As far as I could find out vfprintf is called, but it doesn't output
  anything.

  Maybe the binary is build for the "win32" subsystem which does not
  have a console window attached by default?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1528718/+subscriptions
