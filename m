Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejmbJ-0001Uw-6J
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejmbG-0003xv-2b
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:50:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:50988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejmbF-0003xV-Sh
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:50:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejmbD-0005sM-7a
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C4B272E81A9
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 13:50:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 13:44:32 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1738767 <1738767@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151359638511.16639.9243776100393876848.malonedeb@soybean.canonical.com>
Message-Id: <151809747279.10229.127216187267171519.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738767] Re: Cannot build QEMU on RHEL6 because
 of MAP_HUGETLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This was fixed by the distro updating their glibc-headers pakcage:

* Tue Jul 23 2013 Alexandre Oliva <aoliva@redhat.com> - 2.12-1.119
- Add MAP_HUGETLB and MAP_STACK support (#916986).
- Update translation for stale file handle error (#970776).

The build works in the current centos6 docker image and has been
confirmed to build on later RHEL6 (RHEL6.7).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738767

Title:
  Cannot build QEMU on RHEL6 because of MAP_HUGETLB

Status in QEMU:
  Won't Fix

Bug description:
  Hello,
  I've just downloaded qemu-2.11.0 sources and I wanted to build QEMU on RH=
EL6 x86_64, for various targets, amonst which arm-linux-user.

  The build fails because /usr/include/bits/mman.h does not define
  MAP_HUGETLB.

  I think it is needed since commit 541e16904.

  I'm not sure if RHEL6 is still supported by QEMU? If so, can you fix
  this problem?

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738767/+subscriptions
