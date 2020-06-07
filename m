Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AACF2074B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlnUV/l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AACF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1R1-00021W-FU
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fd-0003vC-Gu
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fc-0004mL-Hi
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id y17so15128951wrn.11
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q6q7t9tSS7YYJl/56wzx9zU6oawDbEcXsYW5V6PJrnU=;
 b=ZlnUV/l9iBLbfos4OpP9NdzWQBGpJioRb5gz4vo0rdt1U/vyEt/mSHF5IR0XmJvnVJ
 Y7XB0WzNgM51tXYhR2CaXJy/rqMru2CePwmS7UvAmwRSJPugLMc/bMvX0zXYSSih0QN+
 SHanMCEsSFCiOw20AXzneIgYOfHEMfBLr+1nUzmuVpTBHQ8rRLIXr0pongLXhbDieHk9
 QE5N4VYIsdXjQYzG9TwO0Cf2gAozJ8nAmKcEWRibv33hM8Gk4vbTgCJbvvqWdQUV8byy
 cQR2QyHFDr/8u5ICcnwUsUv+PnoxvCt/6+CDT8BdLzH3mcX+RsVGt8TL8+J4koJn16dY
 GLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q6q7t9tSS7YYJl/56wzx9zU6oawDbEcXsYW5V6PJrnU=;
 b=GQy4hSyy3wxLkAO+ucZ75xTtnC+io2o781cZokkb14BzMxfdUbo0MvWaasRjwI7I2y
 S30hThJ19juohes+48qj2XdBIBU9hTlxHFCtwa1z/JVXQmCHSJzHOnNPPtkgobEJepXO
 rzhEBwhjMI54k+J+MrEPcJWIyfM4XNQIzY/IsakPRM3pan9Qu58slw11hVoG9xQ6tqD9
 92Ht+rIkspgnLKzl0xtapUDfCKApGLbfjfNCkfJCsLMNpAV/tVdBKp7kO+PZGrX3CRwG
 Hkvl7nUeGku9BQS5lboHh0XJYzV6XXzyM3DFUB6djcTpyqEghc23R05r8DR2zeRe5JlV
 thog==
X-Gm-Message-State: AOAM533WCb5b9Wfj6ZdTKwucHFJQrKo/VixbM3hxxzX+CMLAHkHSgtnB
 jTD5OYs5FY6wnMKOMSSNhlrHjQEf
X-Google-Smtp-Source: ABdhPJzwLc1zKeIlydm+9FCCyMUH9arlYcj2bpUmNqDyQn4aO98OGdr7cQDTrk5zDHXAVrKKM3k4Rw==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr19979122wrw.295.1591559195090; 
 Sun, 07 Jun 2020 12:46:35 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:34 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 12/21] target/mips: fpu: Remove now unused UNFUSED_FMA and
 FLOAT_FMA macros
Date: Sun,  7 Jun 2020 21:46:16 +0200
Message-Id: <1591559185-31287-13-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing <MADD|MSUB|NMADD|NMSUB>.<D|S|PS>, these macros
are not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-11-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 50 ------------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 927bac2..e8e50e4 100644
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
2.7.4


