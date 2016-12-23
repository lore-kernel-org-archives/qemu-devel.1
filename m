Received: from eggs.gnu.org ([2001:4830:134:3::10]:52087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKVOT-00081C-8K
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKVOQ-0000Mp-4Z
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:20:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:53358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKVOP-0000Mg-Ug
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:20:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKVOO-0004Ln-PL
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 19:20:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B59F22E80BF
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 19:20:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Dec 2016 19:12:37 -0000
From: =?utf-8?q?Llu=C3=ADs_Vilanova?= <1652373@bugs.launchpad.net>
Reply-To: Bug 1652373 <1652373@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161223191237.2387.49621.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1652373] [NEW] User-mode QEMU is not deterministic
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

QEMU in user-mode (linux-user or bsd-user) has no way to get the
equivalent of the "-icount" argument found in softmmu mode.

It is true that some system calls in user-mode can prevent deterministic
execution, but it would be very simple to patch time-related syscalls to
return a number based on icount when in deterministic mode.

Putting both changes together (icount + time-related syscalls) would
cover the needs for deterministic execution of most benchmarks (i.e.,
those not interacting with the network or other programs in the system).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1652373

Title:
  User-mode QEMU is not deterministic

Status in QEMU:
  New

Bug description:
  QEMU in user-mode (linux-user or bsd-user) has no way to get the
  equivalent of the "-icount" argument found in softmmu mode.

  It is true that some system calls in user-mode can prevent
  deterministic execution, but it would be very simple to patch time-
  related syscalls to return a number based on icount when in
  deterministic mode.

  Putting both changes together (icount + time-related syscalls) would
  cover the needs for deterministic execution of most benchmarks (i.e.,
  those not interacting with the network or other programs in the
  system).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1652373/+subscriptions
