Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5862EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DC720738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imy4i4Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DC720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhVf-0003sD-9v
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH8-0003BV-58
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH6-0003Ie-28
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id g21so2877004wmg.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TIdOwUcKS8Gkz5ItNSYHwPJjx8yUuXeef+8VZHen8tM=;
 b=imy4i4Co6UtuJzDk0F1E4i7QeE36rYb+vtDSf+yrjRXTXfX7DHXgRtccBP4X3kZNmJ
 u55HjgLJ24gZNThHiPesfWAbEURzl3JZLcFkikMeqrfA3mQxPSOoq5m5aMlBoZeDeASY
 h3C+OV+Mo8ZBAfkQY30V5YsBUjmnkbmY8vIFB9BfLItbxDOpkkIpqAga94aHVelGfzaP
 zx+kTFN/MT+H1WLZsv0yAFLkzyVKTNO4scYEFplY+EF5bxYaUwkjGfAT/Z53bxRn7YaD
 WkBsIHStssp7IzMurUv72IQhleIwvIUtx1aqa0nvfNiCzn9PekWdgEIQBWJvuJFriy07
 SmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TIdOwUcKS8Gkz5ItNSYHwPJjx8yUuXeef+8VZHen8tM=;
 b=qtBYXQ8ERt0IwTT/b1Jeo5DRoiQ1evLJX0s2O/a7pp/O1h1XJVvo6gXRZdGbq2eagR
 QesoKTyoKmWdP+b5GVyyPmREhDgyK2CIqRv2sHl/eprOlE7Ix/mgxSdV9nvzHlSe1Ave
 xludtMA73sVnBoEsCBTFQ4MjKuBLztqEg24zKEx3I72vHRKDhHaHwvmjrwKr9SN4ZiBr
 8I0qHE5SRO3L7CC3d6MOmP6Iwyr7sHzxw6ynDa3qi938Xvl0aNskVXrtuQdX4mhLDdnd
 GNwROV+AHpk1TQNzIXkowqjCSnZ/nJSkCNhioBycpmIolcgjtCouyZokq/6Aoj+syVTe
 5QeA==
X-Gm-Message-State: AOAM532lMkTUS2KJLgumzpgdEqGgJZV1nRTOy4dq10Jg650PmT/txyze
 VtR81C/ObMDha8D4lpJdVIgSHuPIuYE+KQ==
X-Google-Smtp-Source: ABdhPJzpkT4+445FBBC0kusfDrJseOsuVV2JdKdBNiUqdZ58dvfBhYnR97yGU8wa1EaNv0m7nLuw2Q==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr10371833wmc.188.1592912374300; 
 Tue, 23 Jun 2020 04:39:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/42] target/arm: Remove unnecessary gen_io_end() calls
Date: Tue, 23 Jun 2020 12:38:46 +0100
Message-Id: <20200623113904.28805-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-id: 20200619170324.12093-1-peter.maydell@linaro.org
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
index 408fb7a492f..795964da1f1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7785,9 +7785,6 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
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


