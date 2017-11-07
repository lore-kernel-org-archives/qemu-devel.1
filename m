Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7ZD-0008Sa-BL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7ZA-0003nV-3v
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:21:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:41776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC7Z9-0003mq-Rw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:21:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC7Z6-0006ZY-VE
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:21:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EB49A2E80D4
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:21:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:09:21 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1054812 <1054812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120923004004.13209.62505.malonedeb@gac.canonical.com>
Message-Id: <151007456130.4416.258102951369995372.malone@chaenomeles.canonical.com>
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

Yes, libtool handling was removed entirely in commit e999ee443496b, so
this bug is no longer present.


** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1054812

Title:
  Configure uses wrong libtool on Darwin

Status in QEMU:
  Fix Released

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
