Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5AFC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC2720833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC2720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFux-0005nY-S5
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:55:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNB-0001Va-IF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFN8-0002fn-HX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:33 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:41513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFN6-0002eN-Pm
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:30 -0400
Received: by mail-qt1-f178.google.com with SMTP id y22so3543412qtn.8
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=uWaDRe7+LF+zrJ+Tf/oQtPH1jlenE8wNIJt9AIDqefY=;
	b=HdaiTfynb3TYh0fI8fDtSGTFFoZMUTgzRv1ykgc6FcIxycyUB2w8CFaLe1oDcEIb41
	4j3kmdC8S5UrwmTmdn3MnCT+byAvJUCtM1s7yo05fPhHgFu1JZI6qeprNCM/3hnEPZyD
	22Gq0zfZgPeI6OMPYFcIOdCkWxA8OhPr7LXlmA9La/xjiOEJ3gs+qI3CzhC2duDKkbFz
	9/GYXVDInjX4cGRSYFQBiyfis7WeF8KfEX41NL07ICL+1lUEy0XNQzeKav0Irkp7rkml
	o/rZrRlUZfIzCb/C3mvKGMM24DhdQQTalc4fF5lnb9BuS+j6b6GtAuzrgE9VMoVgijFm
	fm3A==
X-Gm-Message-State: APjAAAXaz7tBLzE0eZ7mEVuydx5LaiUMiUch23PNSw1X/PSjLch1HAa8
	yUOYCdDYrgdhikBxDrEKWrk8yLjp+pg=
X-Google-Smtp-Source: APXvYqz9TV2609jZpPXpHjoiTDdJhSvz2BMDW+Mgnjc/UCokD755IXObKMhfdlgc9IpgUo6o+ouhzw==
X-Received: by 2002:ac8:1671:: with SMTP id x46mr18972263qtk.240.1558009227932;
	Thu, 16 May 2019 05:20:27 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id v3sm4229465qtc.97.2019.05.16.05.20.26
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:27 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-4-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.178
Subject: [Qemu-devel] [PULL 25/37] tests: acpi: make RSDT test routine
 handle XSDT
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
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122024.R_tm97YG_riFG2z5bdPMVHIKjcSjia0-yI-Y-Bu5vMw@z>

From: Igor Mammedov <imammedo@redhat.com>

If RSDP revision is more than 0 fetch table pointed by XSDT
and fallback to legacy RSDT table otherwise.

While at it drop unused acpi_get_xsdt_address().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1556808723-226478-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       |  1 -
 tests/acpi-utils.c       | 12 ------------
 tests/bios-tables-test.c | 20 ++++++++++++++------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 92285b75b3..f55ccf9ff7 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,7 +46,6 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
 void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, int addr_size, const char *sig,
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 644c87b5f9..a0d49c4371 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,18 +51,6 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
 
-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
-{
-    uint64_t xsdt_physical_address;
-    uint8_t revision = rsdp_table[15 /* Revision offset */];
-
-    /* We must have revision 2 if we're looking for an XSDT pointer */
-    g_assert(revision == 2);
-
-    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
-    return le64_to_cpu(xsdt_physical_address);
-}
-
 void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
 {
     uint8_t revision;
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 86b592c67f..d6ab1218da 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -107,21 +107,29 @@ static void test_acpi_rsdp_table(test_data *data)
     }
 }
 
-static void test_acpi_rsdt_table(test_data *data)
+static void test_acpi_rxsdt_table(test_data *data)
 {
+    const char *sig = "RSDT";
     AcpiSdtTable rsdt = {};
+    int entry_size = 4;
+    int addr_off = 16 /* RsdtAddress */;
     uint8_t *ent;
 
-    /* read RSDT table */
+    if (data->rsdp_table[15 /* Revision offset */] != 0) {
+        addr_off = 24 /* XsdtAddress */;
+        entry_size = 8;
+        sig = "XSDT";
+    }
+    /* read [RX]SDT table */
     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
-                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
+                     &data->rsdp_table[addr_off], entry_size, sig, true);
 
     /* Load all tables and add to test list directly RSDT referenced tables */
-    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
+    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
         AcpiSdtTable ssdt_table = {};
 
         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
-                         4, NULL, true);
+                         entry_size, NULL, true);
         /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
     }
@@ -521,7 +529,7 @@ static void test_acpi_one(const char *params, test_data *data)
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
-    test_acpi_rsdt_table(data);
+    test_acpi_rxsdt_table(data);
     test_acpi_fadt_table(data);
 
     if (iasl) {
-- 
MST


