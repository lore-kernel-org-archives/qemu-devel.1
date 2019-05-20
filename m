Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C38C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5599920862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrfJ-0002mG-E1
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:25:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR9-0007jN-Pj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR8-0008Gh-NC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:19 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:33209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrR8-0008GK-Go
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:18 -0400
Received: by mail-qk1-f174.google.com with SMTP id p18so9359847qkk.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=1u4F24iMwr4UIuWY61+gweTUoTVvnMuAMFaKH+Oei18=;
	b=eHmjOlAFCSCpADNBebamroUzzvwhlZKg68QbY00mdN7IypXwQ2VlHA5e5fYgWCzRMv
	mU5ckznnniXeSe06jBeykEUH9CkDxyZYOkQjWtg79H93psXYEsgD4En2RtcNw3kT4Tlz
	km3IFaIzbf6KEb2Is8rNbZBEJhZmTwIKF8YKoGQjyrR5WpY7EDI5ttB2Rw0fCV2KjXwB
	l0a/OMj/Wq2gsEc7haCN3SCFjqyQ3oOfmuVDXDuDGML1wtrFiHeaOGYFpTS7/2PY/zzh
	lqVewRwuC3+qB8dvF6KK96xNR32oml7P+dpjxig7dDSN1aIWtSRhsrbP2Q4NCoYHvF9y
	FcvA==
X-Gm-Message-State: APjAAAWHg3K1XcUA0QFbkis+TLU54vTiHJUlS9FXPVq6vIn6az5sZGh/
	+uOqMJ4s8fUUGbYutdoNOgTwYKuUtcQ=
X-Google-Smtp-Source: APXvYqxJ7YavNkf2oi7LXInl4NPS9GMUD23178Kh/pLMYXpR8JWkEQJsSbNIUIkvsCwDmUNuZjL8Xg==
X-Received: by 2002:a37:4bc9:: with SMTP id
	y192mr13344940qka.178.1558393877104; 
	Mon, 20 May 2019 16:11:17 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id k8sm4984944qke.16.2019.05.20.16.11.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:16 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-4-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.174
Subject: [Qemu-devel] [PULL v2 24/36] tests: acpi: make RSDT test routine
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
Message-ID: <20190520231115.HstEya0dTCo2U5dV0BbBWB06pjvPEfrexu1qap_8mAc@z>

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
index 7c5c0be379..a4f43a18ae 100644
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


