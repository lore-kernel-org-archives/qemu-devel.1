Received: from eggs.gnu.org ([2001:4830:134:3::10]:37590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQUjD-0004PF-LL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQUj8-0007Qj-Mb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQUj8-0007QM-Gv
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:50:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQUj6-0004ZI-Lv
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 07:50:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DCB392E80D8
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 07:50:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 07:42:46 -0000
From: Gerd Hoffmann <1654826@bugs.launchpad.net>
Reply-To: Bug 1654826 <1654826@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170108095922.20152.98230.malonedeb@wampee.canonical.com>
Message-Id: <20170109074246.20059.56596.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1654826] Re: Holding key down using input-linux
 freezes guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

quick workaround: drop "repeat=3Don".
some guests seem to have problems with that, not debugged yet why.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1654826

Title:
  Holding key down using input-linux freezes guest

Status in QEMU:
  New

Bug description:
  Qemu release version 2.8.0
  KVM, kernel 4.9.1

  When using the -object input-linux capability in qemu for passthrough
  of input/evdev devices, I found that when a key is held for a few
  seconds or more (such as ctrl key), the guest system freezes until the
  key is released. In some cases, mouse control is also lost following
  one of these "freezes". I also noticed that one of the four cpu cores
  I have the guest pinned to ramps to 100% during these freezes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1654826/+subscriptions
