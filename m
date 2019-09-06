Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD50BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E3D2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvmVbsQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E3D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Djq-0004SL-HJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Ddv-0007L6-Rx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Ddu-0005qK-0i
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Ddt-0005pD-Q8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:47:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id r195so6971719wme.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lQHwlLQPM95FwA1k9cP7PvNCmUDAHDGdetoNJrdT6Zg=;
 b=HvmVbsQab/LsjzrZHNJFr68DD6DUnSTxwE4r+Te+uvljXTzPJKTNFFm9XkMkp4UHG6
 sag5M8b46rs+a+MCYUsqYf/s2KrYSEgkMsiszHTBDRAZLmNx1pIR9ROiVvhUZXbFgUX8
 9MPOJVGg1hqVbKakc6Z/TqwQSYQUXohGRx/q4BZxj4ZwjCIlvEGoT107rol1lXEdopht
 QwW0Vz7BGytqJS5EAzrOLqw3Hu8XJu5Bck9AAgkIIIfWzlNzSz9J7Qr/Z8cOnKm7Was3
 ANI41uGkPmrk1i2qaofnidvE/ZXe09MmXKguyFNKDCEQMdpLTk4eu9jP8bVIQcNsYCx2
 bBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lQHwlLQPM95FwA1k9cP7PvNCmUDAHDGdetoNJrdT6Zg=;
 b=isLu0PIG2c8Up9ks4tXSKi4ZYvkvST9JZvY1/NvYspTW2DIPH1ALOF24vNyGF8e+Rr
 GJ3jIStojrSrmd0MNMvZ9HzqDWUDZ20lsWwgGcDRzY6ZxN4n/Qw5S1YSqZT8DTN83kNE
 5HHJy6hfzte3vB8XSJ5npF77iDssKwHth6GnG6VjSLW8/lA31be/5m5G8etMy5CJk4gO
 jISNRKHB2L8+DXqHyG7dT/bdJ8wTsoIUDY8gn8hmHFyAYNYSAo8xqFJOIqAkEA6AXlns
 j9Qv/Kd+eYajTJm9OuK+kDUI3O228p/Po93lb3uIPH2B3dvef2juRb8UdH8IVN0gCOv7
 +sdw==
X-Gm-Message-State: APjAAAVYREQHNQLmu5CvK1KiLhmbMBIBCyJ7dEmZnIm7ysEuB4ooaCKI
 McGJ1YZ6cBBkeBme1PSE8uXhXg==
X-Google-Smtp-Source: APXvYqyXECHB1h3UhGDptTDjWM0EkBfNgLq/V5EG3t5jNckpNkEhLC5kbcgcBCgrmJ0eoBxN+pU14A==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr7284697wme.29.1567774028710; 
 Fri, 06 Sep 2019 05:47:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r17sm5990270wrt.68.2019.09.06.05.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 05:47:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C31DC1FF8C;
 Fri,  6 Sep 2019 13:47:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 13:47:03 +0100
Message-Id: <20190906124706.19145-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906124706.19145-1-alex.bennee@linaro.org>
References: <20190906124706.19145-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PATCH v3 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
v3
  - update for decode tree
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
index 34bb280e3da..4cda7812bcb 100644
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
+        s->current_el != 0 &&
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


