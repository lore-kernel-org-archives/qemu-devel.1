Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9639CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E01D20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRRkThJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E01D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgRF-0006ug-K3
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4P-0000jL-6m
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:29 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4M-00024P-AL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:28 -0400
Received: by mail-pj1-x1044.google.com with SMTP id nv17so123759pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vxCtytkH7BxiV9VxvRB9+Cp9GCqZrISTLIGoNOFV/HY=;
 b=MRRkThJ+jj13lgnIj+Z2+hpO/ieiSwhs+37RC4PFmMne9X2WsyDsTzrupZU7VJwx8h
 ORH7RGkU3ZonKxZgNelTDM6ue1oFf/QnoeZJ6u0SoeCtRHByfz9hBaVDHJM4Tb1w9b1b
 aj9Fl+9AiKGFgxrPaVZaJOiRtjWnxtrQmH3R2jp46v3rTYX5smG/DKPWNaPTjBFtptIk
 sxQZIuAI0jRhYohlU6cUgGS1+LLDaGKwGJYvxBdj/EKal97UuB/EYx9PGwdNeLMjWdzM
 OVNIoAaa0/qciXFGK9NDqleC9IxqRIg39L9WQIJgoQ9gXziPFhvValawt/0vEQrrFPFm
 fTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vxCtytkH7BxiV9VxvRB9+Cp9GCqZrISTLIGoNOFV/HY=;
 b=rzfwjWrpwyG3/7Pyc6G7rSGFRaOqx9RY0CUCjJeKWCZYBpRwnwukb3SWwfvwHUgAdD
 7MB/szTWZHPEyrSgpvAGFsKXRf8gF5m5XOTKmcZ629yHxm81+17RyzaKMvMw1uQ9lGrN
 61wm1/s+Md9CXcys/Fb2NPnSXsd1t7UBwlV8t4+sjR0DuYZt+xS/41nwLJtkKLz4asCZ
 XLlEJPX4nBqpE6po2PFNFTKhx+NmJ/IN+l9SQ8XwUsCW14U2jxt2bkvlqqT1BIExDTbW
 yQkZNGHVg1yqsQfDbF3uFadYUmO0Kq8+ghmUX7Eh4vscbjWSiU8JcfsgGaCF7ysJjR8Z
 I+Zg==
X-Gm-Message-State: AOAM531CLjVjDhmIjXdxbspjayOqybMLvSTuwn/5An7PPIaK6Au1X4VI
 pMCVL4RhVBTSdDHKcr2PC3H3M+dfx90BHw==
X-Google-Smtp-Source: ABdhPJyVU0oHRJ0p9SnirYLxVfjwUnNBvM3+RWnMiTok2zhu1tDL9lqSgx+f+lIFx8qPQYMf6z5Lig==
X-Received: by 2002:a17:90a:a101:: with SMTP id
 s1mr2843739pjp.205.1598389284668; 
 Tue, 25 Aug 2020 14:01:24 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/77] target/microblaze: Tidy do_rti, do_rtb, do_rte
Date: Tue, 25 Aug 2020 13:59:43 -0700
Message-Id: <20200825205950.730499-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

Since cpu_msr is no longer a 64-bit quantity, we can simplify
the arithmetic in these functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 65 ++++++++++++++---------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 22569693f7..71ceabfffd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1521,59 +1521,44 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static inline void do_rti(DisasContext *dc)
+static void do_rti(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_ori_i32(t1, t1, MSR_IE);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_IE);
+    tcg_gen_andi_i32(tmp, tmp, MSR_VM | MSR_UM);
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
+
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTI_FLAG;
 }
 
-static inline void do_rtb(DisasContext *dc)
+static void do_rtb(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_andi_i32(t1, t1, ~MSR_BIP);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM | MSR_BIP));
+    tcg_gen_andi_i32(tmp, tmp, (MSR_VM | MSR_UM));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
+
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTB_FLAG;
 }
 
-static inline void do_rte(DisasContext *dc)
+static void do_rte(DisasContext *dc)
 {
-    TCGv_i32 t0, t1;
-    t0 = tcg_temp_new_i32();
-    t1 = tcg_temp_new_i32();
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_mov_i32(t1, cpu_msr);
-    tcg_gen_ori_i32(t1, t1, MSR_EE);
-    tcg_gen_andi_i32(t1, t1, ~MSR_EIP);
-    tcg_gen_shri_i32(t0, t1, 1);
-    tcg_gen_andi_i32(t0, t0, (MSR_VM | MSR_UM));
+    tcg_gen_shri_i32(tmp, cpu_msr, 1);
+    tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_EE);
+    tcg_gen_andi_i32(tmp, tmp, (MSR_VM | MSR_UM));
+    tcg_gen_andi_i32(cpu_msr, cpu_msr, ~(MSR_VM | MSR_UM | MSR_EIP));
+    tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
 
-    tcg_gen_andi_i32(t1, t1, ~(MSR_VM | MSR_UM));
-    tcg_gen_or_i32(t1, t1, t0);
-    msr_write(dc, t1);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(tmp);
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-- 
2.25.1


