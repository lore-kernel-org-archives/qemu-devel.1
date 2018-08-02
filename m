Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flFw5-00039I-7d
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flFw4-0007n9-I1
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flFw4-0007lv-Bb
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:54:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 16:51:45 +0100
Message-Id: <20180802155147.1863-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] mips: convert devices away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

These patches convert a couple of devices used only by MIPS
boards from using the old_mmio MemoryRegionOps accessor functions.

 * vga-isa-mm: used by the MIPS 'jazz' boards "magnum" and "pica61"
 * bonito pci controller: used by the MIPS "fulong2e" board

Tested only with "make check".

thanks
-- PMM

Peter Maydell (2):
  hw/display/vga-isa-mm: Convert away from old_mmio
  hw/pci-host/bonito: Move away from old_mmio accessors

 hw/display/vga-isa-mm.c |  60 ++++-------------
 hw/pci-host/bonito.c    | 145 +++++-----------------------------------
 2 files changed, 28 insertions(+), 177 deletions(-)

-- 
2.17.1
