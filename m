Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E7C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585D620848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKHtIbVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585D620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfoW-0005OO-Io
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFY-0002X0-Bo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFV-0005RY-4H
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id u20so750016pfn.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uKt+OEZaqpTnhdobh8nWk7pSRy/ghJfhk6PLOAf1cLo=;
 b=eKHtIbVj8VouqCoACHN4Q82KMK8IvDfHjd9/GK5dskg0RiM40c8nwI+7d8VTgeJ1WN
 5JcicoGj23WcAiWzHLpuq32iNh4AkiBvWNk457mYHzhG9qsiwbenGwKKpFVOB3bOJ3Za
 Y6ZI2D59P+vvzuCyPBu7W+tAGl+J1mwbY7Q1OFW/5YWXJWQiddtkGUEiUE+O9tUbUqHT
 D5nB5b5BRoiXZQhTKvaUGvOqCkKFQOYcy+Y2+839tnwturCiDys8eANRPmVvFI7cCJnY
 cU6MJ4Xp9tM2yejfjl6GPd0/YKX/RxpCeWO0KMKUPPxUPTqHl5utivDeDAi1E9OQ5MK3
 Eesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uKt+OEZaqpTnhdobh8nWk7pSRy/ghJfhk6PLOAf1cLo=;
 b=b8gX0mFpBM9nCLBOPLxMxiov0y8zzIKg9q73zAvYlPy41ROS30w6VHUxctACk7EWAn
 lb/ZD6rIlLLQsP3hZDQcGicwV5zjtWq+Cmsq1LUvNm01byU0rBOioUA6l04KylzlGVGK
 dIyKhOsX1qClKem7iT7VX1P3n8hagbGopPiUsgfZ/WZixGxY4i8h4IEZbHwcrFEBe2kE
 Wt48xpVnVINPiXnv3I6PeufzJtEePqHoN+lJQGhNdB8GAXfZ/AQhNvc3vE+shO6WRuRW
 qII9ItXM2qfMy3+q6TdjxLSoJeRldccEdyxHzeLlsM0MDwWdEKBWduordHYx3v51Kqyl
 qthA==
X-Gm-Message-State: AOAM532iBed9MoBV93vIv1Rox/RLISlf1D78Px1TlpNgEGPYNdej1XNT
 onQG/YAWeo6dPXNcN/jkzuy2MqWWJwSdlg==
X-Google-Smtp-Source: ABdhPJzSU/rmJ0eTxRP+8zEKWE6mgVA6V1cdchw2W7EDj8AJeq1Da0EZlMYtHKOgufBP5O+E3DaHWQ==
X-Received: by 2002:a05:6a00:9b:: with SMTP id
 c27mr1430775pfj.69.1598624459478; 
 Fri, 28 Aug 2020 07:20:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 69/76] target/microblaze: Tidy do_rti, do_rtb, do_rte
Date: Fri, 28 Aug 2020 07:19:22 -0700
Message-Id: <20200828141929.77854-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@xilinx.com
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
index 6c1855b29a..0872795038 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1494,59 +1494,44 @@ static void dec_msr(DisasContext *dc)
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


