Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE21DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F6E25031
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F6E25031
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39009 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrT9-0005o9-R7
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:14:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOJ-00028k-Sb
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOI-0000bE-VH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:03 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrOI-0000ZS-QR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:02 -0400
Received: by mail-qt1-f180.google.com with SMTP id d23so10559714qto.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=nFPCh5odrVBik4hdEQQECWSU7rqWJuCuSRkfsEPasz4=;
	b=XAzmUh72aWHIncCfTGBzHHYw1t16ouCGgTy2/c+okU79g4XFIe5Kq1sc2QE5ycE3e4
	HvBC8tZaWwPjE3cxcWlri8ujxdtIU6i+i/ugRS3ZNqYYvbohj6ne65TuHU+ocFBQEue3
	sG88+xzzVIgWVHFOJMuA0uCS/2kkOBHA7iG6fAsledt/jumPfXt8UViByKNIS2qxHytk
	UfqBaWajouDtK2aPK1QG/u1tVbjZE8UMMrzBy5YQ/i0VPimKaVdP8iYUEcQL2gLUXp1V
	HLb5HyKjtokQ9WIKkYV8qkAOR36gfj1CIPSpeCDesPtdKpJ26qzC60bjJJgbhaRpJivi
	bXfQ==
X-Gm-Message-State: APjAAAWO5K6NzEqZ5KfAys42AW0dL/xDIEvpKE6oFD3RFXBCaC+O2QZZ
	cbFnmPEZfjpnzpEZoxcBjx1UhCLVpWA=
X-Google-Smtp-Source: APXvYqwRmO+x2nCotBw/7ahD/bMe+7WoedCMOXqZbXFL9D+qYKWT1FfqGnf6ZO8k58sMT9aj8xi4JQ==
X-Received: by 2002:ac8:6b95:: with SMTP id z21mr23547373qts.337.1559585341770;
	Mon, 03 Jun 2019 11:09:01 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	g124sm8099744qkf.55.2019.06.03.11.09.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:09:01 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190603180807.16140-11-mst@redhat.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.180
Subject: [Qemu-devel] [PULL v2 10/14] bios-tables-test: add diff allowed list
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


