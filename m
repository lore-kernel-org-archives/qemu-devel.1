Received: from eggs.gnu.org ([2001:4830:134:3::10]:45624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3zyr-0002Bd-1K
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3zyn-0005hq-Qt
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:48744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3zyn-0005ff-Js
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3zym-0003oi-LW
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 993202E8024
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 08:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Apr 2018 08:00:45 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1761401 <1761401@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152291524524.10021.7220810119975025094.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761401] [NEW] ARM/Neon: vcvt rounding error
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

Hello,

While using QEMU commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a (March
28, 2018), I've noticed failures in one of the GCC ARM/Neon tests. The
test passes on hardware, and with QEMU-2.11.0, so it looks like a recent
regression.

The test builds a vector of 4 float32 with "125.9" as value, then converts =
them to 4 uint32_t.
The expected result is 125, but we get 126 instead.

Maybe it's just a matter of default rounding mode?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761401

Title:
  ARM/Neon: vcvt rounding error

Status in QEMU:
  New

Bug description:
  Hello,

  While using QEMU commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a
  (March 28, 2018), I've noticed failures in one of the GCC ARM/Neon
  tests. The test passes on hardware, and with QEMU-2.11.0, so it looks
  like a recent regression.

  The test builds a vector of 4 float32 with "125.9" as value, then convert=
s them to 4 uint32_t.
  The expected result is 125, but we get 126 instead.

  Maybe it's just a matter of default rounding mode?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1761401/+subscriptions
