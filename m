Received: from eggs.gnu.org ([209.51.188.92]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIHUu-0003PL-7M
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIHOT-0006HY-Ui
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:39894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIHOT-0006Go-Pb
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:40:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIHOR-0005Sh-TJ
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB0702E80CC
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Apr 2019 18:35:36 -0000
From: MIke Pestorich <mmpestorich@gmail.com>
Reply-To: Bug 1758819 <1758819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
Message-Id: <155587173674.14005.13395763415156964969.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1758819] Re: HVF Illegal instruction: 4,
 High Sierra, v2.12-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to the response here: https://www.mail-archive.com/qemu-
devel@nongnu.org/msg572220.html

...the call to xgetbv should be guarded against processors that don't
support the instruction. The attached patch seems to work for me but
must admit I am way out of my depth here (I understand nothing about cpu
architecture, features, etc...) and have not tested on anything but my
old MacBook Pro (15-inch, Mid 2010) / MacBookPro6,2. All that I can say
is that for this machine the call to xgetbv is not made and everything
seems to work. I have no idea if this is correct for other
machines/processors or if it correctly detects support of this call...

** Patch added: "x86_cpuid.c.diff"
   https://bugs.launchpad.net/qemu/+bug/1758819/+attachment/5257652/+files/=
x86_cpuid.c.diff

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1758819

Title:
  HVF Illegal instruction: 4, High Sierra, v2.12-rc0

Status in QEMU:
  New

Bug description:
  I've built v2.12.0-rc0 on MacOS using homebrew. I'm running 10.13.3 on
  a 5,1 Mac Pro with a X5690 processor.

  When I run 'qemu-system-x86_64 -M accel=3Dhvf', I get a crash "Illegal
  instruction: 4".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1758819/+subscriptions
