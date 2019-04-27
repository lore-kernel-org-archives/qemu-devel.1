Received: from eggs.gnu.org ([209.51.188.92]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOZq-0005eR-8P
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOVJ-0004iz-B5
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOVJ-0004hS-5l
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:37 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 16:40:22 +0200
Message-Id: <20190427144025.22880-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw/i386/acpi: Improve build modularity
 (isapc/q35/...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This series allow to build the ISAPC/Q35 machines independently.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  hw/acpi/piix4: Move TYPE_PIIX4_PM to a public header
  hw/i386/acpi: Add object_resolve_type_unambiguous to improve
    modularity
  hw/i386/acpi: Assert a pointer is not null BEFORE using it

 hw/acpi/piix4.c         | 13 -------------
 hw/i386/acpi-build.c    | 22 +++++++++++++++++-----
 hw/isa/lpc_ich9.c       | 11 -----------
 include/hw/acpi/piix4.h |  2 +-
 include/hw/i386/ich9.h  |  2 --
 5 files changed, 18 insertions(+), 32 deletions(-)

--=20
2.20.1
