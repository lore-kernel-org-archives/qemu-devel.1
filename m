Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01566C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 01:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F042076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 01:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaHWO7oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F042076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIMSX-00058e-2f
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 21:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIMRa-0004ih-Kx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 21:41:10 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIMRW-0000I2-JV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 21:41:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id s14so729612pju.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GAGaljXlaz2uMN7I2hwem12uiDd/55tS/WQpdq1xbZs=;
 b=CaHWO7oH57uPrbq5ub5BxymKD7RULp/d/pF6Hv5fVT+j6CpU7P+8tAqoh8f8CegQEu
 GxOMI/o0DYSirhPaIxrLYG1uSXYG9hXqzN7rrACTNNkAvfKP8kNRF/YBQlmW+NdR+Lgo
 gq/XXZwQ6mLLEDczEBuMKYethqABKzSxapLcCGevW5VzVdvtaWPO2nNuPNgdIiC56Da4
 zSm58Sm/o+tiDnRImO5eUo7tySjA0GpgJx90R8v7/YfNpNGYr9ptUzCM9y+mRex7oJTj
 AzehEpcai8P05wuEqA+SNe4ItQDDvzAKgjx24X6iYrJs4QejgAq8bMrT3T15xRJOXb+I
 iTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GAGaljXlaz2uMN7I2hwem12uiDd/55tS/WQpdq1xbZs=;
 b=Xbe4+d3s41I7+vUnPzrhbGqKKiYgemCieBXzBSW+rEMRd0lBjgERWG3ZXqoUwZfGpK
 e9czafzzZnh9O2nYI2WtOIwJQqeHMdGWHm0IJUbBECZtbT1U1a6qxyQPedcnQZv9D1gD
 RyVdEFAgzj7ET6ea+SfKsSgRtDBA/AD7VJzm5aFaffHfnLsYu5v5mRU46/Wia4pVeW57
 xvyVjRQ73K7PNH2ZqPjm6K+qn0ch7A+cXOJdec85LORFCltjohr1l8AHRE+ZDzGTtsHk
 rLkGclsarHQJbunYmhZGd0O5xyEA5ZE22GbjyhlDovGpV8aNUUqzoY+cO8xoMgS9zl3R
 nrYg==
X-Gm-Message-State: AOAM531mcxncAQDLE5RRn2gmZpEQLOcSVTCQ88Aztgayw83ILwybnGEj
 TDIYwHCEYV0jtWZqeNIvN10FIQ2U/VQ22g==
X-Google-Smtp-Source: ABdhPJxeNquQFnk0ioc/egpBbWOA17Xy7eYzROhxouEBh7sDxDEO/ua4wHLZEBsiboI9jdIxICDv3Q==
X-Received: by 2002:a17:90a:d813:: with SMTP id
 a19mr1740748pjv.115.1600220464527; 
 Tue, 15 Sep 2020 18:41:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q5sm15376344pfn.109.2020.09.15.18.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 18:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix sve ldr/str
Date: Tue, 15 Sep 2020 18:41:02 -0700
Message-Id: <20200916014102.2446323-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mte update missed a bit when producing clean addresses.

Fixes: b2aa8879b88
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b6251..c0d8a5863a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4290,7 +4290,7 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEQ);
             tcg_gen_st_i64(t0, cpu_env, vofs + i);
-            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
         }
         tcg_temp_free_i64(t0);
     } else {
@@ -4379,7 +4379,7 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         for (i = 0; i < len_align; i += 8) {
             tcg_gen_ld_i64(t0, cpu_env, vofs + i);
             tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEQ);
-            tcg_gen_addi_i64(clean_addr, cpu_reg_sp(s, rn), 8);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
         }
         tcg_temp_free_i64(t0);
     } else {
-- 
2.25.1


