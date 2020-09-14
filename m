Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F29C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755D820E65
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODfQcLEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755D820E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqcq-0004zV-Eg
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8L-0002e4-Ud
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8K-0007an-3d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id m6so18931469wrn.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZD6keKSXkMPE+jVkaNX44x7EafwuotxjEIF6brG60A4=;
 b=ODfQcLEIwCGzcPoy/GJuSoaVGoCOepNX7usHCaNqkM1QqJIObdI0cntvuB5M8IqUY6
 tZZpUaeAjeRehCJfwQU6NeFMzcrUHf8LCtGfqhIyQBnHZI76MNH0kJBVS5LWIWxzKujK
 2YP68k4RYJ9J5lCJkWXqHYeFex6rGgszUYh9qrXIUxetF2mi2o7HuwdfYPMgJ6MOUy1z
 BwTnwSPQcO/g9pK+p6LNSwWeCMizqRalG+0inH+1rIxhKHCZyBBqH8dM6Hb4Qw0Z4pqQ
 oX1kgXOM/runwrwFrMnHlUNMbxSK/YB85QUHpktWZS4dvSxrEtI8g5a9XfmVsSNCRL5h
 MjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZD6keKSXkMPE+jVkaNX44x7EafwuotxjEIF6brG60A4=;
 b=cYEv6ngm2FmHg+mm53I53aqcQU13Qd4Uba/niwObm+qF30sGximhybyCI88nvv3mVK
 h1EIerZrOfZNL7D5d/1BOiLnMGspH+RXY/MU+q78/RwuzdgBAaauDSnHikXFyoOPPmoR
 Put3m5uvK6SLqowU9eF9c6c8+OWeKAtAUS2KO2RoLdgx1PGvLYY32jVifSSATnH9rP19
 tjp2rqqhF7DniAdpzNHUACvb7vwE5YpPGQULqtKiP1e1zvV+EEVoXK6tHNXXLsbR451v
 TQvi8NKUAfs+kHkruIBvgh8IRB33HleUma/FHJ0PjnAQi7Zh68Jcay2V3uOmiw3/xJ33
 nW1w==
X-Gm-Message-State: AOAM531CmrBbyIl3AEHwd+A+aTKrimBjtKdqluaMX2xPuh1NLVwe0zQK
 SQ8hKo7OZqhRkygzyZOGoNkiz8nlRzS3Y1De
X-Google-Smtp-Source: ABdhPJyjagOEF5lmMOTMiKxg7GiIiCFwVtFQzXZhSvI5OoQuxBKKxWtTt43jYrJea5HFgMHaUJG4ZQ==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr16681854wrn.334.1600092422602; 
 Mon, 14 Sep 2020 07:07:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] target/arm: Count PMU events when MDCR.SPME is set
Date: Mon, 14 Sep 2020 15:06:22 +0100
Message-Id: <20200914140641.21369-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Lindsay <aaron@os.amperecomputing.com>

This check was backwards when introduced in commit
033614c47de78409ad3fb39bb7bd1483b71c6789:

    target/arm: Filter cycle counter based on PMCCFILTR_EL0

Cc: qemu-stable@nongnu.org
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44d666627a8..88bd9dd35da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1452,7 +1452,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
         }
     } else {
         prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
-           (env->cp15.mdcr_el3 & MDCR_SPME);
+           !(env->cp15.mdcr_el3 & MDCR_SPME);
     }
 
     if (prohibited && counter == 31) {
-- 
2.20.1


