Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07613C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98C72075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSMJjTLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98C72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaia-0007I9-1q
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacV-0003zR-12
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacT-0004Eb-7t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id o21so291841wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E/hUSBSlKb/LJszDXWsL9uhrET5mQxZ2BFMVcC2J7Co=;
 b=TSMJjTLQkWNiZVVwG5X4Zn7EytKqaVKF7KMetM3I04z77YSe+GZQH6H76BV8OLCiRk
 dBAhJwNPP801/aHuJ+iKRMckqkejEq2PMwBvQYIEyf4a8RWHFm8WS22GzMudBc4Q8DS3
 /Eh1q1W7yNxpJmmQBVJik/pzk5qotARWR2Z1A8c5ZCZZ7xPcM4vV79SbW/g+lGAtyxPw
 Bjqubz8A4xyx+tr5masfFXo4+OKCAEaxRf6xt1YHQj+zFuAbxGPGXXPTVFUNaDLf701f
 IEBHp8EtlddnPIVcpNatb2kUkVlCGy4Bm5o+nHXjn6/kY+JGy/fKwxt8QiBYj/Vnu/KK
 sE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/hUSBSlKb/LJszDXWsL9uhrET5mQxZ2BFMVcC2J7Co=;
 b=plHT7N08Y9+BqjYoH4TKuByvIVtNar1dbjhOsKd3iVzG+q5lUDR4Iuv8Vgx+XjpuKH
 WMhKVh16TXkXlefVQkYIaMhEvvGtIFDlvrRkaszoB9ZaOt1gAUpXaCHlCW60TDs0j8Ts
 VJKplQXGvwJrH9GokE8rXtazpgfUAqoDqLZ+khFzyUugT4e24jwzDQYhSCDiMLHC2Edd
 a+ZbdUAv94zaT/Q/REtraUoAjzKfPuAKpr9wSl8eXD0F98djMc5iwoVV96+C00Tvs60n
 mbh4ZJh8kXEDNX3XBsmGv/WPHo8Ix/ImoAPCF3vEhwIN3iBvfgCyC9cK7km1lYxsYIZ3
 X8xw==
X-Gm-Message-State: AOAM531vlvpvnT+q4J3U1t4P8ac7sQrN266ME0khhzEMl/eCrj+uKHVH
 76QcYcPcboKWC4dY7UBnTvtV6KhTczANRTO7
X-Google-Smtp-Source: ABdhPJyqHe5kEtaGk/6I+u78J9SZxvUEZqhDdjQA6m3o0poRO13qKR3XBeES0CJgyRUxk93h9K2YuA==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr672481wma.111.1598606663666; 
 Fri, 28 Aug 2020 02:24:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/35] target/arm: Fill in the WnR syndrome bit in
 mte_check_fail
Date: Fri, 28 Aug 2020 10:23:46 +0100
Message-Id: <20200828092413.22206-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

According to AArch64.TagCheckFault, none of the other ISS values are
provided, so we do not need to go so far as merge_syn_data_abort.
But we were missing the WnR bit.

Tested-by: Andrey Konovalov <andreyknvl@google.com>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200813200816.3037186-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/mte_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index a40454588d2..891306f5b02 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -519,7 +519,7 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
 {
     int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
-    int el, reg_el, tcf, select;
+    int el, reg_el, tcf, select, is_write, syn;
     uint64_t sctlr;
 
     reg_el = regime_el(env, arm_mmu_idx);
@@ -547,9 +547,10 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
          */
         cpu_restore_state(env_cpu(env), ra, true);
         env->exception.vaddress = dirty_ptr;
-        raise_exception(env, EXCP_DATA_ABORT,
-                        syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0, 0x11),
-                        exception_target_el(env));
+
+        is_write = FIELD_EX32(desc, MTEDESC, WRITE);
+        syn = syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, is_write, 0x11);
+        raise_exception(env, EXCP_DATA_ABORT, syn, exception_target_el(env));
         /* noreturn, but fall through to the assert anyway */
 
     case 0:
-- 
2.20.1


