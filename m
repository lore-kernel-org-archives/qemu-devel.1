Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53FFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B392073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BckR/dk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B392073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmel-0006qF-Iw
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKz-0005pw-HH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:56169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKx-000665-PW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:17 -0400
Received: by mail-pj1-x102c.google.com with SMTP id 2so21065pjx.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2cPf8f8AdkhKlG+8ucMI1Z77vF2YecMji34EykTW4mg=;
 b=BckR/dk3q8enNYYRrlgBHDtOMtxv+XIONca/zQDIr8p+z7+h5rlvr3hCaLLSCLyvHz
 QfAdHc653Pjv2BM+Iia81ru9EJM0XEdLH5kNh3Eqz8QbGuS16VdzUmTO0Rzg0+9/ddmm
 FYv8sXBKiCC7zbhxPvom9ZhBit9l40Y6V91hmJYYRqa+OilH9CVzDux/JH7Pg6jWUGma
 Wg+0LqFFGU7poQ7hYSufwRSpCdml4mS191uMHn2zNZsbSA7vxXmFPvrtKQ/rIXCNt3on
 lyDUOc3ty+MS7w4izemic+Drf8pG8r8VpddWPgQ3pMbzFheFKwBpeUiZP2caHBEak0/T
 +ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2cPf8f8AdkhKlG+8ucMI1Z77vF2YecMji34EykTW4mg=;
 b=C74eAQRn5awa5ypXEKFbFmH64FHMIhcpDyNMEUJqXYUOXLlTQk/PxL6r9kLH5EFrqp
 8MIpfN0ZpVtBJIpOdo8AHyXenIyyfhjK9EhseO9Yy+BKD1LbpwoQa/MNUt2uGDmzP6rR
 hKBsRV85+7D1g+BTl9Mkvbtd8S7puLsRhH5F7qqnZU/swn+gqn7d63ZQjVkHyjVVsxTd
 d8eyol9UH6SEuf+9eAnP1YEC5ze9im/MtigFa3w1f+jctJY58iwCbNolacXaWV3+xg8i
 OFgSdRELmhjU05qCETmTngpLnoBxv86cXaAI6ZxSDsyWNpHOyNQcidz5gEZ6QMHJc+Id
 ey0w==
X-Gm-Message-State: AOAM533HeQXGVDD25+t4BGxpMWIDaX2VOkhKumpboZCuxDXMCfHoHSTP
 gTp8H+hF5mmt+jKsgqtXwWAflJh0bpfW3w==
X-Google-Smtp-Source: ABdhPJyuTR6ws67h4jZeyjkgEW4PO+6WFkt7iqbPvXC7Qnslyv4opOs4aYT3Kyy57ErjRzNSFPy0DQ==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr1558149plk.2.1598890034024; 
 Mon, 31 Aug 2020 09:07:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/76] target/microblaze: Fix cpu unwind for stackprot
Date: Mon, 31 Aug 2020 09:05:37 -0700
Message-Id: <20200831160601.833692-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct PC when an exception must be raised.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    | 2 +-
 target/microblaze/op_helper.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 64816c89e1..a473c1867b 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -26,7 +26,7 @@ DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_5(memalign, void, env, tl, i32, i32, i32)
-DEF_HELPER_2(stackprot, void, env, tl)
+DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_2(get, i32, i32, i32)
 DEF_HELPER_3(put, void, i32, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 2c59d4492d..a99c467364 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -389,12 +389,16 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
 void helper_stackprot(CPUMBState *env, target_ulong addr)
 {
     if (addr < env->slr || addr > env->shr) {
+        CPUState *cs = env_cpu(env);
+
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
                       TARGET_FMT_lx " %x %x\n",
                       addr, env->slr, env->shr);
+
         env->ear = addr;
         env->esr = ESR_EC_STACKPROT;
-        helper_raise_exception(env, EXCP_HW_EXCP);
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, GETPC());
     }
 }
 
-- 
2.25.1


