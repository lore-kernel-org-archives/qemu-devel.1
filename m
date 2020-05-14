Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02059C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EA420643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMsP/ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJTy-000500-Ua
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPq-0006pG-DV
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:10 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPp-0007Kn-JC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:10 -0400
Received: by mail-lj1-x243.google.com with SMTP id g1so4759006ljk.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sYYgHAo2+EKZquY3ZxB7P+G7B9EmMHUqv6UWZNAADzw=;
 b=iOMsP/otSUituW3WOeGUXfT+MfvpkJuDxpFSJaoy67uDsJdXdVqDfm+WQ701bAsLYa
 EiHzgr/yjWwPG2+xh1RakpPuqcLn9hnkjd1RWwBNYERTbk6Jb95+BM7uKM7NIl5l2Uqk
 AGpKNzbLSUqGGrCJuH7SUppD6dUnOcNk8xjgZtnPisaNntq6LVgo44MTA7HbVi0F2R8e
 upGpSQFFYUyEFsC32GMDwqkoTwyuMRVI2h46ULNG8Y+v+ZAgYRB/Nu2afpVap0Hn9n5W
 KOzJUlZVm3qf3XWKPDwh/zFXvhvordJ54EeQIFbXZJP5YP1aujpyZKJl5ezI5vQhEI6O
 XxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sYYgHAo2+EKZquY3ZxB7P+G7B9EmMHUqv6UWZNAADzw=;
 b=ekXYJMJhr+iZvwFEzSkzGVaAMM1Z8y11f3zZBK1ryxov6tYFMJpqblnTN4e/l+uND7
 C279Nd3W16ZC9ntHAJL5Ie/MFlb+M5PjCPabfxbkaPlFWJbPgGk62WQgo3UVplTAKkVU
 IFZrRb4MtN2tag0JRITtTg8bti4jxwBvni3bsDwlWYQ9IuVhkBThVOKUrDVVRTXtMfAa
 ZvjgIxcBEeuRSqspWYHmYuENIwdIqEHFflgGqWyAiPQJekenEeodK6m7j2+lHr2RaHmy
 cbEycJenu+e+JRX246wOmhzPC+VvkcnE/4KApCUIppgUVKSRczkUMumxYBKXh86RFEqp
 sIcg==
X-Gm-Message-State: AOAM530a0HTh2c++t/ekn9AZ0xXEdc9KWFfG9eYEIdVSIjTtzMxFfp2j
 IpiSiBG7ovvmktg8vNfxhys9OKO52QU=
X-Google-Smtp-Source: ABdhPJwl8u45Lac3R++rH1C2EMGCn/K3zltzqY+HWBGqeJsn0zWl9+psfuEgkmjF5hh10bopd6S7vA==
X-Received: by 2002:a2e:9ada:: with SMTP id p26mr3890091ljj.14.1589484067514; 
 Thu, 14 May 2020 12:21:07 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:07 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/17] target/mips: fpu: Demacro ADD.<D|S|PS>
Date: Thu, 14 May 2020 21:20:31 +0200
Message-Id: <20200514192047.5297-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 5287c86c61..984f3f4dfb 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,12 +1208,48 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(add)
 FLOAT_BINOP(sub)
 FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
+uint64_t helper_float_add_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_add(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_add_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_add_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_add(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_add(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
+
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-- 
2.20.1


