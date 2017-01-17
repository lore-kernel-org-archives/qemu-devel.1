Received: from eggs.gnu.org ([2001:4830:134:3::10]:42931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkb-0000IK-V0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkY-0001Uh-Sk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:45723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYkY-0001Tu-Ml
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYkW-00070f-Kl
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95EE52E80C0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:33:34 -0000
From: Thomas Huth <1429313@bugs.launchpad.net>
Reply-To: Bug 1429313 <1429313@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150307012053.4273.24823.malonedeb@wampee.canonical.com>
Message-Id: <20170117183335.20224.29365.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1429313] Re: qemu-user doesn't block target
 signals on entry to signal hanlder.
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
https://bugs.launchpad.net/bugs/1429313

Title:
  qemu-user doesn't block target signals on entry to signal hanlder.

Status in QEMU:
  Fix Released

Bug description:
  Upon entry to a target signal handler the function
  process_pending_signals in linux-user/signal.c block the appropriate
  host signals, but signals already received and queued by Qemu are not
  blocked. If multiple signals arrive in quick succession this results
  incorrect recursion in the target signal handler.

  The attached test case my be run as:

  $ (sleep 2 ; echo) | qemu-i386 ./a.out
  .................. Recursion in signal handler!
  qemu: uncaught target signal 6 (Aborted) - core dumped

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1429313/+subscriptions
