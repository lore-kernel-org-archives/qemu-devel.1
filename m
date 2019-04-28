Received: from eggs.gnu.org ([209.51.188.92]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbf-0000K2-94
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbe-0006Aj-Bl
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbe-0006AH-6W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:10 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 28 Apr 2019 08:47:30 +0200
Message-Id: <20190428064731.29913-6-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/6] stubs: Add missing ACPI symbols
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

When building with ACPI disabled, we get:

  /usr/bin/ld: hw/i386/pc.o: in function `bochs_bios_init':
  /source/qemu/hw/i386/pc.c:1017: undefined reference to `acpi_tables_len=
'
  /usr/bin/ld: /source/qemu/hw/i386/pc.c:1017: undefined reference to `ac=
pi_tables'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1

These symbols are indeed declared as extern in "hw/acpi/acpi.h".
Add them as stub to satisfy the linker.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 stubs/acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/stubs/acpi.c b/stubs/acpi.c
index 4c9d081ed48..cd0119f9fb1 100644
--- a/stubs/acpi.c
+++ b/stubs/acpi.c
@@ -23,6 +23,10 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/acpi/acpi.h"
=20
+size_t acpi_tables_len;
+
+char unsigned *acpi_tables;
+
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
--=20
2.20.1
