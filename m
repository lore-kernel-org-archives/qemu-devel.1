Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4D9C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B008F21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B008F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrxk-00019X-Qh
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:45:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRE-0007nK-JM
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRD-0008JU-Og
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRD-0008JO-Ku
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so18319260qtk.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=RTRIxsVKqqdz/HWRVEdKM6QUXrcO4t5UGM0Rdb91dxE=;
	b=jyu+FkF7i05I8Vu46anedF9on3MUFNm7oWG4BVzKORcEq3IiSl43MnkayT9Ru4KGxK
	2ameI2w2qZyFQcaDE4Sgr6KPV8vvlnW5y6PiqW+BiNsstKHFazvYgiNHMZg24MYkpzue
	a/E0YY9mrBOJ40Koz7bj0BEktkEv/7yAeExb+FE6Luw1vLb1RQv4Ci4VltaDBX0iX3WE
	UjYgcO9nTF9q23H1hB9URYhp8AGSqLwt+Yn54zS0pRkrAz3GoVAJ4h2aEKLtzucpMGa8
	2IBWXUEUEpNg02TQogwJbOajvrPs5ekGNmu3vcCwvMUU0O9PBX2N5VHcYfGuyyB2HC3S
	/6mA==
X-Gm-Message-State: APjAAAXWmNfC5hQ60LHaVixib9CfqtRLzQ/lKcQswJrAqttZ7XGBzSK8
	t9X4kUCEHc53t0HExWPCGquh9vDj1Rs=
X-Google-Smtp-Source: APXvYqyPW3rvgR0EDfQOLmJ26yF4BMuEdOZmnKHL4DStmURZIzO1J3b5kJh20iF9OICPghykgGaeqQ==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr62251227qvf.132.1558393882954; 
	Mon, 20 May 2019 16:11:22 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	t187sm1528417qkh.10.2019.05.20.16.11.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:22 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-7-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PULL v2 27/36] tests: acpi: skip FACS table if board
 uses hw reduced ACPI profile
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
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231121.8RDRw8W72NiZuu7R-lW5KDvnBVtvZ7oX5yARBUENK8c@z>

From: Igor Mammedov <imammedo@redhat.com>

If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
FACS as it's not provided by the board.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <1556808723-226478-7-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d165a1bd62..e2fc34143d 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -147,9 +147,13 @@ static void test_acpi_fadt_table(test_data *data)
     g_assert(compare_signature(&table, "FACP"));
 
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
-    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
-    g_array_append_val(data->tables, table);
+    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
+    val = le32_to_cpu(val);
+    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
+        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
+                         fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
+        g_array_append_val(data->tables, table);
+    }
 
     memcpy(&val, fadt_aml + dsdt_offset, 4);
     val = le32_to_cpu(val);
-- 
MST


