Received: from eggs.gnu.org ([209.51.188.92]:34847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhng-00062F-SA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhnf-0006dg-9d
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:27814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvhnb-0006XR-EI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:29 -0500
Message-Id: <cover.1550491301.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 13:01:41 +0100
Subject: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>, philmd@redhat.com

v2 of
http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02477.html
Addressed review comments and removed last patch (sending it
separately) to make this series not depend on my ati-vga patch so it
can be applied independently.

BALATON Zoltan (3):
  hw/pci-host/bonito.c: Add PCI mem region mapped at the correct address
  mips_fulong2e: Fix bios flash size
  mips_fulong2e: Dynamically generate SPD EEPROM data

 hw/mips/mips_fulong2e.c | 40 +++++++++++++++++-----------------------
 hw/pci-host/bonito.c    |  7 ++++++-
 2 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.13.7
