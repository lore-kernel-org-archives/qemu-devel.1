Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF81C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DF320848
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DF320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrbF-0004bF-GO
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:22:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOT-0002Ga-Hz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOS-0000xU-LJ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrOS-0000wU-Ga
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so1038275qkd.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=rmZ1LeFhTShzPpR471gaFIMsLeMRdMAxMgQBdzVGjC4=;
	b=JHEpkM1NOfcedVcIC4cpoqonJbaaPnQoBUKZQlbYeDPdCk6KvbB9HD8jjSaeV9S1DE
	MRU8ph91WkggvRzArkT+TQVeDtt5EnhIYmRl6lF9ccxJzEhktIHcLdCYJIX0fjAr238v
	sGj/2/mlhPYvgPRPnSJE6dYWQco2arP6ooQWtUZFh/k8SspUUY0iIW5ySJ+4KyLsM7wY
	MXefxHUImyCwnuSecrAZ0JpwmUkl7IjBxgPnJBXVdv1YbQtVSWemM4AHWJfKhDjy/1m6
	B2Qo2iMRxyXBo9sch4Tg4d1nsB5MvL6GB4wMW3hcOMfPGkDvVW2zZTwpalXVMIMljk6U
	g3yA==
X-Gm-Message-State: APjAAAXvJRXSJLautZ/pSxQo3Px/F+eSCDr1DSUWxiCgm01225oWyiPg
	pjGbBL4jCaQVvKXYK3poZmxoCptzNsE=
X-Google-Smtp-Source: APXvYqxQGRP8NlD8tUES55AM7xEUL5WLQMWmy7M5SAALZkLzEPKSGcgGg5Ck9Xrak+ZytGa/nhWPnA==
X-Received: by 2002:a05:620a:16a6:: with SMTP id
	s6mr23641419qkj.39.1559585351662; 
	Mon, 03 Jun 2019 11:09:11 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id f9sm9690047qkb.97.2019.06.03.11.09.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:09:10 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:09:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190603180807.16140-15-mst@redhat.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PULL v2 14/14] bios-tables-test: list all tables that
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
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
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


