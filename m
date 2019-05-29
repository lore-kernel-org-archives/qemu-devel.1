Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1DC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B62423DF5
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B62423DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57853 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1e8-0003kY-EU
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:41:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1Zn-0008MT-1g
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1Zm-0002dN-3H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:19 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1Zl-0002Z5-Ux
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:18 -0400
Received: by mail-qk1-f174.google.com with SMTP id i125so1887380qkd.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=2N2pAhqKNOpMLotRyAnbXdQzQBiSsjdCIL7uekUQ9aM=;
	b=U6Eah2Bd98dCSijMaYBOvuPFlG19KPJeDfX6zZtyngxCpiweHagclJkAGUYRZ3RjLb
	HHLpjknKR4kPPQk260lGVXHzcnejUZCUaaWhgaygC/7GdDIrFe5dI3B00/hwq/0bYO6o
	2ad4oovm/gP/zYLt1ZUUBgVV0fCICuOvxkiPTRGVXLi7/9BPTjl9bQn0cGrDhRcBUsic
	5L3LphcEGEBFNf0XJKFYfHBomN+owNtxJJut9ELEeIjwVC9eZTAdoDaimy2kO4xNTBid
	cf0xnTtZ4RJ3CBYiWL6Rw9YULTONCalRXQsz/Or5jGN2zRG3ZHeZDRg1LTxbXo55XOoT
	ZGuw==
X-Gm-Message-State: APjAAAWEra0YiTjdFxo/IYQgcHNHNd56yQA0f5tPki0gpT3hm0LcMuQC
	LbGYJ22Qe7BvFc694IWyukeCS/ezNMs=
X-Google-Smtp-Source: APXvYqyjJ8uSqcy5nwlNB10ptl+jDaYFa80IbyHoDxfQedhbXTRveUxrYMXX4/j7MDQWI0IdvSYNTA==
X-Received: by 2002:a37:4d41:: with SMTP id a62mr44765790qkb.99.1559147831683; 
	Wed, 29 May 2019 09:37:11 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	c16sm6879495qkb.15.2019.05.29.09.37.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:10 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190529163604.18560-2-mst@redhat.com>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.174
Subject: [Qemu-devel] [PULL 01/10] bios-tables-test: add diff allowed list
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

Expected table change is then handled like this:
1. add table to diff allowed list
2. change generating code (can be combined with 1)
3. maintainer runs a script to update expected +
   blows away allowed diff list

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |  1 +
 tests/bios-tables-test.c              | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 tests/bios-tables-test-allowed-diff.h

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
new file mode 100644
index 0000000000..dfb8523c8b
--- /dev/null
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -0,0 +1 @@
+/* List of comma-separated changed AML files to ignore */
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 11e07be093..93db1a7265 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -342,6 +342,23 @@ try_again:
     return exp_tables;
 }
 
+static bool test_acpi_find_diff_allowed(AcpiSdtTable *sdt)
+{
+    const gchar *allowed_diff_file[] = {
+#include "bios-tables-test-allowed-diff.h"
+        NULL
+    };
+    int offset = strlen(data_dir) + 1;
+    const gchar **f;
+
+    for (f = allowed_diff_file; *f; ++f) {
+        if (!g_strcmp0(sdt->aml_file + offset, *f)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /* test the list of tables in @data->tables against reference tables */
 static void test_acpi_asl(test_data *data)
 {
@@ -396,7 +413,8 @@ static void test_acpi_asl(test_data *data)
                             "see ASL difference.");
                     }
                 }
-          }
+            }
+            g_assert(test_acpi_find_diff_allowed(sdt));
         }
         g_string_free(asl, true);
         g_string_free(exp_asl, true);
-- 
MST


