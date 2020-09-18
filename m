Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01616208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BepP9F+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01616208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDSr-0000LA-2P
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJDQ2-0006Tt-NW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:15:06 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJDPz-0002Sl-43
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:15:06 -0400
Received: by mail-pf1-x441.google.com with SMTP id d6so3139299pfn.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=gi1sTDeqggK7aQbauUzxsVt4jcAkBbywPF9Uid5mB6Q=;
 b=BepP9F+c218MWvxcOLt1ngXhci6CUERJ1jweHDaOgDtkitx6WFtmbLd3PWYT/JNjXw
 n5EEZ5gZDfiYuqjpjgrnFOLNbiRp8pKqXtuhuXSv54KaaDC+BZEWs41IFgj9ZuyFTNDW
 AV0hGHDun+nHiMOn04eGgP0R2rATcc5JSI0zFbOG5BgnW9TaOjZzpyies8/LsAwxtLIv
 zf0IlfADuXFDrzxV24Z3Xh1r97hzX6lu+rBETnNkbJ7qwyu6x0nYC+ZsyRiBfo04g5AZ
 jAlfaZhTmeWtJa9m+vS09LliTjSQ3MRqmJV6Qz8jOs2D7YAQpG0q/BwlsBzGpCHobsof
 vnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gi1sTDeqggK7aQbauUzxsVt4jcAkBbywPF9Uid5mB6Q=;
 b=tXd9leigxnLzHAkaURH/bjT2ilujSawiJ2IBtToAdPCnlh2MVm2BGcBEVyRbshLhaL
 5XyXvnCfRrMJDV1mtNUheX3seMK8ZpvyaJ7pw6uE6bKCjHNIMpmtqDEsL0bxj3B+/Mw1
 LIHXY+cN89sT3da1/Knh0ikhgd7u3ocYt3TIwjv/hikbZY8QyMu73UPtZngWkGh71Bmx
 T3ng5ke34SI/r3pSeHoWO6D/ux/Juh4UWDRq7lrw0rym6yhondjuIybma3gs+OodKd2e
 K3Li+ecv/TvtW7u+Oy+dO8J4l1dvmtB6ZBNiGvmwuJ1hCYbP3VYC4KC4gpHSxM3RwocQ
 WWSw==
X-Gm-Message-State: AOAM531Iyl/vHc8T/Sx42pvtTkwWIU5IrzsnffA74QILDc3bFtxsvLOo
 AwigBtilwbq+jfwcGeLLteAVKJK+XjBQigp3
X-Google-Smtp-Source: ABdhPJyoOWBsKkQ5Dn0jw0z+yD7FCD5i77VGpNZbcTyCeLN8MdL8umOEtu3jOmLwECXNpL0OnYC86w==
X-Received: by 2002:a62:301:0:b029:13c:1611:6587 with SMTP id
 1-20020a6203010000b029013c16116587mr31586690pfd.4.1600424101131; 
 Fri, 18 Sep 2020 03:15:01 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id i20sm2608303pgk.77.2020.09.18.03.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:15:00 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH] Add a comment in bios-tables-test.c to clarify the reason
 behind approach
Date: Fri, 18 Sep 2020 15:44:41 +0530
Message-Id: <20200918101441.16395-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x441.google.com
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

A comment blob is added in bios-tables-test.c that explains the process of
updating the ACPI table blobs when new tests are added or old tests are
modified or code is committed that affect tests. The explanation would help
future contributors follow the correct process when making code changes that
affect ACPI tables.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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


