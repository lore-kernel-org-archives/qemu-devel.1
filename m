Received: from eggs.gnu.org ([2001:4830:134:3::10]:48001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpoyi-000053-K8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpoye-0005qz-NU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:47196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpoye-0005p1-I6
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 00:31:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpoyb-0006rS-6R
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:31:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2BFAA2E80D2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Mar 2017 04:17:39 -0000
From: Launchpad Bug Tracker <640213@bugs.launchpad.net>
Reply-To: Bug 640213 <640213@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100916064902.14555.15191.malonedeb@potassium.ubuntu.com>
Message-Id: <20170320041740.18559.23893.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 640213] Re: QEMU does not communicate properly
 with GDB with a 64 bit guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/640213

Title:
  QEMU does not communicate properly with GDB with a 64 bit guest

Status in QEMU:
  Expired

Bug description:
  I have been trying to figure out why I cannot debug a 64 bit kernel of
  my own invention.

  I launch qemu-system-x86_64 with the -s -S flags, we also specify -cpu
  core2duo -vga std and a -hda with an ext2 FS holding our multiboot
  kernel and GRUB2.

  When I try to set breakpoints and "continue" in GDB (7.2) using the
  very latest HEAD (b6601141cd2a170dfe773987b06f716a190ea7e0) or 0.12.0
  or 0.12.5 or 13.0.rc0 or 13.0.rc1, I get failures of the same nature:

  0x0000000000000000 in ?? ()
  (gdb) break main
  Breakpoint 1 at 0x101730: file src/kernel/init.c, line 18.
  (gdb) c

  Program received signal SIGTRAP, Trace/breakpoint trap.
  0x0000000000000000 in ?? ()
  (gdb)

  Note that in this case, main lies in 64 bit mode. However, trying to
  break on _start yields virtually the same effect and _start is 32 bit
  code.

  By doing a git bisect, I managed to narrow the commit that introduced thi=
s bug to 5f30fa18ad043a841fe9f0c3917ac60f2519ebd1. Reverting this commit on=
 HEAD seemingly fixed the problem for both the 32 bit and 64 bit cases.
  I might be doing something incorrectly on my end but this seemed to fix t=
he problem.

  Perhaps the pertinent thing to do would be to revert
  5f30fa18ad043a841fe9f0c3917ac60f2519ebd1 as it seems to do nothing but
  break things unless, of course, this would only break something that I
  am not aware of further.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/640213/+subscriptions
