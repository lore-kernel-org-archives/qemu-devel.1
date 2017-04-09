Received: from eggs.gnu.org ([2001:4830:134:3::10]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cx4UJ-0003Yr-Tg
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 00:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cx4UG-0000ka-QE
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 00:30:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:46939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cx4UG-0000jB-KY
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 00:30:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cx4UC-0005rf-F5
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BCC4D2E80DB
	for <qemu-devel@nongnu.org>; Sun,  9 Apr 2017 04:29:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Apr 2017 04:17:29 -0000
From: Launchpad Bug Tracker <899140@bugs.launchpad.net>
Reply-To: Bug 899140 <899140@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111202125742.13621.362.malonedeb@soybean.canonical.com>
Message-Id: <20170409041729.30096.24214.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 899140] Re: Problem with Linux Kernel Traffic
 Control
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
https://bugs.launchpad.net/bugs/899140

Title:
  Problem with Linux Kernel Traffic Control

Status in QEMU:
  Expired

Bug description:
  Hi,

  The last main versions of QEMU (0.14.1, 0.15 and 1.0) have an important p=
roblem when running on a Linux distribution which running itself a Traffic =
Control (TC) instance.
  Indeed, when TC is configured with a Token Bucket Filter (TBF) with a par=
ticular rate, the effective rate is very slower than the desired one.

  For instance, lets consider the following configuration :

  # tc qdisc add dev eth0 root tbf rate 20mbit burst 20k latency 50ms

  The effective rate will be about 100kbit/s ! (verified with iperf)
  I've encountered this problem on versions 0.14.1, 0.15 and 1.0 but not wi=
th the 0.14.0...
  In the 0.14.0, we have a rate of 19.2 mbit/s which is quiet normal.

  I've done the experimentation on several hosts :

  - Debian 32bit core i7, 4GB RAM
  - Debian 64bit core i7, 8GB RAM
  - 3 different high performance servers : Ubuntu 64 bits, 48 AMD Opteron, =
128GB of RAM

  The problem is always the same... The problem is also seen with a
  Class Based Queuing (CBQ) in TC.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/899140/+subscriptions
