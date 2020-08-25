Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107DDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA92F20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7j3LQ8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA92F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgLZ-0002tD-2e
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3y-00005t-JF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3v-0001zQ-KZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id g33so7674102pgb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R2cuEf3Qt/jcGcIZclz+3Hjy1ReL2CdcRjCqzKw0P3k=;
 b=y7j3LQ8ylTbYEThvqr4pjXq1SJaaM+ejNwiqt3pPalI8eEIngELZet7AzpvhZUCIbK
 UT6kcLnuLzCRpKJRaBEdQg0CcQvOLN94WxIrWx2kpQR5BSHISh6qtmzN+WsMPJfR+y1x
 jn1CJcegAJ5ULs+cEubVud5X6T2oBxqqLmttC4WRSk68hmNvf8UjIJZPCkGCcw2bVWS8
 Dc23wCLpbwcU4EIbdUhCF+HhMrPF33Tf6colk+3SZrJkbh6tZ8IYeBBQ62NF4hiXlLV4
 /HYz1tGyinXNirsETo5+N6meIcqpl4qWVM6YmQscBTpqMCjzhjuYoN1dPPW+8U8YR7Fn
 Uo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R2cuEf3Qt/jcGcIZclz+3Hjy1ReL2CdcRjCqzKw0P3k=;
 b=fmFI8FhhTutP0rb1JhMT2so9Jt5TklK/1pHPW9hDsCx2jPl3fCJNjZ1A5iVzn8wHOd
 jjJJryiI8thdRZ46RwliHz4KEe2xfW8rOM3VGW8IkRyUocVaCA8PAItM+VbWSPkALJaR
 CiKFnHABaPJpsjMSm7EQBTX7Id9ucU+fKsiHBtNviJrLCywEAyfL5pK7CvHPJ5TCMCYx
 JZ7WpiSqTvklmM/tVphHXiHZYjfJj4mHL3C6TU/lFvCfpjuyqX42iqvPJDjClP4zhhJe
 czYy4Tre5Ifl9YHAC1m/tb/KzjBQVhnYJEcIvdfKAQyiG4CPNlcZQ1r6ehVoYODqAARa
 YR9Q==
X-Gm-Message-State: AOAM530sWTwx/oEVAOOoiTKYj3XEiPcZQ6s1lJMGFmLoNWPZv9LNZOHk
 lS0tw5BQDUSCxtJfh/4hGUrDUVN4IeMyEA==
X-Google-Smtp-Source: ABdhPJw084YLCaztS/w94Nssbz87gRFUwCbLnFVpIGNMKaKRT2uQeIplqYgVD+6SpiepcM2plaX64w==
X-Received: by 2002:a63:ec04:: with SMTP id j4mr7979363pgh.393.1598389257218; 
 Tue, 25 Aug 2020 14:00:57 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/77] target/microblaze: Fix cpu unwind for stackprot
Date: Tue, 25 Aug 2020 13:59:25 -0700
Message-Id: <20200825205950.730499-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct PC when an exception must be raised.

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


