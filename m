Received: from eggs.gnu.org ([209.51.188.92]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NU-0000PQ-2N
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NT-00054m-1E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:28 -0400
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 12 Apr 2019 23:06:14 +0200
Message-Id: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH 0/4] Improve 40p, make AIX 5.1 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>

This series makes various fixes for the -M 40p target.
Particularly now it's possible to boot AIX 5.1 (both from a cdrom
and a hard disk).

The OFW image: 
https://github.com/artyom-tarasenko/openfirmware/releases/download/20190406-AIX-boots/q40pofw-serial.rom

The command line:
qemu-system-ppc -M 40p -bios q40pofw-serial.rom -serial telnet::4441,server -hda aix-hdd.qcow2 -cdrom \
/path/to/aix-5.1-cd1.iso  -vga none -nographic

More info can be found here:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Artyom Tarasenko (4):
  lsi53c895a: hide 53c895a registers in 53c810
  40p and prep: implement PCI bus mastering
  target/ppc: improve performance of large BAT invalidations
  hw/isa/i82378.c: use 1900 as a base year

 hw/isa/i82378.c         |  4 +++-
 hw/pci-host/prep.c      | 15 +++++++++++----
 hw/scsi/lsi53c895a.c    | 31 ++++++++++++++++++++++++++-----
 target/ppc/mmu_helper.c |  7 +++++++
 4 files changed, 47 insertions(+), 10 deletions(-)

-- 
2.7.2
