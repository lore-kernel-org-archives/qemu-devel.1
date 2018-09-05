Received: from eggs.gnu.org ([2001:4830:134:3::10]:59138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxcaJ-0006l4-Bb
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 14:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxcaG-0001uR-0p
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 14:31:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxcaF-0001sg-QA
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 14:31:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxcaE-0004uk-P5
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 18:31:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B77D42E80CB
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 18:31:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 18:24:27 -0000
From: Edward Vielmetti <edward.vielmetti@gmail.com>
Reply-To: Bug 1696773 <1696773@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149693268144.10005.16353270944603688746.malonedeb@wampee.canonical.com>
Message-Id: <153617186712.28213.2294071721912284522.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696773] Re: golang calls to exec crash user
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug is mentioned in this account from Cloudflare of porting their
software stack to arm64:

https://blog.cloudflare.com/porting-our-software-to-arm64/

The relevant section from that blog reads as follows:

# Intermittent Go Failures

> With a decent amount of Go code running through our CI system, it was
easy to spot a trend of intermittent segfaults.

> Going on a hunch, we confirmed a hypothesis that non-deterministic
failures are generally due to threading issues. Unfortunately, opinion
on the issue tracker showed that Go / QEMU incompatibilities aren=E2=80=99t=
 a
priority, so we were left without an upstream fix.

> The workaround we came up with is simple: if the problem is threading-
related, limit where the threads can run! When we package our internal
go binaries, we add a .deb post-install script to detect if we=E2=80=99re
running under ARM64 emulation, and if so, reduce the number of CPUs the
go binary can run under to one. We lose performance by pinning to one
CPU, but this slowdown is negligible when we=E2=80=99re already running und=
er
emulation, and slow code is better than non-working code.

> With the workaround in place, reports of intermittent crashes dropped
to zero. Onto the next problem!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696773

Title:
  golang calls to exec crash user emulation

Status in QEMU:
  New

Bug description:
  An example program can be found here:

  https://github.com/willnewton/qemucrash

  This code starts a goroutine (thread) and calls exec repeatedly. This
  works ok natively but when run under ARM user emulation it segfaults
  (usually, there are occasionally other failures).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696773/+subscriptions
