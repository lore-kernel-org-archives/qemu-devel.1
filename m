Received: from eggs.gnu.org ([2001:4830:134:3::10]:59525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsC-0002Xl-GS
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsB-0001ro-M8
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:40 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIsB-0001rN-Gf
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:39 -0500
Received: by mail-pf0-x235.google.com with SMTP id e4so16279791pfg.1
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:39 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:11:59 -0800
Message-Id: <91b9bb30a86d2b303bab813f7f5ad361810c3149.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 04/10] ACPI: Add vmgenid storage entries to
 the build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This allows them to be centrally initialized and destroyed

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/aml-build.c         | 2 ++
 include/hw/acpi/aml-build.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 03b6c6c..0f39eaf 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1594,6 +1594,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
     tables->rsdp = g_array_new(false, true /* clear */, 1);
     tables->table_data = g_array_new(false, true /* clear */, 1);
     tables->tcpalog = g_array_new(false, true /* clear */, 1);
+    tables->vmgenid = g_array_new(false, true /* clear */, 1);
     tables->linker = bios_linker_loader_init();
 }
 
@@ -1603,6 +1604,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->rsdp, true);
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
+    g_array_free(tables->vmgenid, mfre);
 }
 
 /* Build rsdt table */
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index dbf63cf..6f4e239 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -210,6 +210,7 @@ struct AcpiBuildTables {
     GArray *table_data;
     GArray *rsdp;
     GArray *tcpalog;
+    GArray *vmgenid;
     BIOSLinker *linker;
 } AcpiBuildTables;
 
-- 
2.7.4
