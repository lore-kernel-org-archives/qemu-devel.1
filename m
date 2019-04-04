Received: from eggs.gnu.org ([209.51.188.92]:53789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbJ-0007pi-UE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbJ-0006Xx-2n
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAbI-0006WR-RR
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:49 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 00:12:34 +0200
Message-Id: <20190404221238.12468-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 0/4] hw/mips/r4k: Refactor the Super
 I/O chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series refactor the superio code used in the mips_r4k machine, addin=
g the TYPE_R4K_SUPERIO device.
Doing so we improve the ISASuperIODevice, fixing an easy bug.

This series also demonstrate that no machine access a I8042 ISA device ou=
t of a Super I/O chipset.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (4):
  hw/isa/superio: Rename a variable
  hw/isa/superio: Support more than one IDE bus
  hw/isa/superio: Support chipsets with no Floppy Disk controller
  hw/mips/r4k: Refactor the Super I/O chipset

 hw/isa/isa-superio.c     | 99 +++++++++++++++++++++-------------------
 hw/mips/mips_r4k.c       | 61 ++++++++++++++++++-------
 include/hw/isa/superio.h |  2 +-
 3 files changed, 98 insertions(+), 64 deletions(-)

--=20
2.20.1
