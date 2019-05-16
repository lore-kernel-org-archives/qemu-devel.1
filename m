Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35371C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE24920833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE24920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFsB-0003CP-7k
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFN8-0001SM-Gv
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFN4-0002d8-M5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:30 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFN4-0002c4-IV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:26 -0400
Received: by mail-qt1-f182.google.com with SMTP id m32so3617464qtf.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=iPvvkfZxQATlPIEpp1afMv/TD5HHoCU3dbBXU5r4pdU=;
	b=dfXo/oxj2CjM5OLTLv42ux8YXcCycSbPkWUobD7vxdwSLkr2Cj6OoGXP4GU1shKkSy
	cd0YFL82glHZYXMebeJT06Y4HGY27FCHRK8Sfh9wIEY6g62XNXu/uKT/jYSboHl4bRVa
	R2Pa3KDXdpigMnp2wwt9zY1bE5U0TxKxUncy3JDActWMA/85SfH0FUjaUuuoeCNwOeWv
	W0uuHqq9Y1J+h0fRpBUipbwKEYj/xyA3FdA9CFKqjmfwqo4MVtBNB8NQM6aqLEp2yjfj
	cIc58bEo2+YHxo+Z+cdyleymb19RKTis5+XN7g5n7UWXY66vWLvUHWCHbfjA2HHJWUHO
	P5yQ==
X-Gm-Message-State: APjAAAUSF4QLVFHHooNrCbBK/BGzdlutoI3RdLttujpW3+363TdQPhYA
	SqIcOwYq+dQxFW18Rbg2zbcla5zdRTw=
X-Google-Smtp-Source: APXvYqxWdE6hXZhIx3SJI13b7HZJ8WUtrytJQ+gInVMlF59PKeVqyDa+CaS1aMAmFD980hIbS5yCYQ==
X-Received: by 2002:a0c:bf08:: with SMTP id m8mr40098245qvi.214.1558009224603; 
	Thu, 16 May 2019 05:20:24 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	196sm2331001qkh.94.2019.05.16.05.20.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:23 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-3-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.182
Subject: [Qemu-devel] [PULL 24/37] tests: acpi: make acpi_fetch_table() take
 size of fetched table pointer
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Ben Warren <ben@skyportsystems.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122020.A6HMax-oxQi0820DSeLxIOCwTPRuqnXzfDEh750D9w4@z>

From: Igor Mammedov <imammedo@redhat.com>

Currently acpi_fetch_table() assumes 32 bit size of table pointer
in ACPI tables. However X_foo variants are 64 bit, prepare
acpi_fetch_table() to handle both by adding an argument
for addr_ptr pointed entry size. Follow up commits will use that
to read XSDT and X_foo entries in ACPI tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1556808723-226478-3-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       |  2 +-
 tests/acpi-utils.c       | 10 ++++++----
 tests/bios-tables-test.c |  8 ++++----
 tests/vmgenid-test.c     |  4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 4cd5553586..92285b75b3 100644
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
index 633d8f513d..644c87b5f9 100644
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
index 6a678bf761..86b592c67f 100644
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
index f400184268..85d8e6463e 100644
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
MST


