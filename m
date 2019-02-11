Received: from eggs.gnu.org ([209.51.188.92]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt3FL-0003TI-7L
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gt32A-0006AC-I2
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:34 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:41247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gt325-0005pF-Vg
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 23:17:27 -0500
Message-Id: <cover.1549857716.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 11 Feb 2019 05:01:56 +0100
Subject: [Qemu-devel] [PATCH 0/4] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>

Hello,

These are some misc patches to get the fulong2e emulation in a better
shape. With my recent via-ide changes and the separately submitted
hw/display: Add basic ATI VGA emulation
patch and after this series the pmon_2e.bin firmware from
https://mirrors.cloud.tencent.com/loongson/pmon/
can actually run and appears to work. I could not find an image to
boot so I could not test that further but this appears to be an
improvement that worth submitting now.

Regards,
BALATON Zoltan

BALATON Zoltan (4):
  hw/pci-host/bonito.c: Add PCI mem region mapped at the correct address
  mips_fulong2e: Fix bios flash size
  mips_fulong2e: Dynamically generate SPD EEPROM data
  mips_fulong2e: Add on-board graphics chip

 hw/mips/mips_fulong2e.c | 46 +++++++++++++++++++++++-----------------------
 hw/pci-host/bonito.c    |  5 ++++-
 2 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.13.7
