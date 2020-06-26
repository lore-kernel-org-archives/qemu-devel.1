Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A873B20773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikc5jYjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A873B20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqRo-0004RK-Ux
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4Y-00037z-0w
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4V-0006fL-1F
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id z13so9869972wrw.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bILgS802kOP5gR7fj6y5gd5HeqbKcxvhIhwFysJcVM8=;
 b=ikc5jYjQ856AR7oU5l2lo7qkhL6Lc7bpeAg9nDivQwnfosozM7k6Mx9I4AGgQmQ7tT
 lqYEth884Iw8y0c63t62p9OXgOESc0qXCCSRyOQ+UMPT/DAA6YopSzu/AlUuc52Fq1Ea
 ogtEol7VGp+sHAVsVejuWEDmwfrB/SvJ9jKVMd5yeLZEjweqClFoRDOaFyDWlU6RhxkD
 65zjEEtulgaTS9ivpCmeHourc3PkENWyE3mYSEqM/8PNdhgLyetIVwfn+Efp1XFRHvWl
 yLfs9PHC75+JyLtPOMDRitHptRM/0emewHXOTRtpieZl8Ay/QrR1BjVMD0rGNtygt4Wj
 3ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bILgS802kOP5gR7fj6y5gd5HeqbKcxvhIhwFysJcVM8=;
 b=NX+e3+rk2b3tjTpGg3ScXB7g8xAGDiFk5v3mmPR9+J8PG6r1aIXOnaTtu4AfwEHK2r
 K2xusyG/uMbIS/202/pnc7MifKwUHmeeGl61Rnpwz/voI5CPGssc5zlzZraSai/rWhFC
 eCWv7mSOXeIdegIzLqDvaSU81jEsOOUJw5LCK3f93jSsv88/33rpnSdV6yI91Gu1598T
 N3IawwuhZvaDdqkT1J58Us1MLb3y/kggPCmVWj+cxmpgt0oQp3ai5bdMV9HPfRNHZtUA
 YgsfSZoz8Ow8W+KwKvAOCaoHICHvDcLeqsg6xj1kCitxXaJ8J3DnEGBrkGJCxdE9oY76
 +rZw==
X-Gm-Message-State: AOAM530Y+86BmwUYWtPGfOquMyYPGNtT9pAIjfIue4Tn3YGmXeBsVej1
 SZ9f+rIM43XxakhOD3qyd6qdrZuXT5Nkkg==
X-Google-Smtp-Source: ABdhPJzOd2b6ueRduEQL9wrC4g7qII6iCD7N2FP/XeEceYc1YnnqiwZuMJQcm7ELMswGsBePDcPdOw==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr4574072wru.410.1593184517379; 
 Fri, 26 Jun 2020 08:15:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/57] target/arm: Tidy trans_LD1R_zpri
Date: Fri, 26 Jun 2020 16:14:10 +0100
Message-Id: <20200626151424.30117-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Move the variable declarations to the top of the function,
but do not create a new label before sve_access_check.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4fa521989de..a3a0b98fbc5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4883,17 +4883,19 @@ static bool trans_LD1RQ_zpri(DisasContext *s, arg_rpri_load *a)
 /* Load and broadcast element.  */
 static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    if (!sve_access_check(s)) {
-        return true;
-    }
-
     unsigned vsz = vec_full_reg_size(s);
     unsigned psz = pred_full_reg_size(s);
     unsigned esz = dtype_esz[a->dtype];
     unsigned msz = dtype_msz(a->dtype);
-    TCGLabel *over = gen_new_label();
+    TCGLabel *over;
     TCGv_i64 temp, clean_addr;
 
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    over = gen_new_label();
+
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
         /* Reduce the pred_esz_masks value simply to reduce the
-- 
2.20.1


