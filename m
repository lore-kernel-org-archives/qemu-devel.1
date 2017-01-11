Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRO2r-0001dH-Oh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRO2o-00022F-OM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:54:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:41662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRO2o-00021F-J2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:54:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRO2m-0006tK-LJ
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:54:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 764F62E80C4
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:54:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 18:37:13 -0000
From: Thomas Huth <1256432@bugs.launchpad.net>
Reply-To: Bug 1256432 <1256432@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131129213129.3056.19756.malonedeb@gac.canonical.com>
Message-Id: <20170111183713.26830.19249.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1256432] Re: qemu mingw 32bit windows crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which QEMU version did you use? Can you still reproduce this with the
latest release?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1256432

Title:
  qemu mingw 32bit windows crash

Status in QEMU:
  Incomplete

Bug description:
  is it a known bug that in windows that even if you do ./configure
  --disable-coroutine-pool it still builds the coroutine stuff so when
  you try and run the build after its compiled it crashses? you have to
  actually edit config-host.mak and change the c flags around.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1256432/+subscriptions
