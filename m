Received: from eggs.gnu.org ([209.51.188.92]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gmuZh-0006m5-9I
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gmuZg-0006cr-Hn
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:02:45 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri, 25 Jan 2019 14:01:57 +0800
Message-Id: <20190125060157.29935-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190125060157.29935-1-richardw.yang@linux.intel.com>
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] hw/acpi: remove unnecessary variable
 acpi_table_builtin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, laurent@vivier.eu, Wei Yang <richardw.yang@linux.intel.com>

acpi_table_builtin is now always false, it is not necessary to check it
again.

This patch just removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/acpi/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index e9b1a85e54..f9c96535d1 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -303,8 +303,6 @@ out:
     error_propagate(errp, err);
 }
 
-static bool acpi_table_builtin = false;
-
 unsigned acpi_table_len(void *current)
 {
     struct acpi_table_header *hdr = current - sizeof(hdr->_length);
@@ -320,7 +318,7 @@ void *acpi_table_hdr(void *h)
 
 uint8_t *acpi_table_first(void)
 {
-    if (acpi_table_builtin || !acpi_tables) {
+    if (!acpi_tables) {
         return NULL;
     }
     return acpi_table_hdr(acpi_tables + ACPI_TABLE_PFX_SIZE);
-- 
2.19.1
