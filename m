Received: from eggs.gnu.org ([2001:4830:134:3::10]:48535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAi-0000Sm-E8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAh-00057c-M6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJAh-00057L-G7
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:27 -0500
Date: Tue, 16 Jan 2018 06:48:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-31-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 30/33] tests: acpi: add comments to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 1314ad8..b354aaa 100644
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
MST
