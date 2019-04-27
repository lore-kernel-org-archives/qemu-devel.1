Received: from eggs.gnu.org ([209.51.188.92]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOZp-0005dm-J0
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKOVM-0004ok-4K
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKOVL-0004mS-VE
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:40:40 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 16:40:23 +0200
Message-Id: <20190427144025.22880-2-philmd@redhat.com>
In-Reply-To: <20190427144025.22880-1-philmd@redhat.com>
References: <20190427144025.22880-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] hw/acpi/piix4: Move TYPE_PIIX4_PM to a
 public header
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

Move the TYPE_PIIX4_PM definition to the corresponding header,
so other files can use it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/piix4.c         | 2 --
 include/hw/acpi/piix4.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9c079d68341..160e7308c51 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -92,8 +92,6 @@ typedef struct PIIX4PMState {
     MemHotplugState acpi_memory_hotplug;
 } PIIX4PMState;
=20
-#define TYPE_PIIX4_PM "PIIX4_PM"
-
 #define PIIX4_PM(obj) \
     OBJECT_CHECK(PIIX4PMState, (obj), TYPE_PIIX4_PM)
=20
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index 26c2370e308..57d7e1cda20 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -1,6 +1,8 @@
 #ifndef HW_ACPI_PIIX4_H
 #define HW_ACPI_PIIX4_H
=20
+#define TYPE_PIIX4_PM "PIIX4_PM"
+
 Object *piix4_pm_find(void);
=20
 #endif
--=20
2.20.1
