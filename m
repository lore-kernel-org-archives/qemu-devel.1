Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF9C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CE320675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDKI-0001vd-Lj
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:08:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD42-0004yY-J2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD41-0002ij-77
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD40-0002iP-VQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D5BB307D962;
	Thu,  2 May 2019 14:51:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D2F4B71C80;
	Thu,  2 May 2019 14:51:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:50 +0200
Message-Id: <1556808723-226478-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 02 May 2019 14:51:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 02/15] tests: acpi: make acpi_fetch_table()
 take size of fetched table pointer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502145150.Fnp62lpyTOU5P8IYIc05J9MN5ueCrYa_bPETttiYQdc@z>

Currently acpi_fetch_table() assumes 32 bit size of table pointer
in ACPI tables. However X_foo variants are 64 bit, prepare
acpi_fetch_table() to handle both by adding an argument
for addr_ptr pointed entry size. Follow up commits will use that
to read XSDT and X_foo entries in ACPI tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/acpi-utils.h       |  2 +-
 tests/acpi-utils.c       | 10 ++++++----
 tests/bios-tables-test.c |  8 ++++----
 tests/vmgenid-test.c     |  4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 4cd5553..92285b7 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -49,7 +49,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts);
 uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
 void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
-                      const uint8_t *addr_ptr, const char *sig,
+                      const uint8_t *addr_ptr, int addr_size, const char *sig,
                       bool verify_checksum);
 
 #endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 633d8f5..644c87b 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -91,13 +91,15 @@ void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
  *  actual one.
  */
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
-                      const uint8_t *addr_ptr, const char *sig,
+                      const uint8_t *addr_ptr, int addr_size, const char *sig,
                       bool verify_checksum)
 {
-    uint32_t addr, len;
+    uint32_t len;
+    uint64_t addr = 0;
 
-    memcpy(&addr, addr_ptr , sizeof(addr));
-    addr = le32_to_cpu(addr);
+    g_assert(addr_size == 4 || addr_size == 8);
+    memcpy(&addr, addr_ptr , addr_size);
+    addr = le64_to_cpu(addr);
     qtest_memread(qts, addr + 4, &len, 4); /* Length of ACPI table */
     *aml_len = le32_to_cpu(len);
     *aml = g_malloc0(*aml_len);
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 6a678bf..86b592c 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -114,14 +114,14 @@ static void test_acpi_rsdt_table(test_data *data)
 
     /* read RSDT table */
     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
-                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
+                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
 
     /* Load all tables and add to test list directly RSDT referenced tables */
     ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
         AcpiSdtTable ssdt_table = {};
 
         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
-                         NULL, true);
+                         4, NULL, true);
         /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
     }
@@ -139,11 +139,11 @@ static void test_acpi_fadt_table(test_data *data)
 
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
+                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
     g_array_append_val(data->tables, table);
 
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 40 /* DSDT */, "DSDT", true);
+                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
     g_array_append_val(data->tables, table);
 
     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index f400184..85d8e64 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -42,12 +42,12 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 
     acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
-                     "RSDT", true);
+                     4, "RSDT", true);
 
     ACPI_FOREACH_RSDT_ENTRY(rsdt, rsdt_len, ent, 4 /* Entry size */) {
         uint8_t *table_aml;
 
-        acpi_fetch_table(qts, &table_aml, &table_length, ent, NULL, true);
+        acpi_fetch_table(qts, &table_aml, &table_length, ent, 4, NULL, true);
         if (!memcmp(table_aml + 16 /* OEM Table ID */, "VMGENID", 7)) {
             uint32_t vgia_val;
             uint8_t *aml = &table_aml[36 /* AML byte-code start */];
-- 
2.7.4


