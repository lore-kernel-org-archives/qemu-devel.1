Received: from eggs.gnu.org ([209.51.188.92]:49406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGGua-0002Wt-K2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGGuX-0000ru-IR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:45:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:54888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGGuW-0000qo-3h
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 01:45:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGGuV-0001Da-8a
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3B1B92E80C8
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 05:37:26 -0000
From: Thomas Huth <1811758@bugs.launchpad.net>
Reply-To: Bug 1811758 <1811758@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154753485996.31938.10842883255904010357.malonedeb@wampee.canonical.com>
Message-Id: <155539304622.13876.14766283166073144058.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811758] Re: virtio-rng backend should use
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

Feel free to send some patches to implement this! Alternatively, you
could also try to write a mail to the virtio-rng maintainer (see the
MAINTAINER file in the top directory of the sources), maybe he can help.

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

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
