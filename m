Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626492072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmOMn8K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626492072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIFP-0004Ok-K6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyu-0005Dr-Go
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:12 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyt-0003hd-QA
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id y18so202368plr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DWHyTpGlKBuharmhIu7/0HNfc6hnYtHUc2NhnIgEMGo=;
 b=mmOMn8K6m384XUfdOljdjRtVgurc7mmaDh4q5305ZT+DX+9zE7CHgUDWhfxAgu1War
 oqTa5to9WH5JJAEL4i/7kpkHMLj6SDRxZcBpkyvBkQb3gUGRrVMD0my4Amkit+/nthO+
 cqnOTIty9NPcoVZsoYNhBEUdMqwy9ccjOA0GfxYW3+0XY6aZXWd0WI57uBEwfbebLQ9y
 4DaUwiu77oIk32TL+3LhYo4lubrGSMZ401oIg3gS+I3IncQ3HNkE0XnfEtq8sa86cY/e
 QAcnwujJCpxFOvYgg3LAKHzLc60+JVyRdkBGztARLLQiRb5qS8YKQSdOZjcORVxwVa9y
 Sldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DWHyTpGlKBuharmhIu7/0HNfc6hnYtHUc2NhnIgEMGo=;
 b=JozGNN9lAL8dwqvTya1Qnj5tbNM+8dSLmr2bZejZyKMDuxJQxnNV1hfJATQHxBWEtO
 VZO9NBoaEdbTtVxdxwTXK3GXDcxL5+7oJs4kaVBLbqhTHhY5PfRYB3NrUIZ4tjyQhG3v
 j/QwgqySZqAiLBoso7sVKo4ElBvP+8RX5yq2/NR0cDb4d2k3XB7su3UCO2QusjaiqOAU
 FMdIuUZadBY0FDPQ2tscPKDLJvUTx2gNxj74/GWjC4Mwfay5mp6IViZhLpjv4pAmTSIG
 pyxm0He1UsIXrX8qx0wCSZWw7DjmbAzVC4kx6LZtJm8CZpiymEXVBJfIUkExJkDZQX1X
 d4mg==
X-Gm-Message-State: AOAM532U0ePJ5VGdxsnmjt1VmDBnBtZXCi7n5DT5ewaTih1WuvoSuhZQ
 sgKM5tOckoY+ySu96plBy8dnMv5L+YA=
X-Google-Smtp-Source: ABdhPJyPPg3L9peo2OjUm0bp7zdJa1mdYObMtF/1QIr7uwb86yyLze80mNH5yEBkY5dSLypFG678dw==
X-Received: by 2002:a17:902:6541:: with SMTP id
 d1mr25523754pln.96.1591146850191; 
 Tue, 02 Jun 2020 18:14:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 39/42] target/arm: Enable MTE
Date: Tue,  2 Jun 2020 18:13:14 -0700
Message-Id: <20200603011317.473934-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Delay user-only cpu reset bits to the user-only patch set.
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868f..e4bce55c5f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -655,6 +655,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.25.1


