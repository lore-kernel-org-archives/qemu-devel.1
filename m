Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD3C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F36207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F36207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYc7X-0004U6-FE
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:02:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5P-00034A-1J
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5K-0005YV-Ke
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:38 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:43530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5K-0005W5-Ad
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:34 -0400
Received: by mail-qk1-f170.google.com with SMTP id m14so5980292qka.10
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=nFPCh5odrVBik4hdEQQECWSU7rqWJuCuSRkfsEPasz4=;
	b=ICbqLd3c0zjhVCFLa4O7ZqvWfrFDruVbyRZFi9Y8gT1OFoXl8GFLlu2+TMRZfQuE0f
	dVnVEUkr3FjznLJ2iSWiP5A3BCC/QNTIIToIT5DR3mkdsBrqrXOeUyxHEc/msM8W8cQI
	xSBkLnxyDmtbtjbEjt5o1LCyFlQG00dv9VJSmTnRocCrtLy4jREF4jDnAC+zMI0+gNVf
	VKqsZKDTTEnr0v451TRUXEbRKXmc8E3YsY9mlCuAfbZ3PcYFc9rmEwH5IFaHqEs2I+D6
	shLW0QEbUonPRxI4xW3B76r0HgmgxoOIZaBghhDUVBlGxZph3RI/9Qut/n8pjh6vGg0r
	0i5w==
X-Gm-Message-State: APjAAAX1bAAB0/Okts6Z0hifVxzaFloKkhnGfUj8O/P9TUVsYviWFF/b
	7kfM94DPpgSch5qXTOBhI51AUixnMsI=
X-Google-Smtp-Source: APXvYqzConzbxCeP9Vq6srhcvHD0HYhxkziruj5dUh18kk/RTx4jCgjFqE2HLqjQXwU1++sFnP4EDw==
X-Received: by 2002:a37:9885:: with SMTP id
	a127mr15381716qke.230.1559764832953; 
	Wed, 05 Jun 2019 13:00:32 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id 34sm8543730qtq.59.2019.06.05.13.00.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:32 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605195913.12243-11-mst@redhat.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.170
Subject: [Qemu-devel] [PULL v3 10/17] bios-tables-test: add diff allowed list
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

Expected table change is then handled like this:
1. add table to diff allowed list
2. change generating code (can be combined with 1)
3. maintainer runs a script to update expected +
   blows away allowed diff list

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |  1 +
 tests/bios-tables-test.c              | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 tests/bios-tables-test-allowed-diff.h

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
new file mode 100644
index 0000000000..dfb8523c8b
--- /dev/null
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -0,0 +1 @@
+/* List of comma-separated changed AML files to ignore */
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 11e07be093..28d7d427e0 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -342,6 +342,22 @@ try_again:
     return exp_tables;
 }
 
+static bool test_acpi_find_diff_allowed(AcpiSdtTable *sdt)
+{
+    const gchar *allowed_diff_file[] = {
+#include "bios-tables-test-allowed-diff.h"
+        NULL
+    };
+    const gchar **f;
+
+    for (f = allowed_diff_file; *f; ++f) {
+        if (!g_strcmp0(sdt->aml_file, *f)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /* test the list of tables in @data->tables against reference tables */
 static void test_acpi_asl(test_data *data)
 {
@@ -396,7 +412,8 @@ static void test_acpi_asl(test_data *data)
                             "see ASL difference.");
                     }
                 }
-          }
+            }
+            g_assert(test_acpi_find_diff_allowed(exp_sdt));
         }
         g_string_free(asl, true);
         g_string_free(exp_asl, true);
-- 
MST


