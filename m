Received: from eggs.gnu.org ([2001:4830:134:3::10]:48511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKn3-0001mK-TT
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKmy-0003Pp-8C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:51:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzKmy-0003Ow-2C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:51:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzKmx-0001vD-2Y
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 10:50:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 11FB02E80C9
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 10:50:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 10:34:28 -0000
From: Thomas Huth <700276@bugs.launchpad.net>
Reply-To: Bug 700276 <700276@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110108115227.15680.52990.malonedeb@soybean.canonical.com>
Message-Id: <150702686848.12168.12710602818763578055.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 700276] Re: QEMU crashed when GDB request a big
 size variable information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/700276

Title:
  QEMU crashed when GDB request a big size variable information

Status in QEMU:
  Incomplete

Bug description:
  Hello,
  My host is Fedora 13. My QEMU version is 0.13.0, I use QEMU with GDB to d=
ebug Linux kernel(Version 2.6.36.2).

  I use QEMU like this:"qemu -s -S -kernel build/arch/i386/boot/bzImage -hd=
a /dev/zero"
  When GDB connected with QEMU, and use gdb command print to look big size =
variable, the qemu is crash down. for example, when I look a task_struct va=
riable 'init_task'(print init_task ), the qemu produce the below message an=
d exit.

  *** stack smashing detected ***: qemu terminated
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/libc.so.6(__fortify_fail+0x4d)[0x78a31d]
  /lib/libc.so.6[0x78a2ca]
  qemu[0x8059e21]
  qemu[0x805a0cf]
  qemu[0x80d12a1]
  qemu[0x8189cb8]
  qemu[0x818c3b0]
  /lib/libc.so.6(__libc_start_main+0xe6)[0x6a8cc6]
  ...............
  adbf7000-adbf8000 rw-p 00000000 00:00 0 =

  adbf8000-ae3f8000 rw-p 00000000 00:00 0 =

  ae3f8000-ae742000 rw-p 00000000 00:00 0 =

  ae742000-ae762000 rw-p 00000000 00:00 0 =

  ae762000-ae764000 rw-p 00000000 00:00 0 =

  ae764000-ae784000 rw-p 00000000 00:00 0 =

  ae784000-ae786000 rw-p 00000000 00:00 0 =

  ae786000-b6786000 rw-p 00000000 00:00 0 =

  b6786000-b7894000 rw-p 00000000 00:00 0 =

  b78aa000-b78ab000 rw-p 00000000 00:00 0 =

  bfe95000-bfeaa000 rw-p 00000000 00:00 0          [stack]
  =E5=B7=B2=E6=94=BE=E5=BC=83 (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/700276/+subscriptions
