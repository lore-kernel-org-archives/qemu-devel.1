Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528AC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF9220848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF9220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFQj-0004Cq-FP
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFN6-0001Qg-K5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFN2-0002bh-MK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:28 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:35563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFN2-0002Yi-Ix
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:24 -0400
Received: by mail-qt1-f172.google.com with SMTP id a39so3603048qtk.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=piaSkE/ERpKJsns5vKzok4OQ23eDDJrDOYnvMlbXyMI=;
	b=HIXOa7D30CI8f1NGHEkgvz6kHjp1VxtRmxXnceEYA7unxj1ISh823+RPrfFMQbShz4
	+bSM5Jq1kWtB2l7d6t6pbRh747exzEmlRlEY3Iq5R78rLPUOdIt8VV0S4uEO+JwJPRhE
	uB0UqYPDSzZ8cHL3RrvwfGxesMsFcJ+7ARaLyOUCPSVc5YjNOKAbjiqIRRQONvahuu5Q
	tTYzUgsvmJzyoq1IynSh75V853tmT8HgiuNHy3fkwROVGJgL59yrzTX81WnUSRwLba4b
	hGbbmdA1cBSWXdPZHiy6cjET1GOC75K/uJAz1pPjTYARjtUhx7pMzAPNj8EimakredXv
	lHUA==
X-Gm-Message-State: APjAAAWZqCwzVMgb9oQ27FaSpFJZQcHXUj1fGlpAnKv0xkCXNFsIE1R9
	6Fql6ovUDOISwUmqEJIkZeg/ZKOOo7A=
X-Google-Smtp-Source: APXvYqzLXahNxpGB4WU/DpbfRZqLNQ/XmsBe8jDH4EYs4XYNm3gFr/lskx/B+r2V9UQ4gfOCkHdUUA==
X-Received: by 2002:ac8:3973:: with SMTP id t48mr41464733qtb.121.1558009219161;
	Thu, 16 May 2019 05:20:19 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id z8sm3073740qth.62.2019.05.16.05.20.17
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:18 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PULL 23/37] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
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
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122015.7MQ4JsZdw4DpjrlfDHY369OemDt3XOPcufYqqd5jJI8@z>

From: Igor Mammedov <imammedo@redhat.com>

so name would reflect what the function does

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       | 2 +-
 tests/acpi-utils.c       | 2 +-
 tests/bios-tables-test.c | 2 +-
 tests/vmgenid-test.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index ef388bbf12..4cd5553586 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -47,7 +47,7 @@ typedef struct {
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
 uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
+void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, const char *sig,
                       bool verify_checksum);
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index cc33b460ab..633d8f513d 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -63,7 +63,7 @@ uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
     return le64_to_cpu(xsdt_physical_address);
 }
 
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
+void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
 {
     uint8_t revision;
 
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a506dcbb29..6a678bf761 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
     uint8_t *rsdp_table = data->rsdp_table, revision;
     uint32_t addr = data->rsdp_addr;
 
-    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
+    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
     revision = rsdp_table[15 /* Revision offset */];
 
     switch (revision) {
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index ae38ee5ac0..f400184268 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
 
 
-    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
+    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
                      "RSDT", true);
 
-- 
MST


