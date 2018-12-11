Received: from eggs.gnu.org ([2001:4830:134:3::10]:38503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkzY-0002hm-GW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkzW-0006WQ-Do
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:34:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 11 Dec 2018 17:34:02 +0100
Message-Id: <20181211163406.3322-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] Introduce the hw/firmware/ namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

QEMU interacts with various firmwares. We already have some helpers
for some firmwares. Later we will add UEFI helpers.
This series introduce the hw/firmware namespace for this.

There is no need to move hw/smbios sources into a specific directory,
we only focus on the headers.

Since v1 https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01585.h=
tml:
- Addressed Laszlo's comments
- Added R-b (Michael, Corey, Laszlo)

Philippe Mathieu-Daud=C3=A9 (4):
  tests: Remove unused include
  hw/smbios: Restrict access to "hw/smbios/ipmi.h"
  hw/smbios: Remove "smbios_ipmi.h"
  hw/smbios: Move to the hw/firmware/ subdirectory

 MAINTAINERS                              |  2 +-
 hw/arm/virt.c                            |  2 +-
 hw/i386/pc.c                             |  2 +-
 hw/i386/pc_piix.c                        |  2 +-
 hw/i386/pc_q35.c                         |  2 +-
 hw/smbios/smbios-stub.c                  |  2 +-
 hw/smbios/smbios.c                       |  3 +--
 hw/smbios/smbios_build.h                 |  4 ++++
 hw/smbios/smbios_type_38-stub.c          |  2 +-
 hw/smbios/smbios_type_38.c               |  3 +--
 include/hw/{smbios =3D> firmware}/smbios.h |  0
 include/hw/smbios/ipmi.h                 | 15 ---------------
 tests/acpi-utils.c                       |  1 -
 tests/bios-tables-test.c                 |  2 +-
 vl.c                                     |  2 +-
 15 files changed, 15 insertions(+), 29 deletions(-)
 rename include/hw/{smbios =3D> firmware}/smbios.h (100%)
 delete mode 100644 include/hw/smbios/ipmi.h

--=20
2.17.2
