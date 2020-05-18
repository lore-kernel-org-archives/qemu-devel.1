Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B3620657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn0fcvaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B3620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalrZ-0006H1-IC
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalei-00031k-CB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:32 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleh-0004cx-LY
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:32 -0400
Received: by mail-lf1-x142.google.com with SMTP id w15so1790236lfe.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6bLqctmqV5Mx2G6wit9y/QaIjTbRVw7Js7a4gwFi+NU=;
 b=fn0fcvaJ0juLIw8fI2SGidOP8FMjX2jniKm5W/QvQlLQoNiSmk7kOZ07eaYW58Iell
 tH/V6n+2z4paLr5EaQcqPxo76XaDdoZhKgmJod76Cn6CoYO26XndrEjnHEtTgNXBZQtB
 R6cC8ICeGQ5xCt98qWu8P+SBBpY6kRcfKJmPxRkc3PIChuZYghvEdcpmYAs03uFappIE
 y+ZtCIJV94Dn7IBpuDUctQiu0f84GIhw3E0zwbMTTDQyZiz0q/wfcuDUiwQiboWrNNpc
 V0eB4YS1Qp4EwwLxiej1BfO084CnjSQz7gPiWobshOwbGN1WLsdbrvxPHqbZOPU9fwQN
 lTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6bLqctmqV5Mx2G6wit9y/QaIjTbRVw7Js7a4gwFi+NU=;
 b=KDTuxauxRgb1zd4y0aNndagmwzq2yORc27iTje5WkzpvS2IevLLKCYQ8t2htX48imA
 gEAXLkenJ3w57BVycFrsnm8um9ZO7sHNIT1yNQRcZcg1us+rO2TN/R06thqHV1jfqqIv
 zWwpbILpRcY3AQ1ejzt42R4FxKSk/tOML4AxZxyxp5+rSnOUqQrDblSWgfY4P3ADs+e2
 Xq4Uno4wMuIuaGk43peLnXtcFWRF6jsShfaMlFkgXXdvaOZKe5kDwQyZpcCdgom3s+81
 AKCSMZvgLCIgZOZs0jZNo0FWkyR0lpuGEENaYRCU+K4Bq57zJY2G8LrA5g0xJ6wzcJGX
 7C/w==
X-Gm-Message-State: AOAM530jm/Y9xFmRsDlJQtRkGD2kZRgkArFyWyujmpqqHn0bVV2IIU0D
 5FTm/ey4uaxXZADxUUtVt02+Rur8Wqk=
X-Google-Smtp-Source: ABdhPJwR/a3woBg0lqsU23EJtnH3lnovEJbqUWzdJrEZECod2QYjVlSJeM0G5tQS9V1kkEp1vYstXw==
X-Received: by 2002:ac2:511d:: with SMTP id q29mr7540386lfb.24.1589830950029; 
 Mon, 18 May 2020 12:42:30 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/22] target/mips: fpu: Name better paired-single variables
Date: Mon, 18 May 2020 21:41:43 +0200
Message-Id: <20200518194149.16281-17-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use consistently 'l' and 'h' for low and high halves.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56ba49104e..dbb8ca5692 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1059,14 +1059,14 @@ uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
 
 uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
 {
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
-                       &env->active_fpu.fp_status);
+    fstl2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
+                        &env->active_fpu.fp_status);
     fsth2 = float32_div(float32_one, fdt0 >> 32, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
@@ -1091,15 +1091,15 @@ uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
 
 uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
 {
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    fstl2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
     fsth2 = float32_sqrt(fdt0 >> 32, &env->active_fpu.fp_status);
-    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_div(float32_one, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_div(float32_one, fsth2, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
@@ -1367,19 +1367,19 @@ uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 
 uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
     uint32_t fsth2 = fdt2 >> 32;
 
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one,
+    fstl2 = float32_chs(float32_sub(fstl2, float32_one,
                                        &env->active_fpu.fp_status));
     fsth2 = float32_chs(float32_sub(fsth2, float32_one,
                                        &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
@@ -1404,51 +1404,51 @@ uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 
 uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
     uint32_t fsth2 = fdt2 >> 32;
 
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
+    fstl2 = float32_sub(fstl2, float32_one, &env->active_fpu.fp_status);
     fsth2 = float32_sub(fsth2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+    fstl2 = float32_chs(float32_div(fstl2, FLOAT_TWO32,
                                        &env->active_fpu.fp_status));
     fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32,
                                        &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
     uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_add(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_add(fst1, fsth1, &env->active_fpu.fp_status);
+    fstl2 = float32_add(fstl0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_add(fstl1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
     uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_mul(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_mul(fst1, fsth1, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fstl1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 #define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-- 
2.20.1


