Received: from eggs.gnu.org ([2001:4830:134:3::10]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkd-0000JD-A6
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkc-0001Wx-DX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:45830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYkc-0001WA-7u
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYka-000748-UJ
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CCA122E80CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:30:12 -0000
From: Thomas Huth <1246890@bugs.launchpad.net>
Reply-To: Bug 1246890 <1246890@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131031204829.23918.15114.malonedeb@gac.canonical.com>
Message-Id: <20170117183014.21058.55319.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1246890] Re: AC97 sound card crashes QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1246890

Title:
  AC97 sound card crashes QEMU

Status in QEMU:
  Fix Released

Bug description:
  The AC97 sound card does not work. It stops QEMU on startup. The cause
  appears to be some kind of deadlock.

  Steps to reproduce:
  Just add -soundhw ac97 to QEMU's arguments. Example: qemu-system-ppc -sou=
ndhw ac97

  The example above is all it takes to reproduce the problem.

  This problem has been observed on Mac OS X and Debian Linux.

  I question whether the ac97 support ever worked. It is a file that was
  taken from VirtualBox and added to QEMU. I do know that VirtualBox's
  support for the ac97 sound card works perfectly.

  The exact line of code that stops QEMU in its tracks is located in the
  file main-loop.c, in the function os_host_main_loop_wait(), the call
  made to qemu_mutex_lock_iothread(). The is where QEMU stops under Mac
  OS X.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1246890/+subscriptions
