Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dkHoJ-0004ZP-SW
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dkHoI-0008WT-U6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:38:11 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dkHoI-0008VL-NM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 18:38:10 -0400
Received: by mail-pg0-x232.google.com with SMTP id 83so350808pgb.3
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 15:38:09 -0700 (PDT)
MIME-Version: 1.0
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 23 Aug 2017 01:38:07 +0300
Message-ID: <CAKSfGUCds0X0zjf+rb8D7ZgAesT6vELJa4=CXTi54i4NEwvN7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Generic PCIE-PCI Bridge GSoC Project Report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

Hi,
I'm a GSoC student and I have completed my project "Generic PCIE-PCI Bridge".
Its aim was to create a new device to replace existing DMI-PCI bridge
as it isn't
cross-platform and doesn't support hotplugging.
By completing this project next goals were achieved:
1. Introduce a brand new pcie-pci-bridge device.
2. Add SHPC support to the Q35 machine in order to enable device
hotplugging into the PCIE-PCI bridge.
3. Fix disabled BUSMASTER bug in Linux kernel.
4. Add QEMU-specific bridge-only PCI capability for additional
resources reservation, such as additional bus number, IO/MEM/PREF
space. The capability usage was implemented in QEMU and SeaBIOS both.
5. Update documentation according to the changes stated above.

All QEMU and SeaBIOS patches have got reviewed-by and tested-by tags.
Linux kernel patches has been accepted for merge in 4.14 version.
Some QEMU (and therefore all SeaBIOS) patches hasn't been merged yet
because of current freeze. But I'm ready to push the patches when it
becomes possible (even though GSoC ends in a week). At the moment in
QEMU only ACPI refactoring and SHPC-enabling patches are merged
upstream.

QEMU series link:
http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03288.html
SeaBIOS series link:
https://mail.coreboot.org/pipermail/seabios/2017-August/011728.html
Linux patch link: http://www.spinics.net/lists/linux-pci/msg63052.html

QEMU part github: https://github.com/zuban32/qemu/commits/v7?author=zuban32
SeaBIOS part github:
https://github.com/zuban32/seabios/commits/qemu_res_cap?author=zuban32

 --
Aleksandr Bezzubikov
