Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC71F20672
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="S4vkU7oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC71F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfFx-0003YH-M2
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKfEt-00030V-SK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:09:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKfEs-0003Q5-7m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:09:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id k8so11997276pfk.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=c24pFn9TuOtHvIccTwrvpvAxyZ0ejqYC9CUKyj/sVGI=;
 b=S4vkU7oUJ3WAFIVBGOJzwyw0AfofWsOagx9Uq3cGT/Vf7MQ8p5bgSiKHH+qSW/Fc4+
 bcoJrmWjOgrDs2CpeW2jPSy8Z3CRpfMlltzlmp6GuoLYj3FNO+WalhCrGyAOJZ8/9Y/I
 N4OiYJeS5qoBMmb5l3GGHSVXrY06qpqh3Yf3ED7J6Mahzz7BGzcuoOlKmsYerb/n8ALR
 VFP9sCXSx+xpeeMcJl6D9m1DVQHO3cMjMyfMQbxHSZEPGdySyFoXT5jS1NpFQqVN9TeC
 0SUi/v0dzPb6ksDFODNDowdcEsdiiOebNQ/ldrYYsbNUI4+7+nJrn1ItNBrKkdnTbIO5
 Cf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=c24pFn9TuOtHvIccTwrvpvAxyZ0ejqYC9CUKyj/sVGI=;
 b=ner5GWmlZ+mzsyc0dmaBbxyjLvYB1dEQ9o/BELX2i8BY56V37IrXj+jUM2ws55B2db
 yWobM6f4yEsbIqSr2igPb6aD5huSGlTM/ASQBw5CIyWpHEZhc8+Ff270ncUALTl83wxj
 XC0YB6ar76c7gjrZ6IsThqjGRwrqkjK3IwcVLZqy/76QRIw54gCxpbh0PUNbqrRLwRFz
 CYfPyxAMYYtxfUl1qj+Rra9amAOJPd843C4bzIq4VCJGnRGLV3BWjDiCsddfhkvxqbG/
 6bPDdHLfSe1gDcfsmB+/5CNT9bsz8efEYxZ8PSKHe4lajWyv2Pbqb6EOwf6JkaXtumxo
 IKFw==
X-Gm-Message-State: AOAM530HyPJkVERwmix2YD7uTms+WxY+qIOOQAvWkiH7omheyyQ/pJDl
 MKUuDAeN03OYamM/ZmHPXx3GktM4FrbeUqos
X-Google-Smtp-Source: ABdhPJy7NhN2Alu82J72QkbQ/BRfP6bPC0SVERL6XGGsWRnIZLoERVRq8gHqOwViaXtZcKejhrWIyg==
X-Received: by 2002:a17:902:b404:b029:d2:43a9:9f5c with SMTP id
 x4-20020a170902b404b02900d243a99f5cmr1008259plr.38.1600769371679; 
 Tue, 22 Sep 2020 03:09:31 -0700 (PDT)
Received: from localhost.localdomain ([115.96.140.229])
 by smtp.googlemail.com with ESMTPSA id
 y195sm14897186pfc.137.2020.09.22.03.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:09:30 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] Add a comment in bios-tables-test.c to clarify the reason
 behind approach
Date: Tue, 22 Sep 2020 15:39:18 +0530
Message-Id: <20200922100918.4200-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
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
 tests/qtest/bios-tables-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Changelog:
v2: cosmetic - commit log reworded.
v3: review feedback incorporared and actual comment in the code reworded.

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index b514b70b62..1e8838c8c6 100644
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
@@ -38,6 +38,17 @@
  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
  * 6. Now commit any changes to the expected binary, include diff from step 4
  *    in commit log.
+ *    The reason why we follow the above process is described below:
+ *    After every commit we make sure that the unit tests are not broken. To do
+ *    that, we could have committed the table updates along with the patches.
+ *    However, expected binary updates needs to be a separate patch from the
+ *    code that introduces changes to ACPI tables. It lets maintainer to drop
+ *    and regenerate binary updates in case of merge conflicts. Further, a code
+ *    change is easily reviewable but a binary blob is not (without doing a
+ *    diassemly). Listing the modified table files additionally helps in
+ *    bisection in case things are broken.
+ *    Hence, we have a multi-step process and at each step unit tests continue
+ *    to pass.
  * 7. Before sending patches to the list (Contributor)
  *    or before doing a pull request (Maintainer), make sure
  *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
-- 
2.17.1


