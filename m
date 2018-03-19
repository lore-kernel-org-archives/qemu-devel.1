Received: from eggs.gnu.org ([2001:4830:134:3::10]:43983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exvoN-0007ZL-Lm
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exvoK-0007k5-GA
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:44594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exvoK-0007iX-98
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exvoI-0002l3-9H
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 41FC72E80CD
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Mar 2018 14:18:06 -0000
From: ChristianEhrhardt <1756807@bugs.launchpad.net>
Reply-To: Bug 1756807 <1756807@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152144414128.31022.3971379528979064267.malonedeb@wampee.canonical.com>
Message-Id: <152146908641.3335.1426880459501386835.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756807] Re: performance regression in qemu-user
 + proot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the check Alistar,

Lets add a Qemu (upstream) bug task so this one is mirrored to the ML.

I'm not familiar with that area, but on the ML one can decide if it is a
dup to https://bugs.launchpad.net/qemu/+bug/1740219 or not.

** Also affects: qemu
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756807

Title:
  performance regression in qemu-user + proot

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  To reproduce:

  1. Install qemu-user-static and proot
  2. Enter some arm chroot using them:

      proot -0 -q qemu-arm-static -w / -r chroot/ /bin/bash

  3. Run a command which normally takes a short but measurable amount of
  time:

      cd /usr/share/doc && time grep -R hello

  Result:

  This is over 100 times slower on 18.04 than it was on 16.04. I am not
  sure if proot or qemu is causing the problem, but proot version has
  not changed. Also note that on 16.04 I am using the cloud repo version
  of qemu, which is newer than 16.04 stock, but still older than 18.04.

  Although system 2 is lower spec than system 1, it should not be this
  much slower. No other software seems to be affected.

  If required I can supply a chroot tarball. It is essentially just a
  Debian bootstrap though.

  Logs:


  System 1: i7-6700 3.4GHz, 32GB RAM, 512GB Crucial MX100 SSD, Ubuntu 16.04
  qemu-arm version 2.10.1(Debian 1:2.10+dfsg-0ubuntu3.4~cloud0)
  proot 5.1.0

  al@al-desktop:~/rpi-ramdisk/raspbian$ proot -0 -q qemu-arm-static -w / -r=
 root/ /bin/bash
  root@al-desktop:/# cd /usr/share/doc
  root@al-desktop:/usr/share/doc# time grep -R hello
  dash/copyright:Debian GNU/Linux hello source package as the file COPYING.=
  If not,

  real	0m0.066s
  user	0m0.040s
  sys	0m0.008s



  System 2: i5-5300U 2.30GHz, 8GB RAM, 256GB Crucial MX300 SSD, Ubuntu 18.04
  qemu-arm version 2.11.1(Debian 1:2.11+dfsg-1ubuntu4)
  proot 5.1.0

  al@al-thinkpad:~/rpi-ramdisk/raspbian$ proot -0 -q qemu-arm-static -w / -=
r root/ /bin/bash
  root@al-thinkpad:/# cd /usr/share/doc
  root@al-thinkpad:/usr/share/doc# time grep -R hello
  dash/copyright:Debian GNU/Linux hello source package as the file COPYING.=
  If not,

  real	0m24.176s
  user	0m0.366s
  sys	0m11.352s

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu (not installed)
  ProcVersionSignature: Ubuntu 4.15.0-12.13-generic 4.15.7
  Uname: Linux 4.15.0-12-generic x86_64
  ApportVersion: 2.20.8-0ubuntu10
  Architecture: amd64
  Date: Mon Mar 19 07:13:25 2018
  InstallationDate: Installed on 2018-03-18 (0 days ago)
  InstallationMedia: Xubuntu 18.04 LTS "Bionic Beaver" - Alpha amd64 (20180=
318)
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756807/+subscriptions
