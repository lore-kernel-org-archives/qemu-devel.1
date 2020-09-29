Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D08C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C0D20739
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="MVvCcs0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C0D20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGai-0002V6-7u
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNGZB-00012g-Pn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:25:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNGZ9-00083h-Q5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:25:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id u24so4026874pgi.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=tw2BSAHxMyMXfXN20HZnVu2RCSj4CLVnFIN2vj4VPxI=;
 b=MVvCcs0dbTqCGedBriVQZxjd3D5OzbJxF10BuziepSaUP7z5PyUaF+d9kYv+J0hjSb
 8sRta3s0OTqzORs/jj4ln/Yj8wvDUHXdrMrMqdtjAy3ZMSnQYK5hRkvHgDxFA2+WeA+7
 p5lQlst8gYWArLBUOW9IYSRk8h1aO/+Gj/mRxfk42vrTiC7KFAv50KNBz6nRX/hXh92f
 EuNljg4CESSrhBXkdANgYAMrUKK85BuWl8UiGRn/39k0a1dtIt35pJYEwzTzh3IXSjPV
 vQpMVbEVrGTa6qdBclz8zXj2/bygQynOYvq/wvajnE/yywfucvQvXv+M+9JKwbApoOv1
 maqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tw2BSAHxMyMXfXN20HZnVu2RCSj4CLVnFIN2vj4VPxI=;
 b=cd7Vy2xn489uJoWABvOXO1E1dMB5xRm77JzbVlJ56H4DpgwfStbRerFzzp2toJlnxy
 HM5Vlhrz4T1CIQrg71G+Th7Dtmhu2075sgJgg7zicJBa4CAoG/TUtpB2StzFS5EDP7pN
 cXnOaOxgplfqV15CV7wWn7bUG+abfeXr08gJi6TK9YlNH/HDNj1oGs4ZqF+kAeaUJr3V
 YH5OouxOTGnURAxpKuIh4ni8A4eEaOfxRQQZj94RASWEKSKLGlPbJKX9hUMwEDCVu5Eu
 jM6Y/6ds6rfuiMPwvby/OH9ZewXDTMnlbrr5OCZzBuWGlxnsAlgnL0aBtjrfP001zmeX
 j24Q==
X-Gm-Message-State: AOAM533xnbk+ertZL327kunUShm3o6115RL7XMr72BqOvTE4Sd0eGXdI
 jH8KBNIQOU31vThvyq0EcDNfxA==
X-Google-Smtp-Source: ABdhPJzikRuSNwFbS0XwHFw0G/0mjABCkLh29n8eDin2iJpJHDYOhOPMat1Zw4mcPkeI7f3Y2Yvfkw==
X-Received: by 2002:aa7:8001:0:b029:142:2501:34e6 with SMTP id
 j1-20020aa780010000b0290142250134e6mr4355467pfi.63.1601389513985; 
 Tue, 29 Sep 2020 07:25:13 -0700 (PDT)
Received: from localhost.localdomain ([115.96.125.11])
 by smtp.googlemail.com with ESMTPSA id g1sm5631796pfm.124.2020.09.29.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 07:25:12 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v5] Add a comment in bios-tables-test.c to clarify the reason
 behind approach
Date: Tue, 29 Sep 2020 19:55:01 +0530
Message-Id: <20200929142501.1057-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::543;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x543.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A comment is added in bios-tables-test.c that explains the reasoning
behind the process of updating the ACPI table blobs when new tests are added
or old tests are modified or code is committed that affect tests. The
explanation would help future contributors follow the correct process when
making code changes that affect ACPI tables.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

changelog:
v5: incorporated suggestion from eric.
v4: more updates as per Igor's suggestion. Dropped some comment lines. added
    ack'd by line.
v3: review feedback incorporared and actual comment in the code reworded.
v2: cosmetic - commit log reworded.

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 3c09b844f9..fc7aaaf82c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -11,7 +11,7 @@
  */
 
 /*
- * How to add or update the tests:
+ * How to add or update the tests or commit changes that affect ACPI tables:
  * Contributor:
  * 1. add empty files for new tables, if any, under tests/data/acpi
  * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
@@ -38,6 +38,11 @@
  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
  * 6. Now commit any changes to the expected binary, include diff from step 4
  *    in commit log.
+ *    Expected binary updates needs to be a separate patch from the code that
+ *    introduces changes to ACPI tables. It lets the maintainer drop
+ *    and regenerate binary updates in case of merge conflicts. Further, a code
+ *    change is easily reviewable but a binary blob is not (without doing a
+ *    disassembly).
  * 7. Before sending patches to the list (Contributor)
  *    or before doing a pull request (Maintainer), make sure
  *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
-- 
2.17.1


