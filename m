Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D6FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9A020868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTslh-0005yu-2a
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:48:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hTsjh-00059M-Pn
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hTsjd-0006tM-UL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:46:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hTsjZ-0006By-SQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:46:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so6811949wmo.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=LVpYFJCmqbEW9mkYRBtOf1v/vQGkmLzaOzh5Rp6Ums4=;
	b=Eg4kUhwtkGnv7t+NElEU+6PReLwxJXWNcbsVQxrwzQyHnjv6h9LLwUp/IvCYcPl9gc
	eXwkCNR+gek9NxA7ubgsRFq5d03zZr1g90T7oGJr9QEHMXlpgmr9rJKMkivl8fBx6OyJ
	VySqP0ghQPpUUEXEvXIf5dFZShCshi3tiugpHGuXY4O/a7IfaAaTcqs0nxbAUKckTexh
	x9/0c8Pi8ed01UcqHn40b7mZfn3jDowEoGHL5WJQdAJD6OByVwWMAouGq4HkyiV+XPL8
	jbmKbsj8respPpAnGTtctG1tJylgMId1Bmnm62elbCOvxKoCTqsUnXAf5MOn195ZFAr3
	VFEA==
X-Gm-Message-State: APjAAAUzJFtZEmvsfP3IhYu6ZkWemYqmG+W+dSmFMzJ80h51bPAlfsef
	MrHoo6JDB4tR+JiRCKyreS/vTEx06IQ=
X-Google-Smtp-Source: APXvYqwDbep5MkgkK3Ht0OCN7SeJn3ToURVeZlSqbSGLUZVxgr4jGsH68k/WsHz5BLzd/+Btk6OAiQ==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr3080018wmc.151.1558637178491; 
	Thu, 23 May 2019 11:46:18 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id 8sm498070wmf.18.2019.05.23.11.46.16
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 23 May 2019 11:46:17 -0700 (PDT)
Date: Thu, 23 May 2019 14:46:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190523184518.22419-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] [PATCH] bios-tables-test: add diff allowed list
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

So I got tired of manual "remember to update AML files"
reminders. With this an AML diff asserts unless it's
explicitly allowed.

Comments?

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

