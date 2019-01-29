Received: from eggs.gnu.org ([209.51.188.92]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1goHB6-0003TK-MJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1goGxv-0000Bb-DF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:09:24 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 29 Jan 2019 08:08:19 +0800
Message-Id: <20190129000820.31190-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190129000820.31190-1-richardw.yang@linux.intel.com>
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
	<20190129000820.31190-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] hw/acpi: remove unused function
 acpi_table_add_builtin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, laurent@vivier.eu, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Function acpi_table_add_builtin() is not used anymore.

Remove the definition and declaration.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/core.c         | 6 ------
 include/hw/acpi/acpi.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index d6f0709691..e9b1a85e54 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -305,12 +305,6 @@ out:
 
 static bool acpi_table_builtin = false;
 
-void acpi_table_add_builtin(const QemuOpts *opts, Error **errp)
-{
-    acpi_table_builtin = true;
-    acpi_table_add(opts, errp);
-}
-
 unsigned acpi_table_len(void *current)
 {
     struct acpi_table_header *hdr = current - sizeof(hdr->_length);
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index c20ace0d0b..4a8bbaf1b5 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -190,7 +190,6 @@ uint8_t *acpi_table_first(void);
 uint8_t *acpi_table_next(uint8_t *current);
 unsigned acpi_table_len(void *current);
 void acpi_table_add(const QemuOpts *opts, Error **errp);
-void acpi_table_add_builtin(const QemuOpts *opts, Error **errp);
 
 typedef struct AcpiSlicOem AcpiSlicOem;
 struct AcpiSlicOem {
-- 
2.19.1
