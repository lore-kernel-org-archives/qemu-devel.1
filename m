Received: from eggs.gnu.org ([2001:4830:134:3::10]:49560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHzd-0004c1-09
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHza-0006Vl-73
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:57104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCHza-0006VK-0S
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCHzY-0007wF-PY
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:29:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BBACC2E80C3
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 04:29:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 04:17:27 -0000
From: Launchpad Bug Tracker <1061778@bugs.launchpad.net>
Reply-To: Bug 1061778 <1061778@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121004175127.14632.79087.malonedeb@gac.canonical.com>
Message-Id: <151011464745.16570.14355061189508866268.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1061778] Re: signal mask not reset on exec
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
https://bugs.launchpad.net/bugs/1061778

Title:
  signal mask not reset on exec

Status in QEMU:
  Expired

Bug description:
  Seen in qemu-1.0 under 12.04, but AFAICT from current git it hasn't
  changed.

  ./main-loop.c:qemu_signal_init blocks SIGALRM so it can be handled via
  signalfd.

  ./net/tap.c:launch_script does not reset the signal mask before the
  execv() call, and signal masks are inherited. So the script is run
  with SIGALRM blocked (as can be seen in /proc/$$/status, "SigBlk:
  0000000000002000"). One reasonable example of where this bites is an
  interface up script that calls ping with a timeout to give things a
  chance to settle down before continuing, but abort if this doesn't
  happen within a reasonable time). Since ping uses SIGALRM for the
  timeout, this now never terminates.

  qemu-0.14 didn't block SIGALRM, so such scripts worked fine there.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1061778/+subscriptions
