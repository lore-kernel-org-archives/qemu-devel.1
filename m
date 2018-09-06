Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxyye-00060b-28
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxyyZ-0008Kz-3J
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:26:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxyyY-0008KE-Sb
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 14:25:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxyyW-0003dz-Ci
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 18:25:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E9BB2E80CC
	for <qemu-devel@nongnu.org>; Thu,  6 Sep 2018 18:25:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Sep 2018 18:12:49 -0000
From: Jonathan Marler <1790975@bugs.launchpad.net>
Reply-To: Bug 1790975 <1790975@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153618529890.17241.16039771895973290192.malonedeb@chaenomeles.canonical.com>
Message-Id: <153625757022.31814.4319759623473393391.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790975] Re: Default arm virt machine broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- arm virt ecam pcie conflict
+ Default arm virt machine broken

** Description changed:

  This occurs on qemu_v3.0.0 but not on qemu_v2.12.2 (built from
  qemu_v3.0.0 tag on github)
  =

  Symptom: You'll see something like this in the kernel output:
  =

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

- =

- Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel zImage =
-serial stdio
+ Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel zImage
+ -serial stdio
  =

  I can post my zImage if anyone has problems reproducing with their own
  zImage.
+ =

+ Note that this problem breaks pci making the machine unusable.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790975

Title:
  Default arm virt machine broken

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

  Qemu Command Line: qemu-system-arm -machine virt -m 1024M -kernel
  zImage -serial stdio

  I can post my zImage if anyone has problems reproducing with their own
  zImage.

  Note that this problem breaks pci making the machine unusable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790975/+subscriptions
