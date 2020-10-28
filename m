Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E3C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9552242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlqjFTYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9552242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcBO-0001LQ-2L
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7H-0005lm-28
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7F-0005nt-Ds
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id b19so1816618pld.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PzEKwCdPZHtQpaS3rSzSooMjXk0UfsubT3zCzhcVGPc=;
 b=UlqjFTYUBTRQ1QMzglwYS1l4sK1esJ7EEqyB5r5Fo46dJsw4lW2+783uLLUlb/N0lB
 WF/eC8kcDGrs3gaym4zU6l2bdCe3tONe2x0zvw2wam4TxNL0/BVfIO47+kM63HnC3HO3
 A2GvD2g56z4W67QNRT0k0OCR99vQHolMQy1+41iighuvAN7a2aGxwLOB4oedQ4ciBfmb
 wqSuYkN6lhn35zQ1h1uPteaHgBEJhX1fgOLxl/zehuZWzR3fv6QeV9/3TjRFY9dHvKPw
 FdyZU0xZ1KiIYd2VJzsPv8J5IlH3yXQIwTIBkUtj1M8jYO7WMA6WDbs6gbaag1oppdAL
 gkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzEKwCdPZHtQpaS3rSzSooMjXk0UfsubT3zCzhcVGPc=;
 b=o3iVs5Gsxkb2JYAbKPg/LnwvgdiuIJi66uHKlaF3OEwE93R2gNpgLY2HrS3lzs824N
 V5FmIR0b+atI7JnPk5iLyqulDyMQbTP9QXL7QeKy4oJvCOVFxn7Aj6pmYUAk+v4ALrIz
 iFDdaFESBsrAp5Rbib3sa4agy3UWgYxHF31MqxOL/AUL64xk6W0VvNQmn4WT9HiGFdIU
 2EBPBUOAq+O85rgzO8sKyYbmnIXeKYfklfvAnjX0j9tw9RUV/uzBJZexts4Y9lySD/Kd
 ST34E3RNQGnGxRa5kQYG2JuR2t+zn2xF2qLgE1ci/Q68cZvQMKYzbtbwSQh1XaQkfLiu
 3iZg==
X-Gm-Message-State: AOAM532nOvd5kTMYqXQkIm4X3AzZJ2cl6QdGSG4sLyK25UAqsj0/+/XP
 zal5rhdu9egc4/D76/UHb/qhygpJkw7ZMw==
X-Google-Smtp-Source: ABdhPJykOJ+OnFx1PlBazfyvZF+4xVBMC8vDDRXQrKoQml3TwnN4NWT8a8sWIb8WUbUrNkNk3+foaw==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id
 d21mr4741698pjw.168.1603855631494; 
 Tue, 27 Oct 2020 20:27:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] target/arm: Use neon_element_offset in
 neon_load/store_reg
Date: Tue, 27 Oct 2020 20:26:55 -0700
Message-Id: <20201028032703.201526-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

These are the only users of neon_reg_offset, so remove that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bf0b5cac61..88a926d1df 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1137,26 +1137,16 @@ static inline long vfp_reg_offset(bool dp, unsigned reg)
     }
 }
 
-/* Return the offset of a 32-bit piece of a NEON register.
-   zero is the least significant end of the register.  */
-static inline long
-neon_reg_offset (int reg, int n)
-{
-    int sreg;
-    sreg = reg * 2 + n;
-    return vfp_reg_offset(0, sreg);
-}
-
 static TCGv_i32 neon_load_reg(int reg, int pass)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_ld_i32(tmp, cpu_env, neon_element_offset(reg, pass, MO_32));
     return tmp;
 }
 
 static void neon_store_reg(int reg, int pass, TCGv_i32 var)
 {
-    tcg_gen_st_i32(var, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_st_i32(var, cpu_env, neon_element_offset(reg, pass, MO_32));
     tcg_temp_free_i32(var);
 }
 
-- 
2.25.1


