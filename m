Received: from eggs.gnu.org ([2001:4830:134:3::10]:57423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxX49-0001FJ-Lv
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxX46-0006nq-HQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:48106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxX46-0006nH-BD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxX44-0006Wx-FX
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 722D02E80C7
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Apr 2017 10:52:08 -0000
From: Suramya <1681404@bugs.launchpad.net>
Reply-To: Bug 1681404 <1681404@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170410105209.1613.42620.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681404] [NEW] hw/ppc: Aborted (core dumped)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Reproducable:
$ ./ppc64-softmmu/qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg -device=
 spapr-pci-host-bridge


qemu/hw/ppc/spapr_pci.c:1567:spapr_phb_realize: Object 0x55bda99744a0 is no=
t an instance of type spapr-machine
Aborted (core dumped)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681404

Title:
  hw/ppc: Aborted (core dumped)

Status in QEMU:
  New

Bug description:
  Reproducable:
  $ ./ppc64-softmmu/qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg -devi=
ce spapr-pci-host-bridge

  =

  qemu/hw/ppc/spapr_pci.c:1567:spapr_phb_realize: Object 0x55bda99744a0 is =
not an instance of type spapr-machine
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681404/+subscriptions
