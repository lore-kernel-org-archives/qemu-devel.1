Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC1C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D021B20862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSreK-0001tA-2V
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRD-0007mE-DB
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRC-0008Ii-Ej
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:23 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRB-0008I9-Pk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:21 -0400
Received: by mail-qt1-f180.google.com with SMTP id a39so18398526qtk.2
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=lNTYO0MId4gzUO1w6UtHVs4DCqDNXlBKY0mc09csDo8=;
	b=j5uvziY3sT9YuRE84klb7pIx5QFslVEtrjhmqh8MH5rym2Ab3pVRSWaR4/DwW3FMra
	eR6QxCqtrgJV39UUlPM7TjPWSUailIoiL0DihMZT29ah74lEcQLIi0OShJk3itw1I60R
	Zd66+DUXNY4XmN7PQPKOzwS2QIeGY7Foz6s1pE+mjf+uSKp6ti2BFmactl8DPcYDmuqZ
	gfSQtzEw6haPQ1JBhAx2CrX2UMCWNp1RDYn6vFqNXC7tkF58qHgM8zXTddNPjOi8+PPV
	16MKwzk3N7AA7bfM3+L7uuBTurUYXO30Vj1MDs6RuWqVuuaAbVJC8cwlBnTBKJE9mscx
	FIpw==
X-Gm-Message-State: APjAAAXuEgMry5eKa6th+mcO575OEQi5RRBPCGC4XYcYP4+1tqFw84OT
	gGqbRb5vqd35ttW0a1pUN385RBly/38=
X-Google-Smtp-Source: APXvYqzUxLyXf5SRpIKnr+lSmq3PPOp522ROXuffdunxsNT35HwMFXkf67Ssf6F4EiJrwNqll3Z7Aw==
X-Received: by 2002:ac8:1c51:: with SMTP id j17mr64276477qtk.7.1558393880965; 
	Mon, 20 May 2019 16:11:20 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	t58sm10680212qtj.4.2019.05.20.16.11.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:20 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.180
Subject: [Qemu-devel] [PULL v2 26/36] tests: acpi: fetch X_DSDT if pointer
 to DSDT is 0
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
Message-ID: <20190520231119.U5dbsJzfpdRO_LU-qcwcNG2pzM5Yc7-3Qh3uc6i91ns@z>

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


