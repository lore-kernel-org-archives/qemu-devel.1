Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613BAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF95206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmtBHwaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF95206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdhm-0001cz-7W
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcs-0004ss-9O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdck-0002X7-QK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:44 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdci-0002Qb-Vg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so2931998wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OJ0FWXyVgln1qSkZCWjjhNl0S2nBbp6lHjR8Gp2aWVw=;
 b=DmtBHwawVEeNJgubLkaQbh2rFgv8NVyg+uGpxb5hWGcn4HIEMSMhwwbJN/BACYx6ny
 9iXAnybbzx1em2J/g9jp9OGiDz7VG9FeQMiZn9EgGKRvV055JZwrgqfd6NLWhCNwLn+s
 iKTSLq6W5iKjsfy4IYGcfk/nVvlBe1+uPCKAvAJ6SJkT3CxFE1WAI5buLgRxMMn6woQs
 FyLGjcTugTK6XJvmH/D1nELbCPCDEQuJF2eaLPB7/yS6e/nlVYMHCzkVz8meAYY6Z1VT
 X98ZIJ3Yprn6xRF8Hz9RJLwR9b1CT3KAJGRwyI47lbyOlDk+0bUbxp9ZljdUfUYDin7e
 7ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OJ0FWXyVgln1qSkZCWjjhNl0S2nBbp6lHjR8Gp2aWVw=;
 b=alhYi4AIBVWTSCI8DzJJeJaZSpvsfcF07dWHZpiFCwa9uTBak1qdk7JejcjCd/du9O
 0w54+BxhOOHRId0fZfG7P/IqTv33jfdkl/tHeOkyfi0WW9NZClxuX+Hd5ms0pUcCLQ8V
 /KSLES9k7YH+QknVh4NusPmfoyLlZ5KGJgqCVIYtBd28jW/TCVJObrUPj7LO3cdFBw2Y
 7YtyCSDa0jKpE/2E9GGHJly82ufPRmI5btTCEBdHSUSwQ5eUMkib2RULfwHojeEbFWW1
 RT8nFkZn/wSJY3En+YvtQlo1arJ1CIKe6eO6qrfk7IyrgUFzKo0GNfYaipP81ODBv5u8
 Bg1Q==
X-Gm-Message-State: APjAAAWlSJvMHr1heTAJJlb+eB6H/QZ/78T4FDuttIG2SUVirxB/3ks7
 0yXgYd34Qy2jIUlagZfZ+yXNvQ==
X-Google-Smtp-Source: APXvYqwAaJtrW7vvxjim3Mq/1fo3QKUsJw6jhZFf6oMrKmgGnX0gPEm2KsPPG7FpmnkQTQ+ij1pGJg==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr4441035wma.121.1576692034227; 
 Wed, 18 Dec 2019 10:00:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k13sm3391284wrx.59.2019.12.18.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:00:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D33E1FF8F;
 Wed, 18 Dec 2019 18:00:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] target/arm: only update pc after semihosting completes
Date: Wed, 18 Dec 2019 18:00:27 +0000
Message-Id: <20191218180029.6744-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218180029.6744-1-alex.bennee@linaro.org>
References: <20191218180029.6744-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, pbonzini@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before we introduce blocking semihosting calls we need to ensure we
can restart the system on semi hosting exception. To be able to do
this the EXCP_SEMIHOST operation should be idempotent until it finally
completes. Practically this means ensureing we only update the pc
after the semihosting call has completed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 1 +
 linux-user/arm/cpu_loop.c     | 1 +
 target/arm/helper.c           | 2 ++
 target/arm/m_helper.c         | 1 +
 target/arm/translate-a64.c    | 2 +-
 target/arm/translate.c        | 6 +++---
 6 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 31c845a70d4..bbe9fefca81 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -130,6 +130,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_SEMIHOST:
             env->xregs[0] = do_arm_semihosting(env);
+            env->pc += 4;
             break;
         case EXCP_YIELD:
             /* nothing to do here for user-mode, just resume guest code */
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 7be40717518..1fae90c6dfc 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -377,6 +377,7 @@ void cpu_loop(CPUARMState *env)
             break;
         case EXCP_SEMIHOST:
             env->regs[0] = do_arm_semihosting(env);
+            env->regs[15] += env->thumb ? 2 : 4;
             break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4dc2274c8b..088e2693df8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8602,11 +8602,13 @@ static void handle_semihosting(CPUState *cs)
                       "...handling as semihosting call 0x%" PRIx64 "\n",
                       env->xregs[0]);
         env->xregs[0] = do_arm_semihosting(env);
+        env->pc += 4;
     } else {
         qemu_log_mask(CPU_LOG_INT,
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
+        env->regs[15] += env->thumb ? 2 : 4;
     }
 }
 #endif
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 76de317e6af..33d414a684b 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2185,6 +2185,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
+        env->regs[15] += env->thumb ? 2 : 4;
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe6295..972c28c3c95 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1937,7 +1937,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 break;
             }
 #endif
-            gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+            gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
         } else {
             unsupported_encoding(s, insn);
         }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf9..5185e08641b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1124,7 +1124,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         s->current_el != 0 &&
 #endif
         (imm == (s->thumb ? 0x3c : 0xf000))) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
         return;
     }
 
@@ -8457,7 +8457,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
         !IS_USER(s) &&
 #endif
         (a->imm == 0xab)) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
     } else {
         gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
     }
@@ -10266,7 +10266,7 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
         !IS_USER(s) &&
 #endif
         (a->imm == semihost_imm)) {
-        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->pc_curr, EXCP_SEMIHOST);
     } else {
         gen_set_pc_im(s, s->base.pc_next);
         s->svc_imm = a->imm;
-- 
2.20.1


