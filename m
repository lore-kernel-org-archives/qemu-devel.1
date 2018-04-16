Received: from eggs.gnu.org ([2001:4830:134:3::10]:51680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7wAG-0005Un-7D
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7wAD-0001VD-3C
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:54:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7wAC-0001Ux-S5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:54:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7wAA-0005rT-MT
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 04:54:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 98E3B2E80D1
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 04:54:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Apr 2018 04:43:43 -0000
From: David Lechner <david@lechnology.com>
Reply-To: Bug 955379 <955379@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120314192314.1716.70997.malonedeb@chaenomeles.canonical.com>
Message-Id: <152385382373.22077.16312883498003198694.malone@wampee.canonical.com>
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

Steps to reproduce:

# on ubuntu bionic amd64 host
sudo apt-add-repository ppa:ev3dev/tools
# assuming apt-add-repository does apt update now
sudo apt install pbuilder-ev3dev git
git clone --depth=3D1 https://github.com/ev3dev/opencv
cd opencv
OS=3Ddebian ARCH=3Darmhf DIST=3Dstretch pbuilder-ev3dev base
OS=3Ddebian ARCH=3Darmhf DIST=3Dstretch pbuilder-ev3dev dev-build

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
  Confirmed
Status in qemu-linaro package in Ubuntu:
  Confirmed

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
