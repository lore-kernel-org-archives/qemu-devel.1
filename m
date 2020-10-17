Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD912C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F02072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmyZGF8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmuR-0001ss-H2
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnh-0001Xo-5I
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnf-0003hR-0L
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so6552604wrp.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NKriZfWZy7VDzuwNa8INVpQFiDmOp1zR9QaKdg51zCU=;
 b=bmyZGF8rClLcePprRp0bTQA+NNBuA50BsV490rx1eKcKn3iTqvgHkI6OA2rFygCJRF
 rr3rb998/1/mz7mtLX0RHX+jWfBBPkm8FKVTZWjXRlu2cnbLVVqKknT8kl7Cc4f3tefJ
 iZq5czFGsuGDkICDKYEqG6EIiNUkx9rOAZcSlA2ft5KlsVvcyk6dfIBJzG6H2aH3PIzs
 xF8Q1iSm9cPO9oC5XH1Esuxz35vFluJb0+SDRKe0xvr3IeFXHusAjNq774JhnE0/RnqJ
 VyEuaQkVvY7AdBliS10D5nYqM56kqQEKHbYAK3o/OgLDVnJlUYJzsb3YPfbHKfxzesEc
 k0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NKriZfWZy7VDzuwNa8INVpQFiDmOp1zR9QaKdg51zCU=;
 b=nTQ0QCS9F5QrZb+oLunI7yniLBu0/hSBtjK0+Cy5Xpi2aPoLLcxRoUfYWzCeN4xlKJ
 d2Fuluevugnb4AOcAWIgJuDCV8snqP8xlc47eGEGdIGccyJeNXT6XCX07JB5syQSEr1+
 udWkNL0+6YGGJq2qzz30+osQk9zZBkzoCchMjLgmNjntuatVnT1LixiA4w7LaLDXEO9R
 viTeXiYEm0fozKUkQpUkFTmFtEpM08kN82mAjRydVCG8CkkrVEXlnjz62nDQAABMwD41
 ADjEkeqNp+dh0m8ssr/fyzQeAAr1ooX26Fmn/VSzWUBehp2nL2Ql9ghtUPjzK/16c6Gc
 WGYg==
X-Gm-Message-State: AOAM530q8LUTMln6En6GkNnj+kslsZC3n5JMY0b3Q/JFTPng8S7dQFoU
 Y7uXRO3L7lYD7M8Wv04MZ2qOBjqEHk4=
X-Google-Smtp-Source: ABdhPJytxIKlOBIIqZpZuAYMSpmIP34nE2JS6VexfJLbd1A3Qbn0WgttJR+JbJE5UM528ibPSyOWWg==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr10459276wrq.399.1602943389522; 
 Sat, 17 Oct 2020 07:03:09 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id 205sm7816168wme.38.2020.10.17.07.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/44] target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
Date: Sat, 17 Oct 2020 16:02:04 +0200
Message-Id: <20201017140243.1078718-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1602103041-32017-2-git-send-email-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/fpu_helper.c | 59 ++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56beda49d82..f851723f22d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -983,27 +983,46 @@ uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 }
 
 /* unary operations, not modifying fp status  */
-#define FLOAT_UNOP(name)                                       \
-uint64_t helper_float_ ## name ## _d(uint64_t fdt0)                \
-{                                                              \
-    return float64_ ## name(fdt0);                             \
-}                                                              \
-uint32_t helper_float_ ## name ## _s(uint32_t fst0)                \
-{                                                              \
-    return float32_ ## name(fst0);                             \
-}                                                              \
-uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)               \
-{                                                              \
-    uint32_t wt0;                                              \
-    uint32_t wth0;                                             \
-                                                               \
-    wt0 = float32_ ## name(fdt0 & 0XFFFFFFFF);                 \
-    wth0 = float32_ ## name(fdt0 >> 32);                       \
-    return ((uint64_t)wth0 << 32) | wt0;                       \
+
+uint64_t helper_float_abs_d(uint64_t fdt0)
+{
+   return float64_abs(fdt0);
+}
+
+uint32_t helper_float_abs_s(uint32_t fst0)
+{
+    return float32_abs(fst0);
+}
+
+uint64_t helper_float_abs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_abs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_abs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
+}
+
+uint64_t helper_float_chs_d(uint64_t fdt0)
+{
+   return float64_chs(fdt0);
+}
+
+uint32_t helper_float_chs_s(uint32_t fst0)
+{
+    return float32_chs(fst0);
+}
+
+uint64_t helper_float_chs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_chs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_chs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
 }
-FLOAT_UNOP(abs)
-FLOAT_UNOP(chs)
-#undef FLOAT_UNOP
 
 /* MIPS specific unary operations */
 uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
-- 
2.26.2


