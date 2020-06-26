Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B2A20702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyf4cnla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B2A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofXK-0005Gn-KL
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 00:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6Z-0001Ik-EG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6X-000270-Mv
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id g67so3463878pgc.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JXq//EY41qOxgUUn2iV4AqQzVXGmUlIHXAR8u9hZfo0=;
 b=Cyf4cnla5cVLfmql57rJS+R6jzHdzsAy1Im54V6l+MCvraieqKliZWagn1CPTzu48I
 tx+FUloVSn5h5DFvJDxB4OLweVGUCzdGvjHHH+sGbrZG3GElF2ptEbo8+X5f6IPeCzeK
 ewTIFpVxazQaHb7zQ0AbWFf4MXfkKTXRI/G6duOct6qKEJ/+HFxLzLo22/oStkM0SC5o
 7jul4WYcwNCXZWtOgVIaWQhngnKNGQzJmPkCwGMCSxT6FZsM07Tfl9zIP4wq7lHXwSG7
 LWpk/lA/2WMpOMGWjT+lgQ/GlCrgDNkDaxdaKhy6x1sU5DY6UFZUb4FcjhbAZgbSlU+w
 vcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JXq//EY41qOxgUUn2iV4AqQzVXGmUlIHXAR8u9hZfo0=;
 b=LnuS6pAzerCD3wzvKJAxYz1tZWZ+/P/HSbOmE1FMro+6WxqcKJj8nK04vf8Ewuk56y
 EbVpif3Zn/3e/f/VbhEshAGRqQAb3ROxG2HKgNt0aOzvYAoFFoFcsPHNQRs6I4vqz1ZH
 0TOVrn3dngY+pbKcwfMdnOVt7FdeaNx1GAUgCj4NrdEhCkYsNVt5S2wk3nywtbj/ZJE0
 HUJgIWS8GftXC1IqykfkUEphix5DhbFL57voEgkX2MijJbZdY2Z2JWpypnzlxTtI2KIb
 tfJOjCUG93PAl/Ivw8PafSo0T3Yzh5let/RWy2fHycxx0pTnF1KGygHysJ1869tuc8gc
 DkMA==
X-Gm-Message-State: AOAM530aQe0b9RYX7JKvzHt/y92kdiG+5gbfYyPC1OnrDWwLsy/n5eSb
 uoBp2zZGIWG3muIFwn/mn0Am5GeJAEE=
X-Google-Smtp-Source: ABdhPJzEpxWQi13SrVIyOaDmQll50JaGCQ4zINPl8x9Ovn9rlOg9nuThrRdIbDQDGbxs2R3qSZZzlw==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr901141pgn.127.1593142360083; 
 Thu, 25 Jun 2020 20:32:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 40/46] target/arm: Set PSTATE.TCO on exception entry
Date: Thu, 25 Jun 2020 20:31:38 -0700
Message-Id: <20200626033144.790098-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 23cf44fcf4..d220612a20 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9704,6 +9704,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
             break;
         }
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_mode |= PSTATE_TCO;
+    }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
-- 
2.25.1


