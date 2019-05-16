Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D3C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDB420815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDB420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54103 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFdu-0007zM-0E
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:37:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNM-0001dW-Dm
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNJ-0002mq-Ct
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNJ-0002mY-9w
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so3618442qtf.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=RTRIxsVKqqdz/HWRVEdKM6QUXrcO4t5UGM0Rdb91dxE=;
	b=DwcQ9hwemOVQ6EiNDi/UHImVwAZqfmF5IGZAmnXFHOubcIwjavLGCyOrB230PbdoLE
	5HfS1CNG3sqBkNuPkgfR2xu8AH6PBD2slVNr762fdPuNVpiuFmhBX4fu7eeLbjAb6hZE
	vLKAQykL6HyF1lSKKpuUuj4LBvFgDR3vWOWRnqMYZlY4AxtKRIyYGuTt7mWUQ/3+4Mn0
	Bu1WHhihXop6TXKxy68RQQ4oPERz5GnpoYzuDBO7Qn024g2Z+FkrkEDi2r5Bil3CT0+f
	va7gu5CsKanvY0s2HlbJM0VXuqO2rUJzy9e4D7v7jIVFIU4n4GrDPtp1eaKW3HhAhgXt
	8vcQ==
X-Gm-Message-State: APjAAAWb/sHIyq6XxoKlGRxgeYiohdj6aExTPFwsutggpBU6mpuv8+n8
	jV+YHwIGpZG/3q4rHF7yyFnZmNk0kRs=
X-Google-Smtp-Source: APXvYqwQeqEj7MLEu9Ulm6/kIEb3bFUMDWBZSbWMTCnBKZ9X9iBAXOuSDLQqhOXSkzeAe/CZWONXwQ==
X-Received: by 2002:ac8:2fa8:: with SMTP id l37mr41089622qta.52.1558009240527; 
	Thu, 16 May 2019 05:20:40 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id t2sm2402127qkm.11.2019.05.16.05.20.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:39 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-7-git-send-email-imammedo@redhat.com>
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
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PULL 28/37] tests: acpi: skip FACS table if board
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
Message-ID: <20190516122035.aMzMZ-eHviHXjzNqYoczQZWzmVIlnox7izMfVgIrQzU@z>

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


