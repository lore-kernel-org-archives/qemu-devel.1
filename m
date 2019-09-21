Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA172C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786EF20C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0hMLBXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786EF20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBX8N-0005oX-W6
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5K-0003RG-55
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5F-0006YC-9I
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX5E-0006PW-Je
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:20 -0400
Received: by mail-pg1-x543.google.com with SMTP id w10so4977403pgj.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=N6+9fuZx1kzSXVJeSDepo9XmkdWGsxo7WFnloubWcfk=;
 b=z0hMLBXVgkFabCj2zb7KnZQh8Ji4In3fIndCAOvLm2DJdOjdeNN3x3fbxYngDYttXd
 CqVx/U2H1QgguP5l39H7hOpWZOybYOhSmxzCUtEAu2fcyLe+k8iwsoz34Je3A3qW1Ilh
 6aqH9bW/flNiyCjayuw8+IuhmmFqy3IrmIlG9KQmokLIk3FCOxqd6WZIgFXrK8w4NnvJ
 WM4FKHq3cXuEyUb0JCg4Nna3U/CS2wB++AekEGH/OaXSJkm5BXFsqg+BbogQWCz5TIZA
 nEOrCWP7fQ5Em49CMIGDtHzj4sH8FrM/p6sFEZze1t8tQrLn9X2p+q9Ej1SoFfFwEQFu
 67uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=N6+9fuZx1kzSXVJeSDepo9XmkdWGsxo7WFnloubWcfk=;
 b=qQ0OYF3ucTozBYQSjonlO7YsGuDJ8d5wEIP7n+sVL7AYei9a8ZTLB/aRHp6Bf+svX0
 /pq0RzQFU7RP6KuYktMw84ZaH7a6X+8g6lzeS6GUmfnvByBltgKsuEzWCWSzPVdhNtsL
 tN7jiAbJ/j3VwSY4SIuq6s59zjVqCVxEzPhmj4tGOjrO/uo0kC4CDGJShBHsOpD8BYZZ
 O7x4yIMIxeUoaNiKqVaBZf6TtuWcYdNVtTyNJ2kiYrrbXVF21m25f3357KQbMY3Ccg9Z
 /n6v2mKVEDSg10rJCRYVmeafyBLU9oLx9OGR1Ry+gxyoX8zjBMJMvNMjVVsfuWGXg1Mx
 pU6w==
X-Gm-Message-State: APjAAAU8xFJb3ZgtW3k6EPTERPeSk+P2dk2Htu4I4RVcUzXo4yBRORTn
 8sY0QXs3IPlcGEaPKRwnf4HE8b1QsSA=
X-Google-Smtp-Source: APXvYqwXhhGAAdUAQIAMTGhbatpRd3Lf9ItZRNQBJ/0xaE3W/4Jb5mDqrnN65osKhstN/G1ICGG8dg==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr21929919pfd.209.1569040384062; 
 Fri, 20 Sep 2019 21:33:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/alpha: Fix SWCR_TRAP_ENABLE_MASK
Date: Fri, 20 Sep 2019 21:32:52 -0700
Message-Id: <20190921043256.4575-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CONFIG_USER_ONLY adjustment blindly mashed the swcr
exception enable bits into the fpcr exception disable bits.

However, fpcr_exc_enable has already converted the exception
disable bits into the exception status bits in order to make
it easier to mask status bits at runtime.

Instead, merge the swcr enable bits with the fpcr before we
convert to status bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 10602fb339..e21c488aa3 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -46,19 +46,8 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
 
-    t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
-    t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
-    t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
-    t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
-    t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
-
+    /* Record the raw value before adjusting for linux-user.  */
     env->fpcr = fpcr;
-    env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
-
-    env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
-
-    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
-    env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
 
 #ifdef CONFIG_USER_ONLY
     /*
@@ -67,13 +56,29 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      * which point the kernel's handler would emulate and apply
      * the software exception mask.
      */
+    uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
+    fpcr |= soft_fpcr & FPCR_STATUS_MASK;
+#endif
+
+    t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
+    t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
+    t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
+    t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
+    t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
+
+    env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
+
+    env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
+
+    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
+    env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+#ifdef CONFIG_USER_ONLY
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
2.17.1


