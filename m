Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUGd-00071Q-Ko
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUGZ-00043m-HI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUGZ-00043U-Bt
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:49:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUGY-0002Y8-4m
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:49:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 069D32E80CB
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:49:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:39:32 -0000
From: Thomas Huth <1024275@bugs.launchpad.net>
Reply-To: Bug 1024275 <1024275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120713074334.30448.10631.malonedeb@gac.canonical.com>
Message-Id: <20170407133932.2559.65937.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1024275] Re: bad iteraction between -daemonize
 and -nographic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to the Debian bug tracker, this has been fixed with this upstream=
 commit:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dab51b1d568e02c80b1abf9016b=
da3a86dc1db389
... so let's close this now.

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1024275

Title:
  bad iteraction between -daemonize and -nographic

Status in QEMU:
  Fix Released
Status in qemu package in Debian:
  Fix Released

Bug description:
   $ qemu -daemonize -nographic
   $ _

  After this, the terminal is switched to some weird mode, not
  processing cr/lf, and not showing the characters being typed (it is
  fixable by using `stty sane').

  Something is seriously wrong here: When -daemonize is given, qemu not
  touch tty parameters at all.

  Thanks,

  /mjt

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1024275/+subscriptions
