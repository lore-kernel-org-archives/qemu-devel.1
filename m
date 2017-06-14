Received: from eggs.gnu.org ([2001:4830:134:3::10]:38678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dL02H-00047j-Ni
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dL02E-0001j9-Jg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:36:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:53916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dL02E-0001iH-E0
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:36:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dL02B-0007GL-Gk
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 04:35:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7771D2E8193
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 04:35:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2017 04:17:26 -0000
From: Launchpad Bug Tracker <1030666@bugs.launchpad.net>
Reply-To: Bug 1030666 <1030666@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120730014155.9541.71695.malonedeb@soybean.canonical.com>
Message-Id: <149741384671.17358.16879117718720483018.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1030666] Re: gdb can't proceed after a breakpoint
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
https://bugs.launchpad.net/bugs/1030666

Title:
  gdb can't proceed after a breakpoint

Status in QEMU:
  Expired

Bug description:
  Using qemu-1.1.0-windows.zip package from http://lassauge.free.fr/qemu/
  Host: Windows 7 Ultimate 64-bit
  Guest: i386 system running MS-DOS 6.22
  Launch command line:
  =C2=A0=C2=A0qemu-system-i386.exe -L Bios -fda "DOS.vfd" -fdb "Data.vfd" -=
gdb tcp:127.0.0.1:1234
  Debbugers tried:
  =C2=A0=C2=A0gdb 7.3.50.20111026-cvs running on Cygwin 1.7.16
  =C2=A0=C2=A0gdb 7.4 on MinGW

  Short description:
  I use gdb to attach to a running Qemu session, set a breakpoint and resum=
e execution. When the breakpoint is hit, gdb gains control as expected. How=
ever, trying to single-step or continue at this point just causes the same =
breakpoint to be hit immediately again. Deleting the breakpoint allows sing=
le-stepping or continue to work.

  Steps to reproduce:
  DOS.vfd is a floppy image containing an MS-DOS 6.22 startup disk.
  Data.vfd is a floppy image containing a single program (hello.com).
  The aim is to debug the execution of hello.com with gdb.
  Launch Qemu.
  Launch gdb, an attach to qemu:
  =C2=A0=C2=A0"target remote localhost:1234"
  I know the address at which hello.com will be loaded, so set a breakpoint=
 there and resume execution:
  =C2=A0=C2=A0"break *0xf730"
  =C2=A0=C2=A0"continue"
  In Qemu, start hello.com. The breakpoint is immediately hit, execution st=
ops and gdb gains control.
  Examining the program gives expected results (such as "info reg" or "disa=
ssemble").
  At this point, try to proceed either with single-stepping ("si" or "ni") =
or with "continue", and the same breakpoint is immediately hit again. Subse=
quent attempts to single-step or continue just keep hitting the same breakp=
oint.
  The only way to proceed at this point is to delete the breakpoint, after =
which both single-stepping and continue work.

  Note that single-stepping and continue works as expected if it is done
  after interrupting execution with Ctrl-C.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1030666/+subscriptions
