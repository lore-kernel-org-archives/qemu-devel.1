Received: from eggs.gnu.org ([209.51.188.92]:57066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbG-0008PP-Nq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbE-0005Yz-W6
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbE-0005Yk-R8
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:44 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 28 Apr 2019 08:47:25 +0200
Message-Id: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] hw/acpi: Improve build modularity
 (targeting MIPS/PPC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

This series is not related to the previous one I just send:
hw/i386/acpi: Improve build modularity (isapc/q35/...)
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04678.html

While the first only concern X86 (changes within the architecture),
this one allow the core ACPI feature to be used by the MIPS and
PPC archs (specific series will follow).

v2:
- Fixed IPMI build error (patchew)
- Added possibility to build without ACPI (X86)

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04696.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (6):
  hw/acpi: Move the IPMI stub to the stubs/ directory
  hw/acpi: Move the ACPI stub to the stubs/ directory
  hw/acpi: Simplify the Makefile logic
  hw/acpi: Always build the 'core' ACPI functions
  stubs: Add missing ACPI symbols
  vl: Do not set acpi_enabled when ACPI is disabled at build time

 MAINTAINERS                         |  2 ++
 hw/acpi/Makefile.objs               | 22 +++++++---------------
 hw/acpi/core.c                      |  1 +
 stubs/Makefile.objs                 |  2 ++
 hw/acpi/acpi-stub.c =3D> stubs/acpi.c |  6 ++++++
 hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c |  0
 vl.c                                |  1 -
 7 files changed, 18 insertions(+), 16 deletions(-)
 rename hw/acpi/acpi-stub.c =3D> stubs/acpi.c (93%)
 rename hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c (100%)

--=20
2.20.1
