Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC2FC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 03:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3587F21534
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 03:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="xoPhLAEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587F21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJTRE-0000Og-SD
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 23:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJTPr-0008J8-MV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:19:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJTPp-0006h5-Kb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:19:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id g29so4595427pgl.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=hjOQGgY8Q3eCsOfBzNckldz8eBMsuaAC9MCuD88EQd8=;
 b=xoPhLAEB4lJDobtdeopNYudIygmhnvJYiKMS4KCdGAE9LRbtEm0sBuLsMMldbStAeI
 10WMe6DUf4LJB2s0YxE7t/8dQbd8bTNcQEKdbTTqOGqIr4RbJu3z+ZD18pWUXSbXzyc7
 iMP2R+G8R/nYrIBwqhvhGfridH56tbD8MBLHLo38t/kTJiY3Af6zCGRth9n/PsdqMFDM
 BhZ4ZNtRBkY2nI8CWP0zWBjKXUTYzegsnHJVMJ0wwef+f5UPeuS7ISt9G6UE4XUFY3IM
 x7altBxSkE1DYONiN7N42hHWrWN5y8udUudIVClJq0S4NRj+qrNjEEd4uovlt4QcgsNo
 y8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hjOQGgY8Q3eCsOfBzNckldz8eBMsuaAC9MCuD88EQd8=;
 b=ZOj2DKqkZWEL54i9/nwuOtFwHj1JBJr/aHz7ZPb46zP/KotRLtaXeSQtPnPn0pC4ld
 77G2H/BjwQBmaGPGw7UjD8sFTdbJH5+zx2D2vjS+PO2adIepKgTjOl6YMIlUgltBINZA
 UGfCAnI11QQ5wTM4MzPGbomyDd7k4HntmN/EXKM+9paoLtc2uUO27XiZgixdJlaEqz9p
 +fVTF0cbk9foQi6MzDbUSnam04j1ew9pNOO52EJyUSYw15w6fQNknseU6KRG30gT44g/
 AMeGB9aJlBH9wscAa726TGmLL0Yw140MLGDs8BA9HvQUTAVJyvZIMr4FumFG8+mnDq+D
 7Cbg==
X-Gm-Message-State: AOAM530/qMqTVCeb6NBtIb18X8aW3qKjKvkqehOSma1ibrn9I+mTwi9f
 dfMhmBYkuOYb0t2jBlnA6SQEyI6cQqozRrAJ
X-Google-Smtp-Source: ABdhPJzDE6Z2VUC7z+Gm09eOgfJzCunsmQ11MrCdPoxSxqFEflc1mQAFm4XyqZcc8t6gC4Ep7ChwDw==
X-Received: by 2002:a62:7b55:0:b029:13e:7367:2b2e with SMTP id
 w82-20020a627b550000b029013e73672b2emr33782582pfc.7.1600485595030; 
 Fri, 18 Sep 2020 20:19:55 -0700 (PDT)
Received: from localhost.localdomain ([115.96.138.96])
 by smtp.googlemail.com with ESMTPSA id g26sm4738467pfr.105.2020.09.18.20.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 20:19:54 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Add a comment in bios-tables-test.c to clarify the reason
 behind approach
Date: Sat, 19 Sep 2020 08:49:40 +0530
Message-Id: <20200919031941.2664-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A comment blob is added in bios-tables-test.c that explains the reasoning
behind the process of updating the ACPI table blobs when new tests are added
or old tests are modified or code is committed that affect tests. The
explanation would help future contributors follow the correct process when
making code changes that affect ACPI tables.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

changelog:
v1: initial patch
v2: cosmetic - commit log reworded.

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 3f7f1a8107..e51ea26ae8 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -11,7 +11,7 @@
  */
 
 /*
- * How to add or update the tests:
+ * How to add or update the tests or commit changes that affect tables:
  * Contributor:
  * 1. add empty files for new tables, if any, under tests/data/acpi
  * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
@@ -48,6 +48,24 @@
  * - patches 2 - n: real changes, may contain multiple patches.
  * - patch n + 1: update golden master binaries and empty
  *   tests/qtest/bios-tables-test-allowed-diff.h
+ *
+ * There is a reason why the above process is followed. After every commit we
+ * make sure that the unit tests are not broken.
+ * Listing changed files in patch 1 makes sure every commit that follows which
+ * affect the tests (patches 2 - n) does not break tests.
+ * This is followed by the actual changes (test changes or code changes) that
+ * actually affect the acpi tables.
+ * Finally in patch n + 1, we update the golden master blobs as well as revert
+ * the file additions in bios-tables-test-allowed-diff.h. This makes sure that
+ * the test continues to pass because of updated table blobs while the state of
+ * bios-tables-test-allowed-diff.h is reverted back to the default empty file
+ * condition.
+ *
+ * We could have committed the table updates along with the patches. However,
+ * whereas a code change is easily reviewable and in case of conflicts, easily
+ * addressible, a binary blob is not. Hence, its better to commmit the binary
+ * blob updates as a separate independent commit. Listing the modified table
+ * files additionally helps in bisection in case things are broken.
  */
 
 #include "qemu/osdep.h"
-- 
2.17.1


