Received: from eggs.gnu.org ([2001:4830:134:3::10]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdhZi-0004Xv-AO
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdhZe-0000Tz-D8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:11:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:47471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdhZe-0000Tj-7D
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 13:11:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdhZc-0006Xx-Eq
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 18:11:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E8D262E80CB
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 18:11:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 17:55:38 -0000
From: Thomas Huth <1273944@bugs.launchpad.net>
Reply-To: Bug 1273944 <1273944@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140129041802.30520.43680.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170214175538.6292.84480.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1273944] Re: multiboot header has 0 in mem_upper
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

tests/multiboot seems to work with current git again, so I assume this
issue has been fixed? Or is there something left to do?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1273944

Title:
  multiboot header has 0 in mem_upper field

Status in QEMU:
  Incomplete

Bug description:
  When booting a multiboot image,. mem_upper is now always zero.

  To test, build qemu from current git head, then do
    cd tests/multiboot
    ./run_test.sh

  You will see the test fail.  In each case mem_upper is 0k.

  git-bisect says the bad commit is
  0169c511554cb0014a00290b0d3d26c31a49818f in qemu.git

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1273944/+subscriptions
