Received: from eggs.gnu.org ([209.51.188.92]:60478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjIeM-00077z-IY
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 01:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjIdv-00065Q-LG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 01:56:27 -0500
Received: from indium.canonical.com ([91.189.90.7]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjIdu-0004BB-Rv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 01:56:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjIdM-0002UO-7o
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 39C812E8054
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 06:47:39 -0000
From: dkg <dkg@fifthhorseman.net>
Reply-To: Bug 1811758 <1811758@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154753485996.31938.10842883255904010357.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811758] [NEW] virtio-rng backend should use
 getentropy() syscall when available
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

According to https://wiki.qemu.org/Features/VirtIORNG the default
backend for `virtio-rng-pci` is `/dev/random`.  Alternately, the user
can point it to a different backend file, like `/dev/urandom`.

However, both of these files have suboptimal behavior in one way or
another, as documented in `random(7)`.  Instead, the default behavior
should be to pull the requested octets from the `getrandom()` system
call, if available, called with no flags set.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811758

Title:
  virtio-rng backend should use getentropy() syscall when available

Status in QEMU:
  New

Bug description:
  According to https://wiki.qemu.org/Features/VirtIORNG the default
  backend for `virtio-rng-pci` is `/dev/random`.  Alternately, the user
  can point it to a different backend file, like `/dev/urandom`.

  However, both of these files have suboptimal behavior in one way or
  another, as documented in `random(7)`.  Instead, the default behavior
  should be to pull the requested octets from the `getrandom()` system
  call, if available, called with no flags set.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811758/+subscriptions
