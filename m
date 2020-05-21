Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC73DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902EE207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htMRgp5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902EE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqlA-0003q8-NT
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg8-0002Iz-Ru
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg7-0000RD-Ti
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id g14so2850245wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dFEQXmjjsTDYYVSak8Tb1Vcj0+3VcW2hSollOB67zz4=;
 b=htMRgp5kApo/ZQnPb29RD+Tgk/QPKgoMxNImuX76++tnvxPWQFW6FMlJpjzqMXkACH
 yaXfzvthFsqLqUP//LPfEw0i3hgl+7TaieYILDQ6h0ec34jhya/pPwi6FQPxmES6ZPGl
 ukfwYKZA7ESgAR5HXVjDLrvwXQyfd5OiWrc37ltvGpvEZ/5+uLnYrLEmB/+jTq1YwKQ7
 8k4li8GJ70IqKJlMhtWfquK7XXJQMztLrahRIgEhPqikCyTISLueanRLbvdimgHjqH8L
 +Jyn54xszWr6L+qDs592QULr8xGLsXUK1XO023UC9AWxbF0sCGnjgagqEEjTBdxFY3kv
 uazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dFEQXmjjsTDYYVSak8Tb1Vcj0+3VcW2hSollOB67zz4=;
 b=lQ2xV9GmnL9zCnY4b5GQMcWQpIh7vhVoY+rv9/E/lKvAAdcBz4VUcorC39HqPo+mZJ
 13b5UvyxyNwoMdkCLi5XHiSxNjjEKXbHV8XsVvlWqqgkX9QZJfjqjLEwDxCi4B0XzjEj
 ncATLLrvYazN32FBJItVnuQnPgyTP9NxrcgcXZG9r60pz3rYXgorV98RnoswQLnqIYfi
 +AHU5lYCrNcGIp9DqWzqojcc6LbD/wMIV05BDwj/bkUiFD5ruXzr4L0UY75M5R2Dlinn
 hHQtoLZmOrYVas2Lt1o1iL9bgFYky9G0MoGVCkafWmUgYl9zvKOaxgHWMnu+ljbw/ME3
 yy0w==
X-Gm-Message-State: AOAM5303rCosd7ZTaGvLyRo7/dM5bOCwo3mecf3n4H+usM4UPps9DKtB
 MoeUF7uUOfFF0Gqw9Z34D+xhqHLHTKuHRw==
X-Google-Smtp-Source: ABdhPJwRtSc60DXVgTaWXDjiaVVh1BS+XSFaYNtSx15karoYrsTfPFmemrAG2iX3j7gwCbWd4ZtRtQ==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr9785168wml.75.1590088586237; 
 Thu, 21 May 2020 12:16:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] target/arm: Remove unused GEN_NEON_INTEGER_OP macro
Date: Thu, 21 May 2020 20:15:52 +0100
Message-Id: <20200521191610.10941-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GEN_NEON_INTEGER_OP macro is no longer used; remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4c9bb8b5ac0..c8296116d4b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3034,29 +3034,6 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
     default: return 1; \
     }} while (0)
 
-#define GEN_NEON_INTEGER_OP(name) do { \
-    switch ((size << 1) | u) { \
-    case 0: \
-        gen_helper_neon_##name##_s8(tmp, tmp, tmp2); \
-        break; \
-    case 1: \
-        gen_helper_neon_##name##_u8(tmp, tmp, tmp2); \
-        break; \
-    case 2: \
-        gen_helper_neon_##name##_s16(tmp, tmp, tmp2); \
-        break; \
-    case 3: \
-        gen_helper_neon_##name##_u16(tmp, tmp, tmp2); \
-        break; \
-    case 4: \
-        gen_helper_neon_##name##_s32(tmp, tmp, tmp2); \
-        break; \
-    case 5: \
-        gen_helper_neon_##name##_u32(tmp, tmp, tmp2); \
-        break; \
-    default: return 1; \
-    }} while (0)
-
 static TCGv_i32 neon_load_scratch(int scratch)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-- 
2.20.1


