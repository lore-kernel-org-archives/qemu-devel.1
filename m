Received: from eggs.gnu.org ([2001:4830:134:3::10]:40826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeUL-0005Wx-7G
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBeUI-0002vs-4x
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:50:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:60814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBeUH-0002vY-US
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBeUF-0004Rc-HW
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7832D2E8199
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:50:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 10:38:57 -0000
From: Thomas Huth <1761401@bugs.launchpad.net>
Reply-To: Bug 1761401 <1761401@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152291524524.10021.7220810119975025094.malonedeb@soybean.canonical.com>
Message-Id: <152473913939.21665.1252505239958606906.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761401] Re: ARM/Neon: vcvt rounding error
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
https://bugs.launchpad.net/bugs/1761401

Title:
  ARM/Neon: vcvt rounding error

Status in QEMU:
  Fix Released

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
