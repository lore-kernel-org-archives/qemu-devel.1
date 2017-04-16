Received: from eggs.gnu.org ([2001:4830:134:3::10]:45045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czbp7-00085x-Pe
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 00:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1czbp3-0002vs-Rc
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 00:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:55424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1czbp3-0002uw-Lr
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 00:30:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1czbp0-0002Oi-PM
	for <qemu-devel@nongnu.org>; Sun, 16 Apr 2017 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 481262E8195
	for <qemu-devel@nongnu.org>; Sun, 16 Apr 2017 04:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Apr 2017 04:17:30 -0000
From: Launchpad Bug Tracker <1273944@bugs.launchpad.net>
Reply-To: Bug 1273944 <1273944@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140129041802.30520.43680.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170416041730.26274.28430.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1273944

Title:
  multiboot header has 0 in mem_upper field

Status in QEMU:
  Expired

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
