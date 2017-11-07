Received: from eggs.gnu.org ([2001:4830:134:3::10]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7qu-00048F-Fx
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7qd-0005My-91
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:39:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:46552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC7qd-0005M7-3F
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:39:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC7qc-000266-48
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:39:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D0D62E80CB
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:39:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:25:12 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1361912 <1361912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140826235443.27649.64438.malonedeb@soybean.canonical.com>
Message-Id: <151007551304.20448.11190001349496016319.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1361912] Re: qemu-mips64 Segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've just checked with current head-of-git QEMU and we can execute the
attached mips executable OK, so we've clearly fixed this bug at some
point in the last three years. Closing as fix-committed, since the fix
will definitely be in 2.11, though it's quite likely that 2.10 would
also work.


** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: qemu
       Status: Incomplete =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1361912

Title:
  qemu-mips64 Segmentation fault

Status in QEMU:
  Fix Committed

Bug description:
  When I ran qemu-mips64 for any mips 64 executable , I got this error:

  $ ./qemu-mips64  ../lang
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

  Is this a known issue?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1361912/+subscriptions
