Received: from eggs.gnu.org ([2001:4830:134:3::10]:39388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOGh-0007L6-W5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOGe-0002Hg-8q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:50:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:55494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOGd-0002Gg-ER
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:50:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOGc-0007kQ-DA
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F7F62E80CC
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 21:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:38:08 -0000
From: Thomas Huth <1090726@bugs.launchpad.net>
Reply-To: Bug 1090726 <1090726@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121215143506.25420.15556.malonedeb@chaenomeles.canonical.com>
Message-Id: <151562028860.3599.14293034737451584449.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1090726] Re: qemu does not generate guest cpu
 topology properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090726

Title:
  qemu does not generate guest cpu topology properly

Status in QEMU:
  Incomplete

Bug description:
  Adding the option

  -smp 12,sockets=3D2,cores=3D6,threads=3D1

  exposes

  =

  Machine (12GB)
    Socket #0
          L2 L#0 (512KB) + L1 L#0 (64KB) + Core L#0 + PU L#0 (P#0)
          L2 L#1 (512KB) + L1 L#1 (64KB) + Core L#1 + PU L#1 (P#1)
          L2 L#2 (512KB) + L1 L#2 (64KB) + Core L#2 + PU L#2 (P#2)
          L2 L#3 (512KB) + L1 L#3 (64KB) + Core L#3 + PU L#3 (P#3)
          L2 L#4 (512KB) + L1 L#4 (64KB) + Core L#4 + PU L#4 (P#4)
          L2 L#5 (512KB) + L1 L#5 (64KB) + Core L#5 + PU L#5 (P#5)
          L2 L#6 (512KB) + L1 L#6 (64KB) + Core L#6 + PU L#6 (P#6)
          L2 L#7 (512KB) + L1 L#7 (64KB) + Core L#7 + PU L#7 (P#7)
    Socket #1
        L2 L#8 (512KB) + L1 L#8 (64KB) + Core L#8 + PU L#8 (P#8)
        L2 L#9 (512KB) + L1 L#9 (64KB) + Core L#9 + PU L#9 (P#9)
        L2 L#10 (512KB) + L1 L#10 (64KB) + Core L#10 + PU L#10 (P#10)
        L2 L#11 (512KB) + L1 L#11 (64KB) + Core L#11 + PU L#11 (P#11)

  =

  Rather than:

  Machine (12GB)
    Socket #0
          L2 L#0 (512KB) + L1 L#0 (64KB) + Core L#0 + PU L#0 (P#0)
          L2 L#1 (512KB) + L1 L#1 (64KB) + Core L#1 + PU L#1 (P#1)
          L2 L#2 (512KB) + L1 L#2 (64KB) + Core L#2 + PU L#2 (P#2)
          L2 L#3 (512KB) + L1 L#3 (64KB) + Core L#3 + PU L#3 (P#3)
          L2 L#4 (512KB) + L1 L#4 (64KB) + Core L#4 + PU L#4 (P#4)
          L2 L#5 (512KB) + L1 L#5 (64KB) + Core L#5 + PU L#5 (P#5)
    Socket #1
          L2 L#6 (512KB) + L1 L#6 (64KB) + Core L#6 + PU L#6 (P#6)
          L2 L#7 (512KB) + L1 L#7 (64KB) + Core L#7 + PU L#7 (P#7)
          L2 L#8 (512KB) + L1 L#8 (64KB) + Core L#8 + PU L#8 (P#8)
          L2 L#9 (512KB) + L1 L#9 (64KB) + Core L#9 + PU L#9 (P#9)
          L2 L#10 (512KB) + L1 L#10 (64KB) + Core L#10 + PU L#10 (P#10)
          L2 L#11 (512KB) + L1 L#11 (64KB) + Core L#11 + PU L#11 (P#11)

  =

  Here is a cpuid dump from inside the guest and dump from more recent vers=
ion of cpuid, in which you can see a bit more detail. The later contains da=
ta for a single CPU, because the others are the same.

  Reproducible on qemu 1.0 and 1.2. with guest os Fedora 17, Debian 6,
  Debian Squeeze and Windows 2008 R2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090726/+subscriptions
