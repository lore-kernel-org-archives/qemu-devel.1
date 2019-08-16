Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CEC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B392133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zA1uALVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B392133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycBG-0000C6-7z
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6v-0003Rr-8E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6u-0005a1-4Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6t-0005Yc-Uu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id m125so4047090wmm.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KlCSG2yQBk84HQMtc2AZ6n1YsIT4tj03PHTJtQ4LM54=;
 b=zA1uALVpF5JXlWkh6Fd6AB4nk/AuIU4k1hQqXPj4NXtWTUVmut1yLUoyPSGIzudXyf
 3iBwZdpM3gM61ywWvCRSpEhtVUVbpwcQcUhNfwb19bxmhUXLXOIjQ5T98eR8UIpqpsg1
 koNlfNjv7Lu8HojR9PTB3p4og4byMbQGzD0jyPVYyOOshRkAbjeFoJKFf0fBcu+JPjQN
 cMcHm0xePW5oAk/MjUEtWsfWamevymu5XmCGofiglUe1TjehZclWofqBjnoQ+Y5YzRsm
 PoOsxjsJgUUNznsrTwTPBMyfWzU/SyY7p3VI0SmpQVvuLpjGWGAY6D0P4RHrUeASXlW4
 qbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KlCSG2yQBk84HQMtc2AZ6n1YsIT4tj03PHTJtQ4LM54=;
 b=Ks12M3BI8axFampZeqyElj8yk9zR0BjqUCFJyXHDQqTf37oS/mejYiUzNCD2OKOo1O
 qZohp4eL2fSMT0AMGqwFTRD7q52OrFXZ3S0zNLIF2cdFHQsvReLKMH4tlmRjjSgHvhe4
 xW1GKctUA7OXF0Y8UpHGfI6uCuNS9zHjksG+xN66Er2tdQ7iuCXVIeno60JApQM8EoS3
 R+xU3oT19HO8kH3smWjDOOh+mQA6alKSAxojSdxS6hq64dvZnICSNJ1CPS3JIgmM+DAE
 McnWhFDrUsgQuw/sj7agR0qlDkIm27uT2oq18SkzwU/DVOSLQrGrR3P4weOa60H5f0uc
 vYkw==
X-Gm-Message-State: APjAAAV0c58AxbO9uZNrBiqsU9dQs2+1w1we8sHlvsQHctsTkZEuYDX+
 3NJJwM3jCjA/auOBhK+kLJBjhYzH8dPUQg==
X-Google-Smtp-Source: APXvYqwYpja+sK5Ty1gYsV9skjhvqJzdoUbXKOI/VlbIwFZBXKIFWh6HH4hzYWqZdgLHR6SrBFR3uQ==
X-Received: by 2002:a05:600c:2245:: with SMTP id
 a5mr7462261wmm.121.1565961458786; 
 Fri, 16 Aug 2019 06:17:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:06 +0100
Message-Id: <20190816131719.28244-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 16/29] target/arm: Remove helper_double_saturate
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

Replace x = double_saturate(y) with x = add_saturate(y, y).
There is no need for a separate more specialized helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h    |  1 -
 target/arm/op_helper.c | 15 ---------------
 target/arm/translate.c |  4 ++--
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e8..1fb2cb5a777 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -6,7 +6,6 @@ DEF_HELPER_3(add_saturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_saturate, i32, env, i32, i32)
 DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
-DEF_HELPER_2(double_saturate, i32, env, s32)
 DEF_HELPER_FLAGS_2(sdiv, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(udiv, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 5e1625a1c8a..0fd4bd02385 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -135,21 +135,6 @@ uint32_t HELPER(sub_saturate)(CPUARMState *env, uint32_t a, uint32_t b)
     return res;
 }
 
-uint32_t HELPER(double_saturate)(CPUARMState *env, int32_t val)
-{
-    uint32_t res;
-    if (val >= 0x40000000) {
-        res = ~SIGNBIT;
-        env->QF = 1;
-    } else if (val <= (int32_t)0xc0000000) {
-        res = SIGNBIT;
-        env->QF = 1;
-    } else {
-        res = val << 1;
-    }
-    return res;
-}
-
 uint32_t HELPER(add_usaturate)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cc7d37b787e..34e65cd80c0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8107,7 +8107,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             tmp = load_reg(s, rm);
             tmp2 = load_reg(s, rn);
             if (op1 & 2)
-                gen_helper_double_saturate(tmp2, cpu_env, tmp2);
+                gen_helper_add_saturate(tmp2, cpu_env, tmp2, tmp2);
             if (op1 & 1)
                 gen_helper_sub_saturate(tmp, cpu_env, tmp, tmp2);
             else
@@ -9950,7 +9950,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tmp = load_reg(s, rn);
                 tmp2 = load_reg(s, rm);
                 if (op & 1)
-                    gen_helper_double_saturate(tmp, cpu_env, tmp);
+                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp);
                 if (op & 2)
                     gen_helper_sub_saturate(tmp, cpu_env, tmp2, tmp);
                 else
-- 
2.20.1


