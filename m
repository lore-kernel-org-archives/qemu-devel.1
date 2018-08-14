Received: from eggs.gnu.org ([2001:4830:134:3::10]:53613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpdxe-0006jE-2Y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpdw3-00082F-2s
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:60316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpdw2-00081z-R6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpdw0-0001D8-2h
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 18:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F068B2E853D
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 18:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 18:14:42 -0000
From: Elmar Hanlhofer <1787002@bugs.launchpad.net>
Reply-To: Bug 1787002 <1787002@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153427048296.8641.7939320989015317966.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787002] [NEW] disas/i386.c compile error
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

QEMU Version: 2.12.1, 3.0.0-rc4
Compiling with GCC 8.2.0
System: Plop Linux, 32 bit =


Error:
  CC      disas/i386.o
/tmp/ccK8tHRs.s: Assembler messages:
/tmp/ccK8tHRs.s:53353: Error: can't resolve `L0=01' {*ABS* section} - `obuf=
' {.bss section}


The problematic line is in 'disas/i386.c' in the function 'INVLPG_Fixup (in=
t bytemode, int sizeflag)':
strcpy (obuf + strlen (obuf) - 6, alt);

If I comment out this line, then compiling works without problems.


The error comes only on 32 bit. On 64 bit, compiling works without problems.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787002

Title:
  disas/i386.c compile error

Status in QEMU:
  New

Bug description:
  QEMU Version: 2.12.1, 3.0.0-rc4
  Compiling with GCC 8.2.0
  System: Plop Linux, 32 bit =


  Error:
    CC      disas/i386.o
  /tmp/ccK8tHRs.s: Assembler messages:
  /tmp/ccK8tHRs.s:53353: Error: can't resolve `L0=01' {*ABS* section} - `ob=
uf' {.bss section}

  =

  The problematic line is in 'disas/i386.c' in the function 'INVLPG_Fixup (=
int bytemode, int sizeflag)':
  strcpy (obuf + strlen (obuf) - 6, alt);

  If I comment out this line, then compiling works without problems.

  =

  The error comes only on 32 bit. On 64 bit, compiling works without proble=
ms.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787002/+subscriptions
