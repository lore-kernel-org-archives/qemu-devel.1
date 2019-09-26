Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E14C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74BF206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJkB1v/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74BF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYfZ-0001Hi-99
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcR-0007rx-Mv
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcQ-0006My-8X
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcP-0006LS-Tl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id q17so3602809wrx.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=haeueMXRtnUt4qwHhzJwxRwz4m2j4KzHASjuep+0Axw=;
 b=uJkB1v/SVPxox7wQIv5ZrOZcWFYNGdLQnsYl+yUzBM17GUgUlBoYqTm/wE6NmLuedr
 3RTwVkbrdIPF8q4CJ2PscmWGMIYA46cBJIEoJWqUZdP0H3+UaNnBmt6FW5rl0NuQvSEv
 ZiA6CFcRV40RK5gdVmRcFvHzBGjz3FJYvn0iktCkjvOrtUzW+UZHJfB6AVhzz0d9dKA7
 LqXspkauwzMpiYxG/a55nCvJG3eqRaspIxEkJehIIpk3+ara+mytpWTqSj7/C99jBC7R
 Coj2tD2vMwjbUVZ5S3i2ibVL1TXV/MJgR6DLzkTBtEMIaVPdUDX9cCvSyY7PcauZektj
 +B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=haeueMXRtnUt4qwHhzJwxRwz4m2j4KzHASjuep+0Axw=;
 b=D019bxcInrXyfghm7f6qelqAV6/8k2GoGdY2M2Hg3HTqWmQJukopqWy8etfKQB8jpk
 5/CrRPZmC1TaAlhyfvVWrike6GmgFBpzZjCXNcxwa7exOx9zCaWwC2Hc0/KBrr3eMZ6U
 bvnVHC5vGIyndMI9DBKBxLVxChZbX69FxchrYYk02laq5WeHr9/yyYsx/sfOi5yhFvzL
 eAVyT31Z0l3jdxX9byHfLaIU4sR0NtSNEPlm9oj/Ep76GlO8JXpTexs5bL6gwU4rBFAl
 /qDXTiLCSRu/DyV2janvLpD8MqORHI6/np6OzyJaAQ6J0Cnr3xmiyDNnjMu1Z+HDq5T/
 mJuw==
X-Gm-Message-State: APjAAAUgdl4kXATTizZwr1b6vc99R18GE349FPFbHfUhAUJOaUwQtGTY
 qepkikYlR8m+czHQjjKBGAna1A==
X-Google-Smtp-Source: APXvYqzxd8qU6BHfBIJWPLWGkMXLUk6NhakBhGYbAKoS4wzGvN/EtU2QffZ6ZahhPO8s/+bl17rSKg==
X-Received: by 2002:adf:e485:: with SMTP id i5mr4277128wrm.175.1569522956674; 
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm5827213wmf.48.2019.09.26.11.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 798E91FF90;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/28] target/alpha: Fix SWCR_TRAP_ENABLE_MASK
Date: Thu, 26 Sep 2019 19:35:28 +0100
Message-Id: <20190926183553.13895-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 Richard Henderson <rth@twiddle.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The CONFIG_USER_ONLY adjustment blindly mashed the swcr
exception enable bits into the fpcr exception disable bits.

However, fpcr_exc_enable has already converted the exception
disable bits into the exception status bits in order to make
it easier to mask status bits at runtime.

Instead, merge the swcr enable bits with the fpcr before we
convert to status bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190921043256.4575-4-richard.henderson@linaro.org>

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 10602fb339..e21c488aa3 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -46,34 +46,39 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
 
+    /* Record the raw value before adjusting for linux-user.  */
+    env->fpcr = fpcr;
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Override some of these bits with the contents of ENV->SWCR.
+     * In system mode, some of these would trap to the kernel, at
+     * which point the kernel's handler would emulate and apply
+     * the software exception mask.
+     */
+    uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
+    fpcr |= soft_fpcr & FPCR_STATUS_MASK;
+#endif
+
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
     t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
     t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
     t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
     t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
 
-    env->fpcr = fpcr;
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
     env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
 
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
-
 #ifdef CONFIG_USER_ONLY
-    /*
-     * Override some of these bits with the contents of ENV->SWCR.
-     * In system mode, some of these would trap to the kernel, at
-     * which point the kernel's handler would emulate and apply
-     * the software exception mask.
-     */
     if (env->swcr & SWCR_MAP_DMZ) {
         env->fp_status.flush_inputs_to_zero = 1;
     }
     if (env->swcr & SWCR_MAP_UMZ) {
         env->fpcr_flush_to_zero = 1;
     }
-    env->fpcr_exc_enable &= ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32);
 #endif
 }
 
-- 
2.20.1


