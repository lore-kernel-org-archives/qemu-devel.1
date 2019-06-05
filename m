Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEAAC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7E6206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7E6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcE6-0001ON-BV
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:09:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5h-0003KC-Qw
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5g-00065c-LK
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5g-00062r-GL
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so5969481qkj.12
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=VVEi9i7PEAHQCxMf9KerkSAmIyOSHS0sEA/Oo9jVOxg=;
	b=lon2aoYBg6m6CafxndviUSFU1Ij95G7oEcGEQ1qZHoGos9m2AmJTBujeu4h7nuciE4
	Yzdc4D4zMgAUkwzRR9wYF8Gb4LqOLP/XQzICJdI5r8LJvTallWtx03raRc31HMvzLVS4
	U3lbuPTAFTGx7WwRVFUeU/etttrNhSQ03oMH4zbKgpgYS5kHy6YrIPxFuqds3x7SPLO2
	eFThmYd/vdGnT3uJw8edjlfNqfSFnel+XdPJ/cB5nRRefmf4ydiNKXcUphXcW1oG9kU7
	NkWccFrmpqGHw9KdO5DuEmh/lA5lTiCqBIrRbS+jFKhWPiJwCk7Tav+uvZkzKFY28Wwy
	VN2g==
X-Gm-Message-State: APjAAAWNP0rh8EXMG4gQcLohGzW71nvF6ryjGlpKOaE7Zj2JUompx5z9
	KANnbA/zGlj6EtlecSDrXf+y8ZcCI8U=
X-Google-Smtp-Source: APXvYqzWTstoBrEzs1P2bXPyKyZlvhBSMRBsqyV7LFrL1qopO6xGWdHGuaLbaGXGDAk/jq8hmMp6vA==
X-Received: by 2002:a37:de06:: with SMTP id h6mr16013992qkj.322.1559764852522; 
	Wed, 05 Jun 2019 13:00:52 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	h128sm12426293qkc.27.2019.06.05.13.00.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:51 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605195913.12243-18-mst@redhat.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: [Qemu-devel] [PULL v3 17/17] bios-tables-test: ignore identical
 binaries
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
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

when binary of the tables is identical, there is no need to run iasl
to check that they are functionally equivalent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d80ea7f7f3..0ce55182f2 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -375,6 +375,20 @@ static void test_acpi_asl(test_data *data)
         sdt = &g_array_index(data->tables, AcpiSdtTable, i);
         exp_sdt = &g_array_index(exp_data.tables, AcpiSdtTable, i);
 
+        if (sdt->aml_len == exp_sdt->aml_len &&
+            !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
+            /* Identical table binaries: no need to disassemble. */
+            continue;
+        }
+
+        fprintf(stderr,
+                "acpi-test: Warning! %.4s binary file mismatch. "
+                "Actual [aml:%s], Expected [aml:%s].\n",
+                exp_sdt->aml, sdt->aml_file, exp_sdt->aml_file);
+
+        all_tables_match = all_tables_match &&
+            test_acpi_find_diff_allowed(exp_sdt);
+
         err = load_asl(data->tables, sdt);
         asl = normalize_asl(sdt->asl);
 
@@ -413,8 +427,6 @@ static void test_acpi_asl(test_data *data)
                     }
                 }
             }
-            all_tables_match = all_tables_match &&
-                test_acpi_find_diff_allowed(exp_sdt);
         }
         g_string_free(asl, true);
         g_string_free(exp_asl, true);
-- 
MST


