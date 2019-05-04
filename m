Received: from eggs.gnu.org ([209.51.188.92]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oF-0003rl-Bo
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004Zy-Cb
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hN1oE-0004Yx-4t
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so6466823wrb.2
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 14:03:01 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat,  4 May 2019 23:02:31 +0200
Message-Id: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] Improve 40p, make AIX 5.1 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>


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

Artyom Tarasenko (3):
  lsi53c895a: hide 53c895a registers in 53c810
  40p and prep: implement PCI bus mastering
  hw/isa/i82378.c: use 1900 as a base year

 hw/isa/i82378.c      |  4 +++-
 hw/pci-host/prep.c   | 15 +++++++++++----
 hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.7.2
