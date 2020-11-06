Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6947C55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4100A20756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7wrLVWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4100A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasoU-0005KI-97
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSL-0005ql-8t
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:29 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSD-000782-KG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:28 -0500
Received: by mail-pg1-x542.google.com with SMTP id r186so2901134pgr.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mZ7Cv5t9pDHcLwkTAHUkGoZLzbW+EIVJw5j5xRLRZ3w=;
 b=C7wrLVWzSbo5zuChMYXczJZR/AgSPwsJHXK7QHRq2zn7Ab29v5QwH2BZpzKDJ1eQLN
 PMCfsAwkdLKaIlkAUfO5CThmScXL+JYSOEJ7zz33fETJ+Rdi3H5/umeiJyLnrKcOLOCf
 IVyJk8n959I/lPmWrvn7/BZ/XUNOxsqgXXxTb/axVd9DzyiJ4a2AVVnU/exu6WW9RskQ
 o3hO+PhDc/l1ktCDe1slScCxjFAYscAbIJM+yB2BdQVXAmm+mFN4tcruZmkQkSJlXMQB
 zNg3OoRZGz915NAhcDKoKl4L/bm1sZ27GDRa6UyL98kPWouhxGCQ7F2+822kAztZjq8+
 s9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mZ7Cv5t9pDHcLwkTAHUkGoZLzbW+EIVJw5j5xRLRZ3w=;
 b=D+EIbfyxiFEAOpQwDznrLLHnrhLE9c+jch5EqNKHNh2YGsb095yzu9HMt+zG8SlwWR
 G0p1/ZT28Ru+G+TLDdIvLgpxqnHv8ewZHcgitTL9tehb3DL+WguhWTQIjTlQPLphFGR1
 7WMC45HdZ8dvB6yQxoyCVyNzxU0CnuK0xZxMDdpfpos0Gjf8QW3/zW7+XwyuIfAsltb8
 PjkBzmIzSySN5VZYC7qvJ/Sgu9hIyF3jU1Sg3mTJ6I/RjRekxmqE3Vz8VElxtp4dd5gK
 tD79kCesSEgloKUF4pB4DCpL+3jpe85fBfN1ZMvA921eY8Ta6ODZ4P6MWHOOfD/gd40y
 DMiw==
X-Gm-Message-State: AOAM5304A4q8sIAdngVmp9+/26t2unNMhkcWZgi/bnNSmg7AKuQ98Lb5
 tRhasdV2kkoIkQDPDNqdq2VUJT0Ant8vPA==
X-Google-Smtp-Source: ABdhPJyCTceehDjzGcLnoTEatk14hCxooiDUt5eFLqKs3bgZbDxZIy9Z0TO01RRbQKVG2FhFr9lFEw==
X-Received: by 2002:a17:90b:19d6:: with SMTP id
 nm22mr142429pjb.159.1604633402203; 
 Thu, 05 Nov 2020 19:30:02 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 28/41] tcg/sparc: Use tcg_tbrel_diff
Date: Thu,  5 Nov 2020 19:29:08 -0800
Message-Id: <20201106032921.600200-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc/tcg-target.c.inc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index d599ae27b5..8f04fdf981 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -440,7 +440,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 
     /* A 13-bit constant relative to the TB.  */
     if (!in_prologue && USE_REG_TB) {
-        test = arg - (uintptr_t)s->code_gen_ptr;
+        test = tcg_tbrel_diff(s, (void *)arg);
         if (check_fit_ptr(test, 13)) {
             tcg_out_arithi(s, ret, TCG_REG_TB, test, ARITH_ADD);
             return;
@@ -537,15 +537,15 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
-static void tcg_out_ld_ptr(TCGContext *s, TCGReg ret, uintptr_t arg)
+static void tcg_out_ld_ptr(TCGContext *s, TCGReg ret, const void *arg)
 {
-    intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
+    intptr_t diff = tcg_tbrel_diff(s, arg);
     if (USE_REG_TB && check_fit_ptr(diff, 13)) {
         tcg_out_ld(s, TCG_TYPE_PTR, ret, TCG_REG_TB, diff);
         return;
     }
-    tcg_out_movi(s, TCG_TYPE_PTR, ret, arg & ~0x3ff);
-    tcg_out_ld(s, TCG_TYPE_PTR, ret, ret, arg & 0x3ff);
+    tcg_out_movi(s, TCG_TYPE_PTR, ret, (uintptr_t)arg & ~0x3ff);
+    tcg_out_ld(s, TCG_TYPE_PTR, ret, ret, (uintptr_t)arg & 0x3ff);
 }
 
 static inline void tcg_out_sety(TCGContext *s, TCGReg rs)
@@ -1313,7 +1313,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out_movi_imm13(s, TCG_REG_O0, a0);
             break;
         } else if (USE_REG_TB) {
-            intptr_t tb_diff = a0 - (uintptr_t)s->code_gen_ptr;
+            intptr_t tb_diff = tcg_tbrel_diff(s, (void *)a0);
             if (check_fit_ptr(tb_diff, 13)) {
                 tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
                 /* Note that TCG_REG_TB has been unwound to O1.  */
@@ -1345,8 +1345,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
             }
         } else {
             /* indirect jump method */
-            tcg_out_ld_ptr(s, TCG_REG_TB,
-                           (uintptr_t)(s->tb_jmp_target_addr + a0));
+            tcg_out_ld_ptr(s, TCG_REG_TB, s->tb_jmp_target_addr + a0);
             tcg_out_arithi(s, TCG_REG_G0, TCG_REG_TB, 0, JMPL);
             tcg_out_nop(s);
         }
-- 
2.25.1


