Received: from eggs.gnu.org ([2001:4830:134:3::10]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elBrD-0003pC-33
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elBr9-0003cm-5x
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:01:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:35024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elBr9-0003aH-0D
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:01:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elBr5-0007sh-LI
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A26912E81A1
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 11:01:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2018 10:48:18 -0000
From: mou <arnaudalies.py@gmail.com>
Reply-To: Bug 1748612 <1748612@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151826550949.29267.10613371512725916399.malonedeb@chaenomeles.canonical.com>
Message-Id: <151843249856.2927.62089060870095582.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1748612] Re: qemu-user option -strace -D <file>
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I will check that again, pretty sure I saw that.
Anyway any chance there is an option/fix for that?
Today it is impossible to differentiate strace output with program's stderr=
 output, and it is causing trouble while used in scripts.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1748612

Title:
  qemu-user option -strace -D <file> doesn't work

Status in QEMU:
  New

Bug description:
  I have been trying to access qemu -strace output from a script
  The main problem was it was on stderr, the strace output was merged with =
my program's stderr output.
  Then I tried to use the -D option, to log the output to a file.
  This didn't work even if the log file was created, but it was empty.

  I have looked at the source code and found the print function was not
  qemu_log with -strace but gemu_log (to be clear it was GEMU NOT QEMU)

  =

  I have then replaced all gemu_log by qemu_log removed declaration of gemu=
_log and recompiled, it seems to works just fine right now.

  removed declaration here and here:
  https://github.com/qemu/qemu/blob/master/linux-user/main.c#L108
  https://github.com/qemu/qemu/blob/master/linux-user/qemu.h#L203

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1748612/+subscriptions
