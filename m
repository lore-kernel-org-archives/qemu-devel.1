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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A52C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D241120643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6kniwh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D241120643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamII-0006ts-1H
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5s-0006TE-SE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:36 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5s-0002K5-0v
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:36 -0400
Received: by mail-lj1-x242.google.com with SMTP id v16so7206442ljc.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/SGzR0VfdaMngvwcIJ4Z6wJcDUJ7yTUrhHwIwtU8Nc=;
 b=D6kniwh8xzrSKL0hsbbZLQ5MEnoS6v6ytwbD1Pj2IL5NKHw3yPTxRIGQLzZYmey/uu
 YjCF9+CnVEv+zJSpwRTGfeFLk7bYCVH2sLHg1uujEhN3zMFGw9L5aGEmoE4dEZoQgFWO
 Uhnwyt6Plz2vA7uCpNF6piKIzMBFlLvf12unGRbN6BNs8hVaFXYEXvRnKomm1N052bmi
 K47WeP6m9eNyGMubhCbYbHg77XI6CVe/+peexvgtqaRd1wBKihwTMe5TYzNaXqmEdsMm
 T4bp2Poc4tAFnBxz+/EZiLPQVKxuF82wob0ovyRwZf3VuO0sf/17xlPVbk6eQKwgtsjV
 cCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/SGzR0VfdaMngvwcIJ4Z6wJcDUJ7yTUrhHwIwtU8Nc=;
 b=LiPEoq091KfFGe2lWlaFyl4dgO2VQCzlDdHLG9suOK9hcFYhpWA89wUIKXAse36dKE
 TIsJZQvfroO4rQKlPmRZrwKbmmAFos2KzgvPOjjCfteWSkPkPBPEhYyQyYqgly5PSOcg
 ODSNCT3e6RIS5BuhdDOnPIXIGyDZJHJBVKdUfU4v4W5TrGDE2rAhEaZQ+FtJILEDwSZp
 2AtkIiOoTM/RxZ9oXXW7E4oqsVV8Xb3DPTijIPgAmzobfRoESoXhaGLuVq83deJVBSIT
 o5t2lGaLJDgcUfHogUrc1QYZlR9DWbKB/H9eM29Uzn4KxZGxuc+kxpyUTztdGF4olWf5
 gKOQ==
X-Gm-Message-State: AOAM531YCKc6esh5iHCL1AuB1yl/zc7dDbS/z4BME5sfBRzDQBZuWwhs
 gr2lcpWK58iaUmn82163H33ypOSpQE4=
X-Google-Smtp-Source: ABdhPJx+hRZhxj/bra7KFNmSC8MsA3iasABVPkdLIRyQ8FKNPKiRgVqKs6bNlsWfMueeO4YFAHXdqQ==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr8496225ljh.274.1589832634239; 
 Mon, 18 May 2020 13:10:34 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:33 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/21] target/mips: fpu: Remove now unused UNFUSED_FMA and
 FLOAT_FMA macros
Date: Mon, 18 May 2020 22:09:09 +0200
Message-Id: <20200518200920.17344-11-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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

After demacroing <MADD|MSUB|NMADD|NMSUB>.<D|S|PS>, these macros
are not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 927bac24ac..e8e50e4bc0 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1446,56 +1446,6 @@ FLOAT_MINMAX(mina_d, 64, minnummag)
 #undef FLOAT_MINMAX
 
 /* ternary operations */
-#define UNFUSED_FMA(prefix, a, b, c, flags)                          \
-{                                                                    \
-    a = prefix##_mul(a, b, &env->active_fpu.fp_status);              \
-    if ((flags) & float_muladd_negate_c) {                           \
-        a = prefix##_sub(a, c, &env->active_fpu.fp_status);          \
-    } else {                                                         \
-        a = prefix##_add(a, c, &env->active_fpu.fp_status);          \
-    }                                                                \
-    if ((flags) & float_muladd_negate_result) {                      \
-        a = prefix##_chs(a);                                         \
-    }                                                                \
-}
-
-/* FMA based operations */
-#define FLOAT_FMA(name, type)                                        \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,              \
-                                     uint64_t fdt0, uint64_t fdt1,   \
-                                     uint64_t fdt2)                  \
-{                                                                    \
-    UNFUSED_FMA(float64, fdt0, fdt1, fdt2, type);                    \
-    update_fcr31(env, GETPC());                                      \
-    return fdt0;                                                     \
-}                                                                    \
-                                                                     \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,              \
-                                     uint32_t fst0, uint32_t fst1,   \
-                                     uint32_t fst2)                  \
-{                                                                    \
-    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
-    update_fcr31(env, GETPC());                                      \
-    return fst0;                                                     \
-}                                                                    \
-                                                                     \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
-                                      uint64_t fdt0, uint64_t fdt1,  \
-                                      uint64_t fdt2)                 \
-{                                                                    \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                               \
-    uint32_t fsth0 = fdt0 >> 32;                                     \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                               \
-    uint32_t fsth1 = fdt1 >> 32;                                     \
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;                               \
-    uint32_t fsth2 = fdt2 >> 32;                                     \
-                                                                     \
-    UNFUSED_FMA(float32, fst0, fst1, fst2, type);                    \
-    UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);                 \
-    update_fcr31(env, GETPC());                                      \
-    return ((uint64_t)fsth0 << 32) | fst0;                           \
-}
-#undef FLOAT_FMA
 
 uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
                              uint64_t fst1, uint64_t fst2)
-- 
2.20.1


