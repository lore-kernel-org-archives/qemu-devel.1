Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7fDS-0000oR-70
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7fDP-0002vY-4b
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:16:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:46414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7fDO-0002ui-V8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:16:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7fDO-0005hd-0j
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 10:16:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0223E2E80CB
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 10:16:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 09:59:51 -0000
From: Thomas Huth <1054812@bugs.launchpad.net>
Reply-To: Bug 1054812 <1054812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120923004004.13209.62505.malonedeb@gac.canonical.com>
Message-Id: <150901199186.17148.18285318564388883131.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1054812] Re: Configure uses wrong libtool on
 Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since libcacard is not longer part of QEMU, I assume this is not an
issue anymore today. So can we close this bug nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1054812

Title:
  Configure uses wrong libtool on Darwin

Status in QEMU:
  Incomplete

Bug description:
  On Darwin/OS X, there are two versions of libtool: the GNU libtool,
  and Apple's libtool. Both are installed, but Apple's libtool (libtool)
  won't build libcacard that Qemu uses, but Gnu's libtool (glibtool)
  does. I get around using Apple's libtool by passing LIBTOOL=3Dglibtool
  when configuring; unfortunately this variable isn't preserved so when
  Qemu's configure changes it's not passed. A simple switch in the
  configure script could check for Darwin, then if present, use
  glibtool. Or configure could check the features of libtool, see if
  they can build libcacard, then look for alternatives like glibtool.

  This bug was probably introduced when libcacard was added to Qemu, and
  is present in commit 93b6599734f81328ee3d608f57667742cafeea72.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1054812/+subscriptions
