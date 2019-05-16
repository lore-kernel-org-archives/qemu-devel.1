Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7ACC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8125D20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8125D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFTO-0006vz-P9
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:26:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNH-0001YN-2Q
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNE-0002jI-1X
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:39 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFND-0002iy-V8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:35 -0400
Received: by mail-qt1-f179.google.com with SMTP id f24so3517244qtk.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=lNTYO0MId4gzUO1w6UtHVs4DCqDNXlBKY0mc09csDo8=;
	b=nniG5hUvSznMei+aALFod497O1VvrJhXcnzsJTfiIWTQv59I5rBiOy9pKKs0tpfCU7
	YkBiiTlsJKYlQXdvwscqWidTAYWho3ScqYiYmzmeE6/JLhtc6g0yJLedzyrgo6OTcAtI
	fMN9/LDjszV84pkTsNLkl1btX3PDWZMTj9cFUcjBsMA9xnCw2J25Z9K4Gi+FduBGPW/2
	hj7IQAbr1G5pg+LRKZZeldlIQI2/W6yUKmliDa/9PEe44uKw+uYwAErtHLLOrrzt2035
	ke9glEH/tEounUhDiP3k+92ryGfeFHR2wKn5CYl/hOgl9bNySNJrwZGe/qIruxrbX31J
	NsPg==
X-Gm-Message-State: APjAAAWyz0mUDt8BWIpRSbzWComPo0/oOivZik2jwJZRBZfWT+tHmJZ/
	YNBvgCTXbqyKILLU3CKX0pZhu08UYLM=
X-Google-Smtp-Source: APXvYqz2LXsEZK4YjfZjvVhkDO8rWKfQ5mOr+YQMTpYObNQoik/w3nyvEsAG4v/WCV1By0WLt72PLQ==
X-Received: by 2002:a0c:872c:: with SMTP id 41mr39897703qvh.213.1558009235122; 
	Thu, 16 May 2019 05:20:35 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	a64sm2587930qkd.73.2019.05.16.05.20.33
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:34 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.179
Subject: [Qemu-devel] [PULL 27/37] tests: acpi: fetch X_DSDT if pointer to
 DSDT is 0
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
Message-ID: <20190516122032.y_bwZlpjrzj7xc9tvnIibT6a6Eob_Rcg2aAIPfy6xDw@z>

From: Igor Mammedov <imammedo@redhat.com>

that way it would be possible to test a DSDT pointed by
64bit X_DSDT field in FADT.

PS:
it will allow to enable testing arm/virt board, which sets
only newer X_DSDT field.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a164d274a2..d165a1bd62 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
     uint8_t *fadt_aml = table.aml;
     uint32_t fadt_len = table.aml_len;
+    uint32_t val;
+    int dsdt_offset = 40 /* DSDT */;
+    int dsdt_entry_size = 4;
 
     g_assert(compare_signature(&table, "FACP"));
 
@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
     g_array_append_val(data->tables, table);
 
+    memcpy(&val, fadt_aml + dsdt_offset, 4);
+    val = le32_to_cpu(val);
+    if (!val) {
+        dsdt_offset = 140 /* X_DSDT */;
+        dsdt_entry_size = 8;
+    }
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
+                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", true);
     g_array_append_val(data->tables, table);
 
     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
-- 
MST


