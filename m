Received: from eggs.gnu.org ([209.51.188.92]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Gj-0004KD-D2
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Gi-00029d-AX
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38Gh-00028Z-WF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:12 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:43 +0100
Message-Id: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] Kconfig: Clean up the PIIX southbridge
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series is a cleanup for the PIIX/PIIX3/PIIX4 devices.

The isapc machine split isn't clean because while designed
on a PIIX3, our model uses ACPI features from the PIIX4.

The i440fx cleanup is left for the the next development cycle.

This series is a prerequisite for the MIPS Malta port to Kconfig.

Please review.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (8):
  hw/i2c: The ACPI_SMBUS Kconfig depends on ACPI
  hw/input: Add 8042 PS/2 Keyboard Controller to Kconfig
  hw/southbridge: Add the PIIX chipset to Kconfig
  hw/southbridge: Add the PIIX3 chipset to Kconfig
  hw/southbridge: Cleanup the PIIX4 chipset in Kconfig
  hw/southbridge: Add ACPI_PIIX4 to Kconfig
  hw/i386: The 'isapc' machine is built around a PIIX3 southbridge
  hw/i386: Move ACPI_SMBUS out of I440FX (Kconfig)

 default-configs/mips-softmmu-common.mak |  1 +
 hw/acpi/Kconfig                         |  7 +++++++
 hw/acpi/Makefile.objs                   |  3 ++-
 hw/i2c/Kconfig                          |  1 +
 hw/i386/Kconfig                         |  9 ++++----
 hw/ide/Kconfig                          |  1 +
 hw/input/Kconfig                        |  4 ++++
 hw/isa/Kconfig                          | 28 ++++++++++++++++++++++++-
 8 files changed, 47 insertions(+), 7 deletions(-)

--=20
2.20.1
