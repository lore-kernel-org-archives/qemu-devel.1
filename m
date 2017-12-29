Received: from eggs.gnu.org ([2001:4830:134:3::10]:41972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPG-0004Hd-Lm
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPF-00061f-RW
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwPF-000619-LY
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF5C780C1A
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 15:17:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 29 Dec 2017 16:16:41 +0100
Message-Id: <1514560602-280058-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] tests: acpi: add comments to
 fetch_rsdt_referenced_tables/data->tables usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin " <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index af22555..81c558e 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -257,6 +257,8 @@ static void fetch_rsdt_referenced_tables(test_data *data)
 
         addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
         fetch_table(&ssdt_table, addr);
+
+        /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
     }
 }
@@ -427,6 +429,7 @@ try_again:
     return exp_tables;
 }
 
+/* test the list of tables in @data->tables against reference tables */
 static void test_acpi_asl(test_data *data)
 {
     int i;
-- 
2.7.4
