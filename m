Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D857820734
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xn6VMQhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D857820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKR1-0006Qx-68
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKQM-0005qE-Or
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:03:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKQL-0003iZ-0r
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:03:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id l17so9082742wmj.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GYiZ1xEPMJbBnQLRCPAHG6+ogJ1s4ydI9hrrJEU1OmY=;
 b=xn6VMQhXt+eLYKC+z4+ojovsahLJShdYj7IqpOBt061U6E36FkmQNSEIpvlWgpR/Fx
 sghGplLT+XIpjBstjlNKmY6eWA1WuOjDyYhDIELuZnW7xbVqCrj4aIE+Qg9cN+kLV7n+
 +pWOQHEACN8TOqe1Qvo9hJmIxb+2VDLAIJF6Bog3IGsn+wBGdjuaH1eLuV31sFYhZUXD
 qXQ3RnNFuoKSZ87aOFcimu4j56/P9S1XAMExRCPqR5P7TBv3jFy/PSLZccDufVxP9LMe
 J1XzBERhhNo/sI+KDAKHdsKsJhEW+UShLeUX8PtUIARxAMkO8mKSopLSCP04XSfvauc+
 6b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GYiZ1xEPMJbBnQLRCPAHG6+ogJ1s4ydI9hrrJEU1OmY=;
 b=SD8mJo2L6UlDK9YK3g5+jsDPHRO1C/mZDvxOHwfkGO6i6NhIlovBXCc9U6UTJldJhW
 kYrVnxh5QFCWX8je34wv1cRENIxbj9COYCaTqjQxpfkGyIEeS61SmNzKH/iWPgYJWJvj
 tjjXwjF9qe9m5bgkohwaSCL15XY3ecwMOaR/m69nRHuGTybheOKguwfwMLz2pvW0Uuh9
 t7y4vMyFliu9Z1X/NxV7upBIJV+84DrU7mEa1nNPnWq1YvBBKV40HZGjckSNntZjEl3C
 co6MBrkyHYdbpN5bVTxO9BL+IM8kaKm+KH6trqawBVCG6yYMKPJf0jX0MRkx8IQdCoXc
 r6vg==
X-Gm-Message-State: AOAM531aekneed87EvpyCIhAdovNJqTbVgJ/P8vB6m+IjyaF1UhecHCf
 u+6hNmHvVqPWA4xg43juJ7tJIg==
X-Google-Smtp-Source: ABdhPJzwNFjqUxBaVqvNXzKvzvydti1oKGLGHJm2WelH8mGrg665RTNTAWp/dznGLQJNeZObcorMEQ==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr4646798wme.89.1592586207324; 
 Fri, 19 Jun 2020 10:03:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c16sm7982936wrx.4.2020.06.19.10.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 10:03:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Remove unnecessary gen_io_end() calls
Date: Fri, 19 Jun 2020 18:03:24 +0100
Message-Id: <20200619170324.12093-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit ba3e7926691ed3 it has been unnecessary for target code
to call gen_io_end() after an IO instruction in icount mode; it is
sufficient to call gen_io_start() before it and to force the end of
the TB.

Many now-unnecessary calls to gen_io_end() were removed in commit
9e9b10c6491153b, but some were missed or accidentally added later.
Remove unneeded calls from the arm target:

 * the call in the handling of exception-return-via-LDM is
   unnecessary, and the code is already forcing end-of-TB
 * the call in the VFP access check code is more complicated:
   we weren't ending the TB, so we need to add the code to
   force that by setting DISAS_UPDATE
 * the doc comment for ARM_CP_IO doesn't need to mention
   gen_io_end() any more

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 2 +-
 target/arm/translate-vfp.inc.c | 7 +++----
 target/arm/translate.c         | 3 ---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e5da0..cf66b8c7fb0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2334,7 +2334,7 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * migration or KVM state synchronization. (Typically this is for "registers"
  * which are actually used as instructions for cache maintenance and so on.)
  * IO indicates that this register does I/O and therefore its accesses
- * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
+ * need to be marked with gen_io_start() and also end the TB. In particular,
  * registers which implement clocks or timers require this.
  * RAISES_EXC is for when the read or write hook might raise an exception;
  * the generated code will synchronize the CPU state before calling the hook
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e1a90175983..bf31b186578 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -119,15 +119,14 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
         if (s->v7m_lspact) {
             /*
              * Lazy state saving affects external memory and also the NVIC,
-             * so we must mark it as an IO operation for icount.
+             * so we must mark it as an IO operation for icount (and cause
+             * this to be the last insn in the TB).
              */
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                s->base.is_jmp = DISAS_UPDATE;
                 gen_io_start();
             }
             gen_helper_v7m_preserve_fp_state(cpu_env);
-            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
             /*
              * If the preserve_fp_state helper doesn't throw an exception
              * then it will clear LSPACT; we don't need to repeat this for
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6d18892adee..2677eaeb1e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8824,9 +8824,6 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
             gen_io_start();
         }
         gen_helper_cpsr_write_eret(cpu_env, tmp);
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         tcg_temp_free_i32(tmp);
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
-- 
2.20.1


