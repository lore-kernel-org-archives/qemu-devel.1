Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AAFC43467
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C3121D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtnAcR53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C3121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLu5-00086A-VP
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHj-0000lh-O1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:43072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHc-0007CI-5x
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id e4so3423262pln.10
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IXCdiBhItEWZqfoFfbOxAWF3meHLpHpXy0aUL/QPPJ0=;
 b=mtnAcR53HrNNLZ9zKYsef5jKHSgoJrdoP3h7zFcyQY5Yu6/YTShJNPA4RwjEpwd7+t
 Sb6q5YJZn233wU+I6l0ZIxoGCUqPn6nMpBF0EO/Y+nhznEV9AOAKlkAooXzycpt49Pk+
 aUposYWh8h9M/OOsMvg40wcWn80oq+WRY8LTNoGLhDgFXnWpp5r6KtyK/AIENNxgpbuf
 mqYL55eaCVVs3Z1pAiQb5H4YUIWOPdPWrTBCX/6ZwzyS4tEslAH/bGv7+fkG0w9nknM1
 ByJMmC0Kr6ZCeHKaSzc4iTUrAMLqReHJsJLgc0AcmN5wrTK78rGJqpRTkcPHM9N0Whjb
 NBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IXCdiBhItEWZqfoFfbOxAWF3meHLpHpXy0aUL/QPPJ0=;
 b=gH/3ReIzq0jlZnRoYYVf5/7tYFHjUlL6w6dIALm0qvgb66glVV6aETftQpCxed/Cv+
 jPaMPlu7C2lB5SUxCBm1tq6hF4ZjKlMoJjG7YPzyjmgDBfJ3oid1+MDseBhwhdB7Mr62
 irlmsvy5PHD13FQ+lzud1smeZ8VhvqifDwsZjX3oCeZMfAwJoHPBGRRam+tu969Ox9Qb
 AWsCZYBg7KAFYt27f/fbw1yNmhvLBG5WQnBYy2k+IT7rYGDfNHRsF4lFP9yYR7nIxJ8n
 skdi6R8zYdOHws8/n3GveqD0QiQb1+87tJfyOrqi1VmZz0v89HynSyZix8i98oB4Ig7D
 buVg==
X-Gm-Message-State: AOAM53207J7N9pjo/x2DtVn5A7c592xn7zp1bykPdEiostkKHLnR4BP+
 1Aq/BEH54fnxl2NLJ7iPdRKBUF5eJ/ZJeA==
X-Google-Smtp-Source: ABdhPJxfx1lONS1Zy81r0gasNea8sVDvC5CKyvgROEHhA2QQb/pCs3elNnwBOu3DI2ooL2EiHCsPiA==
X-Received: by 2002:a17:90a:1548:: with SMTP id
 y8mr14154247pja.113.1600454334501; 
 Fri, 18 Sep 2020 11:38:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 47/81] target/arm: Implement SVE2 scatter store insns
Date: Fri, 18 Sep 2020 11:37:17 -0700
Message-Id: <20200918183751.2787647-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Add decoding logic for SVE2 64-bit/32-bit scatter non-temporal
store insns.

64-bit
* STNT1B (vector plus scalar)
* STNT1H (vector plus scalar)
* STNT1W (vector plus scalar)
* STNT1D (vector plus scalar)

32-bit
* STNT1B (vector plus scalar)
* STNT1H (vector plus scalar)
* STNT1W (vector plus scalar)

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200422141553.8037-1-steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 10 ++++++++++
 target/arm/translate-sve.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a375ce31f1..dc784dcabe 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1388,3 +1388,13 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 Memory Store Group
+
+# SVE2 64-bit scatter non-temporal store (vector plus scalar)
+STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
+                @rprr_scatter_store xs=2 esz=3 scale=0
+
+# SVE2 32-bit scatter non-temporal store (vector plus scalar)
+STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=2 scale=0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0d0e0c3b46..af8feff707 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6172,6 +6172,14 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
     return true;
 }
 
+static bool trans_STNT1_zprz(DisasContext *s, arg_ST1_zprz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return trans_ST1_zprz(s, a);
+}
+
 /*
  * Prefetches
  */
-- 
2.25.1


