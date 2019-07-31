Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8CC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB77A208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sb3fmYCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrAp-0004LK-5N
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8O-000220-8R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8N-0000bn-7a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8M-0000aZ-UE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so70383564wrs.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BaXv1gxEuljYaje+hDfDXRtILG3ZeT8f0aD36Klyo9c=;
 b=sb3fmYCXvcBIFBymPMWalTLUOpAbWOteQclHXy7FnJExFFrkzOYQoguvAH1lD3QR0J
 dN1ZmK35Ulc/ANwNfl3kthVlisVySXVZi6p/L/od1lwC6YM0W46r05zO7Bcg+Obd+CWe
 AP5vTp8qBYYxTTzIZ76GagnLi210R1oONKmCmzBJwrOuAyVQ+iaUqsBfc88fV8Ne5pHQ
 TgfWH0yP+/wmQiTpZJUqw8F3pVr45HU51cPBkq3Yym/OzCKf4SgksoRQMYAVxctmUKBN
 9MYY4ui9Qk8kng03WsIyQ6rsvIfG/kDJNE5A+tQvU7V/VeMCR/5G5lMrDoTMizolgeXq
 UtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BaXv1gxEuljYaje+hDfDXRtILG3ZeT8f0aD36Klyo9c=;
 b=Mhoj8aMOcXTUtuRgYQnXFZTSBvUHmE7WLZw/69ZlPdq8MpFJi5e3ZjoZ0DzQKLweAb
 ptOhSBtH2tp6Q1Fip8nULKukBvWFtTvYZJ8CmkIpBgD0FVcxx0SVACROxzUOSCOeme+Y
 jpynpyClYCPw52FghIM/CahoXND0Ze3MEb14OGDSKnj2nrLjvP8iz7m2T47zphi/BOGi
 V9UoitZZcRN0kEzb+V27HACdAGeMk+n4manOEfA9XxagIaCol1g4DkIKStIUgSOQBv/m
 hTTTNeetZIEaypmWwhMJJ9F4i2YmMVjXKYGNQIkZZUtUmLXZbwftbnsYuc6EnqnP+pbF
 Iy3A==
X-Gm-Message-State: APjAAAVVXXjF8BjYvbWtyuxuz4mX69td5eUaaYM01dxni9ryUSojnxyu
 1AmiY3qPMohtw/4HJZJbaRSgJA==
X-Google-Smtp-Source: APXvYqx2kVDaK2wid8La7qtnYhl346vxT88x9tVsuZakK4ByPzS/a8xLyVWxIg/gFBWteQ1aNZ7FLA==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr130043288wrs.225.1564589241724; 
 Wed, 31 Jul 2019 09:07:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r15sm72111534wrj.68.2019.07.31.09.07.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D6121FF8C;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:26 +0100
Message-Id: <20190731160719.11396-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v4 01/54] target/arm: handle M-profile
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 bobby.prani@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this for other semihosting calls so we might as well do it for
M-profile as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/m_helper.c  | 18 ++++++------------
 target/arm/translate.c | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 84609f446e6..129d52a56bf 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2113,19 +2113,13 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
index 7853462b21b..0b02c520395 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10976,6 +10976,24 @@ illegal_op:
                        default_exception_el(s));
 }
 
+/*
+ * Thumb BKPT. On M-profile CPUs this may be a semihosting call which
+ * we can process much the same way as gen_hlt() above.
+ */
+static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm8 == 0xab)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+    gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+}
+
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
@@ -11611,7 +11629,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         {
             int imm8 = extract32(insn, 0, 8);
             ARCH(5);
-            gen_exception_bkpt_insn(s, 2, syn_aa32_bkpt(imm8, true));
+            gen_thumb_bkpt(s, imm8);
             break;
         }
 
-- 
2.20.1


