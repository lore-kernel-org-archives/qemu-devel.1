Received: from eggs.gnu.org ([2001:4830:134:3::10]:39753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIylt-000145-FR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIylp-0008WP-JU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:35927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIylp-0008Vs-E6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIyln-0002fX-1p
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 14:50:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1BD52E819B
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 14:50:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2017 14:38:01 -0000
From: Will Newton <will.newton@gmail.com>
Reply-To: Bug 1696773 <1696773@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149693268144.10005.16353270944603688746.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696773] [NEW] golang calls to exec crash user
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

Public bug reported:

An example program can be found here:

https://github.com/willnewton/qemucrash

This code starts a goroutine (thread) and calls exec repeatedly. This
works ok natively but when run under ARM user emulation it segfaults
(usually, there are occasionally other failures).

** Affects: qemu
     Importance: Undecided
         Status: New

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
