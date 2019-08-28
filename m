Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D5EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4987B22CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGFI9v+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4987B22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3477-0008OH-WD
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gw-00040k-GO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gu-0000ke-D7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:22 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gs-0000iM-M7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id k3so209653pgb.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YeIFIe6n+qNkaqMNDbQLOQi6RqvsGYoOCEwWlKiQ2C8=;
 b=cGFI9v+yYvM7OyVOL802yWUrQ+heODsU5521ukAB2ZrcogJj/fekfXMGfX6jwwqIug
 t6/VBxuZm/i4bI1YnI8BXxoeMAuKeR8DaQ/R/HFcFTX0FVvmQ0eynQU01zauTeUT7eF/
 kPamqgGP+WZ8zH85efEalIvJRrYrrHg8+kH7yC1IQYlFbxGfvfn69o5Aa+RJvDbqXKfL
 s0kxKZQ/guVv+gXgT6E2PPpPAgEpeu81TNf+JZ4uEfS9ZoXix3MOE+1La8/U8zfF4c7T
 U6MjisURYrKUJOaLtQLmrD9ziLZeReo86PcVX3s+Cs0y4tS/doh9mFXDlT7A7TlyOW9y
 Y3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YeIFIe6n+qNkaqMNDbQLOQi6RqvsGYoOCEwWlKiQ2C8=;
 b=U2EiYX7ZlGfo2viLU5zIjKjJiaaXq8gLy23nDchPCuHIrNvdwULgUKCLIrvJqHB5oq
 0oGsISoODgdTm14W9D2BokD299p/XNKQz3KTeQmStjfMg1wxSYwoXEY/KCJhT07VF01n
 gsQGqzcC6X2DbW6P5U4DCkMxWzcNJid3/oflaRgSoC9uMp2aVq1cB2w5W9ZwiDXoLYKY
 e8wQAUhjL8MRHT0KtAvbwAXDnVw6ASmbP7OARFArIzBcHopX2YamvtaXokt9/UQ/40Ap
 IJhFkOomacqh4wTEWV2xZgrKTeBsdDD44Js2yX3cUhx10T2gig9ttjUO9IsnG2g9znas
 FR2Q==
X-Gm-Message-State: APjAAAUv6BdHSluFvOYOj8m0w6xTcX8/tJhSGsjR540GtnmHbuxNwV3M
 RAFoE4Oc/wzdAyKBSwGm3L6cEWD0mSw=
X-Google-Smtp-Source: APXvYqxmtq0TKe6qHkp80fK/yuhXBmX9264XVMKfuufMSDOW0SyXqmkCUtn/6exbTO56OfogSiBoqw==
X-Received: by 2002:a65:5003:: with SMTP id f3mr4798865pgo.335.1567019175981; 
 Wed, 28 Aug 2019 12:06:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:47 -0700
Message-Id: <20190828190456.30315-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 60/69] target/arm: Split gen_nop_hint
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all callers pass a constant value, split the switch
statement into the individual trans_* functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 67 +++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 43 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1bbfea8ea4..c7d7834440 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3042,46 +3042,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-/*
- * For WFI we will halt the vCPU until an IRQ. For WFE and YIELD we
- * only call the helper when running single threaded TCG code to ensure
- * the next round-robin scheduled vCPU gets a crack. In MTTCG mode we
- * just skip this instruction. Currently the SEV/SEVL instructions
- * which are *one* of many ways to wake the CPU from WFE are not
- * implemented so we can't sleep like WFI does.
- */
-static void gen_nop_hint(DisasContext *s, int val)
-{
-    switch (val) {
-        /* When running in MTTCG we don't generate jumps to the yield and
-         * WFE helpers as it won't affect the scheduling of other vCPUs.
-         * If we wanted to more completely model WFE/SEV so we don't busy
-         * spin unnecessarily we would need to do something more involved.
-         */
-    case 1: /* yield */
-        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->base.pc_next);
-            s->base.is_jmp = DISAS_YIELD;
-        }
-        break;
-    case 3: /* wfi */
-        gen_set_pc_im(s, s->base.pc_next);
-        s->base.is_jmp = DISAS_WFI;
-        break;
-    case 2: /* wfe */
-        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            gen_set_pc_im(s, s->base.pc_next);
-            s->base.is_jmp = DISAS_WFE;
-        }
-        break;
-    case 4: /* sev */
-    case 5: /* sevl */
-        /* TODO: Implement SEV, SEVL and WFE.  May help SMP performance.  */
-    default: /* nop */
-        break;
-    }
-}
-
 #define CPU_V001 cpu_V0, cpu_V0, cpu_V1
 
 static inline void gen_neon_add(int size, TCGv_i32 t0, TCGv_i32 t1)
@@ -8168,19 +8128,40 @@ DO_SMLAWX(SMLAWT, 1, 1)
 
 static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 {
-    gen_nop_hint(s, 1);
+    /*
+     * When running single-threaded TCG code, use the helper to ensure that
+     * the next round-robin scheduled vCPU gets a crack.  When running in
+     * MTTCG we don't generate jumps to the helper as it won't affect the
+     * scheduling of other vCPUs.
+     */
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        gen_set_pc_im(s, s->base.pc_next);
+        s->base.is_jmp = DISAS_YIELD;
+    }
     return true;
 }
 
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
-    gen_nop_hint(s, 2);
+    /*
+     * When running single-threaded TCG code, use the helper to ensure that
+     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mode we
+     * just skip this instruction.  Currently the SEV/SEVL instructions,
+     * which are *one* of many ways to wake the CPU from WFE, are not
+     * implemented so we can't sleep like WFI does.
+     */
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        gen_set_pc_im(s, s->base.pc_next);
+        s->base.is_jmp = DISAS_WFE;
+    }
     return true;
 }
 
 static bool trans_WFI(DisasContext *s, arg_WFI *a)
 {
-    gen_nop_hint(s, 3);
+    /* For WFI, halt the vCPU until an IRQ. */
+    gen_set_pc_im(s, s->base.pc_next);
+    s->base.is_jmp = DISAS_WFI;
     return true;
 }
 
-- 
2.17.1


