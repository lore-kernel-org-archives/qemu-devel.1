Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF6C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D01207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pccG7V48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D01207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfZb-0001WC-Qs
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF9-0001Yu-7n
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF5-0005Gb-BL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:38 -0400
Received: by mail-pl1-x643.google.com with SMTP id c15so532914plq.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=92AClQgNXABacQ0i61DaYrNKkj8PxXy6qywPLdGfziI=;
 b=pccG7V48C0x492Kay47azRqIVgRz8denyqaSNW+KUi0iJvNCZ7dJ0BbGfaYg9AZnIu
 TFfm/r3weBiX/m+/RpKyiFO4tR6iFWJPuWnOapbJe0bRFK+1oN0+G7BnocLNMT8mSNw2
 ae3BEKNaD9pXfB99MyCzx25XeEaacFjkgfVowg/1tH2s2LOwH4DAliSQ1k/BULfJ/FSm
 gq2m/GCMNksGbv7Q9G1L4f5y80YAyeUM4YEVer47kv1l0Nx882/06fctjNtRQJiEV/Tw
 mWY9V/oXrBB7Vv8vThbSB0JGOKM+7wfssZPCqvUxC6+YEG8mXIbP3QpphGEqOiZ7NFPY
 Lx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=92AClQgNXABacQ0i61DaYrNKkj8PxXy6qywPLdGfziI=;
 b=tU8UvPB5uhiDLZpwNZhWZApnXeXKghgop3pvzFjtsWND4zYNCr3FgSPPpbm2IIST3A
 Av4WKde94cnyr4MmXSJ+CD2Qr+tTIkfoYhh33YzGpRtAGDaZZV4JGhGsz6L2Jj2zXLS+
 3B6uc2syEfzKX0aRmJuAlFytI0kkX4zbCAAHctLLd4N6ARJsyXHcImVxfRVfa0IyqdYN
 x4zGSsr/y5icOWB/Bv3MbJVnuYTYpNSOotDORZWqBqOLQlXce6GaxACgXor6oQY6ON9S
 85y0o/F7tMtLs2ffPqmBhKVsZOPjWxT4aVUZ1Pvc6hxzBnUyHgJDYp0jxvmk/ZKYoJi9
 Qryw==
X-Gm-Message-State: AOAM531jHwlieiieA01upkGwQ5UOr7dcmX/rvWJBXDhVGEwwS+d/t5xX
 Y3XL4c+MUagk3WFOR2GwPxy7dcYPhyNaFw==
X-Google-Smtp-Source: ABdhPJwqZ0c9VjCQksHKwb2nQAyEGzRg9Yj7ymv4jtr/RNMHAoWhy1z9atcbcwM0Yq9+SkNotWg3qw==
X-Received: by 2002:a17:90b:e8a:: with SMTP id
 fv10mr368947pjb.72.1598624433543; 
 Fri, 28 Aug 2020 07:20:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/76] target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
Date: Fri, 28 Aug 2020 07:19:02 -0700
Message-Id: <20200828141929.77854-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that FSR is no longer a tcg global temp, we can say that
the fpu helpers do not write to tcg temps.  All temps are
read implicitly by the fpu exception path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 79e1e8ecc7..64816c89e1 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -3,21 +3,21 @@ DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-DEF_HELPER_3(fadd, i32, env, i32, i32)
-DEF_HELPER_3(frsub, i32, env, i32, i32)
-DEF_HELPER_3(fmul, i32, env, i32, i32)
-DEF_HELPER_3(fdiv, i32, env, i32, i32)
-DEF_HELPER_2(flt, i32, env, i32)
-DEF_HELPER_2(fint, i32, env, i32)
-DEF_HELPER_2(fsqrt, i32, env, i32)
+DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
 
-DEF_HELPER_3(fcmp_un, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_lt, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_eq, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_le, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_gt, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_ne, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_ge, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_eq, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_le, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_gt, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-- 
2.25.1


