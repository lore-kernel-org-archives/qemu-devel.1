Received: from eggs.gnu.org ([209.51.188.92]:52439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFxdW-0004P2-GC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFxdV-0006hm-GZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:50986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFxdV-0006hZ-76
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFxdT-0000Zo-N5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A301F2E8055
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 09:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 09:02:31 -0000
From: Johan Carlsson <1824778@bugs.launchpad.net>
Reply-To: Bug 1824778 <1824778@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155531895115.20861.16647644389038821246.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824778] [NEW] PowerPC64: tlbivax does not work
 for addresses above 4G
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

The tlbivax instruction in QEMU does not work for address above 4G. The rea=
son behind this is a simple 32bit trunction of an address.
Changing the argument ea from uint32_t to target_ulong for the function boo=
ke206_invalidate_ea_tlb() in target/ppc/mmu_helper.c solves the issue.

I did not reproduce this using Linux so I have no public example for
reproducing it. However it's a pretty straight forward change.

Issue can be seen in all version of QEMU.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ppc

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824778

Title:
  PowerPC64: tlbivax does not work for addresses above 4G

Status in QEMU:
  New

Bug description:
  The tlbivax instruction in QEMU does not work for address above 4G. The r=
eason behind this is a simple 32bit trunction of an address.
  Changing the argument ea from uint32_t to target_ulong for the function b=
ooke206_invalidate_ea_tlb() in target/ppc/mmu_helper.c solves the issue.

  I did not reproduce this using Linux so I have no public example for
  reproducing it. However it's a pretty straight forward change.

  Issue can be seen in all version of QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824778/+subscriptions
