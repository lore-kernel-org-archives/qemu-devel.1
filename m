Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B71C388F4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A485521841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urSb5JvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A485521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtX1-0002C6-Iv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSY-0002Rb-Lu
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSW-00087o-42
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrST-00086e-V1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id i1so3141963wro.4
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lMzpaWj77iIcNxSlT3zcE/i8ZeOFrgVR+n/jrGwxbAY=;
 b=urSb5JvZE57DJPDUJFtehYkhAeRWzsC5ugRfpWdJbCpXKUiC45onVBfx228WsbHhDO
 bvBSFGmy9hSvhewBlvl/zRNbtMT3NcQ5lJLdzBx4kgRhRLiLutoJnHVtPibIzPoPdwHH
 oSRqWRdALo9w1LnQ6RY1Q2UaMmKnap81mE3BYjpKNnhAM+Wkt0CMog2x0VwKVIAGtQWu
 6tDME4zoaCZF+6BMTNaufJ17ELll4fTXXfiC1dyHAALmw4MAh08WI/Qct5B5+9RYr9nb
 tcYah8/nYFhsqhZ79BneFVjUMT10t8Qn7ifQz377oRPJ9XLygH/L6vvrNB2ABjP1goCG
 Q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lMzpaWj77iIcNxSlT3zcE/i8ZeOFrgVR+n/jrGwxbAY=;
 b=lorHfcC0AmTZ4PScgXMTMNTV4WAP+J0yeXc6R2NTN0TPbpzzO2ZaRAmwx0ai0YCSjT
 AmAvUzcqCuLn1POccP4PDnqWPeDCunuEB6nlUfrVvGZkQt+XoD4OSFYVNJpgTJ9Rc9kn
 /PqDgRWWuGl8EfushhK/x+xHboFOR6d6NLwrZqkxtFUR6K0ugKiNqikeJWQtiesFIeJm
 iJJROwMe5ovFtg/uE5HBRAGYa8/tbAsMH/kSOtBXOIpFcMXN8EG01o1++wYL8DoOxlmb
 JFgIgA5na1YJulf4yGUGu6JLa6DKkV2LlAbUfnXJ3/dpB9pXxEfiMxvDYBwcxYDpHy0c
 oXvA==
X-Gm-Message-State: APjAAAWZDHDksSDXjiaqF6JFh3/zPGIsePrXJtBbkcMMEBquN5lX/Rij
 QzV+rUE1fxOAdazwX5PoP9+YvOs093swOA==
X-Google-Smtp-Source: APXvYqzWj9GInlnHDa5/cnRfNjePLHBKOUGa+f0sh5AGNzGlzROKAwW7311zTCVlv2ThFvOtyEQySA==
X-Received: by 2002:a1c:cbcc:: with SMTP id b195mr8033109wmg.80.1569595374584; 
 Fri, 27 Sep 2019 07:42:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] target/arm: handle M-profile semihosting at translate time
Date: Fri, 27 Sep 2019 15:42:43 +0100
Message-Id: <20190927144249.29999-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

From: Alex Bennée <alex.bennee@linaro.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190913151845.12582-3-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/m_helper.c  | 18 ++++++------------
 target/arm/translate.c | 11 ++++++++++-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 884d35d2b02..27cd2f3f964 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2114,19 +2114,13 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             break;
         }
         break;
+    case EXCP_SEMIHOST:
+        qemu_log_mask(CPU_LOG_INT,
+                      "...handling as semihosting call 0x%x\n",
+                      env->regs[0]);
+        env->regs[0] = do_arm_semihosting(env);
+        return;
     case EXCP_BKPT:
-        if (semihosting_enabled()) {
-            int nr;
-            nr = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env)) & 0xff;
-            if (nr == 0xab) {
-                env->regs[15] += 2;
-                qemu_log_mask(CPU_LOG_INT,
-                              "...handling as semihosting call 0x%x\n",
-                              env->regs[0]);
-                env->regs[0] = do_arm_semihosting(env);
-                return;
-            }
-        }
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
         break;
     case EXCP_IRQ:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 34bb280e3da..b5272119330 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8424,7 +8424,16 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
     if (!ENABLE_ARCH_5) {
         return false;
     }
-    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        !IS_USER(s) &&
+#endif
+        (a->imm == 0xab)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    }
     return true;
 }
 
-- 
2.20.1


