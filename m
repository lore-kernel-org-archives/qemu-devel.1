Received: from eggs.gnu.org ([2001:4830:134:3::10]:35230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxgAJ-0001sA-PL
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxgAB-000832-Ir
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:20:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:36424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxgAB-0007xD-5c
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxgA9-00082U-Nc
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 22:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9BCF42E80D1
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 22:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 22:08:18 -0000
From: Jonathan Marler <1790975@bugs.launchpad.net>
Reply-To: Bug 1790975 <1790975@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153618529890.17241.16039771895973290192.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790975] [NEW] arm virt ecam pcie conflict
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

This occurs on qemu_v3.0.0 but not on qemu_v2.12.2 (built from
qemu_v3.0.0 tag on github)

Symptom: You'll see something like this in the kernel output:

[    1.285210] OF: PCI: host bridge /pcie@10000000 ranges:
[    1.286246] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
[    1.287061] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
[    1.287820] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
[    1.289312] pci-host-generic 4010000000.pcie: can't claim ECAM area [mem=
 0x10000000-0x1fffffff]: address conflict with /pcie@10000000 [mem 0x100000=
00-0x3efeffff]
[    1.290984] pci-host-generic: probe of 4010000000.pcie failed with error=
 -16


Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel zImage -s=
erial stdio

I can post my zImage if anyone has problems reproducing with their own
zImage.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790975

Title:
  arm virt ecam pcie conflict

Status in QEMU:
  New

Bug description:
  This occurs on qemu_v3.0.0 but not on qemu_v2.12.2 (built from
  qemu_v3.0.0 tag on github)

  Symptom: You'll see something like this in the kernel output:

  [    1.285210] OF: PCI: host bridge /pcie@10000000 ranges:
  [    1.286246] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
  [    1.287061] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
  [    1.287820] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
  [    1.289312] pci-host-generic 4010000000.pcie: can't claim ECAM area [m=
em 0x10000000-0x1fffffff]: address conflict with /pcie@10000000 [mem 0x1000=
0000-0x3efeffff]
  [    1.290984] pci-host-generic: probe of 4010000000.pcie failed with err=
or -16

  =

  Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel zImage =
-serial stdio

  I can post my zImage if anyone has problems reproducing with their own
  zImage.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790975/+subscriptions
