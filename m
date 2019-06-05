Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57A0206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57A0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcGI-0003Tn-3i
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5h-0003KB-Nu
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5g-00065K-FS
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5c-0005sQ-KF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id s57so12383578qte.8
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=rmZ1LeFhTShzPpR471gaFIMsLeMRdMAxMgQBdzVGjC4=;
	b=aeuqT5k1bBGkAbaupgqLrKypfEuPtEANQzYSzR5Ue5htli5j6HRw+v6LLyvpM+4EQM
	+rQ/tk+oV9Z9u4Cb+VqJP+eWBGmKOa/KJGXUontKiWUsH5MHzkvofNoIpUr0aU5mrM/2
	oQah6HRv0F09xu8oVPQ/zzg6NKNrEB21DLXpVykXrIhxMdBEB71BYUvWV1HTKS+5a3NE
	49z9r7Isnd1iXgcdhnQ0yiuk2vpxvbRf4hLavSBBg3I6mMVZ/WFNnO5QX6/RdkRu3wW2
	SlDIiojrhkYqum77qgv7pcQWGb6GPlnD3ZCC3f9HehM2XCFub/utv7opnReWQt3R/DNR
	xD0g==
X-Gm-Message-State: APjAAAVL2dJMVGYfgBWek5roU5oC0cxlRv4xQCyAGP5VG3sZcmQYaZce
	3JpDW1318CDqMjIzFHjHVEkroMRSzfE=
X-Google-Smtp-Source: APXvYqz+9ExSohRBgF9zCrohssidUZsuvIasDTjMVQl1v20UGskdpnm/lZQdTA3hNAfHGQKGlDR8xA==
X-Received: by 2002:a0c:96c4:: with SMTP id b4mr33545841qvd.2.1559764846136;
	Wed, 05 Jun 2019 13:00:46 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	n10sm10512259qke.72.2019.06.05.13.00.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:45 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605195913.12243-15-mst@redhat.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL v3 14/17] bios-tables-test: list all tables that
 differ
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

Fail after comparing all tables: this way
user gets the full list of tables that need
to be updated or whitelisted.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 28d7d427e0..70895e1014 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -364,7 +364,7 @@ static void test_acpi_asl(test_data *data)
     int i;
     AcpiSdtTable *sdt, *exp_sdt;
     test_data exp_data;
-    gboolean exp_err, err;
+    gboolean exp_err, err, all_tables_match = true;
 
     memset(&exp_data, 0, sizeof(exp_data));
     exp_data.tables = load_expected_aml(data);
@@ -413,11 +413,13 @@ static void test_acpi_asl(test_data *data)
                     }
                 }
             }
-            g_assert(test_acpi_find_diff_allowed(exp_sdt));
+            all_tables_match = all_tables_match &&
+                test_acpi_find_diff_allowed(exp_sdt);
         }
         g_string_free(asl, true);
         g_string_free(exp_asl, true);
     }
+    g_assert(all_tables_match);
 
     free_test_data(&exp_data);
 }
-- 
MST


