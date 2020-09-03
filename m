Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2271C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32DA20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdB+hwvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32DA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxG3-00041G-Rc
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyq-0007SS-0S
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:37687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyk-0004aR-Mi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id 5so3168704pgl.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i/w3vLxBt1qJ2wyxNzwes/y8JNN7aVfo7El89r/8IyU=;
 b=UdB+hwvBO6ZXYI+WyJfXs3Phu0UmliMM2CgveUz+rDwCB0XIR9eqUcZUEsGOxnpUvQ
 uO4YlKCu4hsgKYi9VU5JrMGC27Sn8Pf7z9VFk0qIdtPjt0eV2d5RUg7u/28kNyleiTvC
 oei1M1aItA9efdHYzTEH+1elqvCFJZ+NPaRo2zHo34O4qdf5CdHL709qZPXPOTIIcWL7
 m740O/IYHRt6twaiDdFDSId0DkV6neMGonZ4wopAND3z54gdRGksRVPvwFEf0tnG+d1P
 97PHBGnSN2hLDXmq1BlXfFglx7lqzhjDtBkWKNUgOCSJ99Rt/TIMpHRnflENzNIxWer+
 0j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i/w3vLxBt1qJ2wyxNzwes/y8JNN7aVfo7El89r/8IyU=;
 b=ehS81iHw19jP2tTfvFRRTsusvK4BrzDC0vaW7eTIRb/8kSGdoGtOUGp37gqqArg0da
 jVgiIwY2rByG3JCBHJVlFDLtZI96yb7KU4yCqEmaASo7rcq55hVDkwucpmNygDQw/Ge3
 Cn4sfbrxORbVyUE7/40NvE6vw1Cf5d41NdI1t3+QrSn2zxdrv/3z3EOtW3f0zTGdl54W
 MJC339WTMeGZ3qHT7kOYvxg594BXxdGX+2apl3wwM1YAtYBh81ovPBGU329ro0bNEyQR
 QGwLAQ8Hmx5esB2dN2MPwH5xAfQvXABBAsDwuFZ9OoTP6MDlyZ3FslM0T4LgCUfAPZnu
 eY3w==
X-Gm-Message-State: AOAM532/GMNkI6qVWbqIq8kdDDJuWcN0ovPanBm10NFn3KLC7pH54o+Q
 6d5tHiZFT4MQHUYXy14xgwpIxcdGUgidGw==
X-Google-Smtp-Source: ABdhPJzpDs85C8C5dbARtJC9d6cItil7QPyxDZKuknDePotcH9b5TBDsu2tByHOrRPW7zb8/MYJnlw==
X-Received: by 2002:a62:1743:: with SMTP id 64mr5648427pfx.133.1599169269075; 
 Thu, 03 Sep 2020 14:41:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] tcg: Eliminate one store for in-place 128-bit dup_mem
Date: Thu,  3 Sep 2020 14:41:00 -0700
Message-Id: <20200903214101.1746878-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not store back to the exact memory from which we just loaded.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 793d4ba64c..fcc25b04e6 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1581,7 +1581,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V128);
 
             tcg_gen_ld_vec(in, cpu_env, aofs);
-            for (i = 0; i < oprsz; i += 16) {
+            for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_vec(in, cpu_env, dofs + i);
             }
             tcg_temp_free_vec(in);
@@ -1591,7 +1591,7 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
 
             tcg_gen_ld_i64(in0, cpu_env, aofs);
             tcg_gen_ld_i64(in1, cpu_env, aofs + 8);
-            for (i = 0; i < oprsz; i += 16) {
+            for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_i64(in0, cpu_env, dofs + i);
                 tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);
             }
-- 
2.25.1


