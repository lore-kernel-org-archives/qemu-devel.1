Received: from eggs.gnu.org ([2001:4830:134:3::10]:40179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF66-0007u6-0k
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1evF64-0005va-Ty
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1evF64-0005uw-NQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:30:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1evF63-0001I1-Ut
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E69B02E806F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:30:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Mar 2018 04:17:36 -0000
From: Launchpad Bug Tracker <1090726@bugs.launchpad.net>
Reply-To: Bug 1090726 <1090726@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121215143506.25420.15556.malonedeb@chaenomeles.canonical.com>
Message-Id: <152082825647.7858.4170512709623856396.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090726

Title:
  qemu does not generate guest cpu topology properly

Status in QEMU:
  Expired

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
