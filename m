Received: from eggs.gnu.org ([2001:4830:134:3::10]:41847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7y9I-0005rk-ML
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7y9E-0008V3-Ql
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:02:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:43604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7y9E-0008Rk-L3
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:01:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7y9B-0004aE-OZ
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:01:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B59D72E80CB
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:01:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Apr 2018 06:48:27 -0000
From: ChristianEhrhardt <955379@bugs.launchpad.net>
Reply-To: Bug 955379 <955379@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120314192314.1716.70997.malonedeb@chaenomeles.canonical.com>
Message-Id: <152386130838.31320.18267148763064196987.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 955379] Re: cmake hangs with qemu-arm-static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu (Ubuntu Xenial)
   Importance: Undecided
       Status: New

** Also affects: qemu-linaro (Ubuntu Xenial)
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/955379

Title:
  cmake hangs with qemu-arm-static

Status in QEMU:
  Fix Released
Status in Linaro QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu-linaro package in Ubuntu:
  Confirmed
Status in qemu source package in Xenial:
  Incomplete
Status in qemu-linaro source package in Xenial:
  New

Bug description:
  I'm using git commit 3e7ecd976b06f... configured with --target-list
  =3Darm-linux-user --static in a chroot environment to compile some
  things. I ran into this problem with both pcl and opencv-2.3.1. cmake
  consistently freezes at some point during its execution, though in a
  different spot each time, usually during a step when it's searching
  for some libraries. For instance, pcl most commonly stops after:

  [snip]
  -- Boost version: 1.46.1
  -- Found the following Boost libraries:
  --   system
  --   filesystem
  --   thread
  --   date_time
  -- checking for module 'eigen3'
  --   found eigen3, version 3.0.1

  which is perplexing because it freezes after finding what it wants,
  not during the search. When it does get past that point, it does so
  almost immediately but freezes somewhere else.

  I'm using 64-bit Ubuntu 11.10 with kernel release 3.0.0-16-generic
  with an Intel i5.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/955379/+subscriptions
