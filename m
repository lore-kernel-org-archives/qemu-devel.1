Received: from eggs.gnu.org ([2001:4830:134:3::10]:60657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfBm-0004kp-1r
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAfBl-0003o0-1t
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAfBk-0003nI-S3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:51:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAfBh-0008AV-Dw
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 16:51:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 32B822E80D9
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 16:51:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 16:31:09 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1568107 <1568107@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160408193555.1623.91065.malonedeb@wampee.canonical.com>
Message-Id: <150972666929.4653.3307619958130646464.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1568107] Re: x86_64 linux-user: setup_rt_frame:
 not implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in 2.9 (we added x86-64 linux-user signal handling
support.)


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1568107

Title:
  x86_64 linux-user: setup_rt_frame: not implemented

Status in QEMU:
  Fix Released

Bug description:
  Trying to run this binary
  (https://github.com/ethcore/parity/releases/download/v1.0.1/parity_linux_=
1.0.1-0_amd64.deb)
  under qemu-x86_64 on ARM, ends like this:

  $ qemu-x86_64 parity --pruning fast

  setup_rt_frame: not implemented
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1568107/+subscriptions
