Received: from eggs.gnu.org ([209.51.188.92]:45725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaT-00063p-Kt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTg-0005jO-7q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:05 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:45956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTg-0005iY-3N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:04 -0500
Received: by mail-qk1-f177.google.com with SMTP id y78so20547qka.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:44:02 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-22-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/25] i386,
 acpi: cleanup build_facs by removing second unused argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Wei Yang <richardw.yang@linux.intel.com>

The second argument of build_facs() is not used, just remove it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 26cef4af2d..9ecc96dcc7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -298,7 +298,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 /* FACS */
 static void
-build_facs(GArray *table_data, BIOSLinker *linker)
+build_facs(GArray *table_data)
 {
     AcpiFacsDescriptorRev1 *facs = acpi_data_push(table_data, sizeof *facs);
     memcpy(&facs->signature, "FACS", 4);
@@ -2637,7 +2637,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * requirements.
      */
     facs = tables_blob->len;
-    build_facs(tables_blob, tables->linker);
+    build_facs(tables_blob);
 
     /* DSDT is pointed to by FADT */
     dsdt = tables_blob->len;
-- 
MST
