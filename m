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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2945820643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv5FhDZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945820643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalld-00041g-AB
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleU-0002Zd-Qq
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleT-0004UJ-Dh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:18 -0400
Received: by mail-lf1-x144.google.com with SMTP id e125so8365612lfd.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k7kVdFWxaVWdBi77zbtYk3nbD/a6snV2/hS5/I/5yJI=;
 b=dv5FhDZZieZql8EoQCgmf1i41OTbrtsLrvT/U/3jlaMetARcMKquK6j8YypcAPNcND
 Aru5RHpDaqIdQOzxYCXQ2nNy4ZqaPPJq1GIJnIjWcZ9PViQpz8PEuEfpC+UnEvPvpiDJ
 nbUVzIBt4nBh/KgUnSsWzUIOMJv/0b8AwDjQZtRy+NbGBycnSUcf7vEKSZPCIQTpo2NI
 VP5nshRpZV2y0xL1amTLL8Q9vtZhIDBnjxD9nOhm8mcJkKz1XRfis6PsdFuzOuixsYyV
 cj/JsekjfMoth+HBkJsOJDgBDH1H7/fehmmCyllH2WzF/wiPftqFfNrHpOLpabXntdaW
 zE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k7kVdFWxaVWdBi77zbtYk3nbD/a6snV2/hS5/I/5yJI=;
 b=oNKxmOQS2qXX3u6mxltX8nMzqNWfieETzj2qaQd7lw9yydvi9sxHRbQjWZOutlpFk3
 4JAZ4ze4yM4+VqfwXOQpvFVuBPaKk3x9IkE7x4D7r0LS4gBM916lAGwRZcn+J5qTdAfn
 bhUHUa/+mPwk3nw12mSgLUH/wqGVgYp7G/sfiTQl1Pm5sqQPD1zxhUnNJ7yADHScIQ8s
 gIkyTsO5pZM7RNEuOGMJkHiHJdrOt5/t/WUddSbS66C8fa6MxAOLmybVXwzM6pEbq9Ea
 Oxn5w67ERw4pvf8cMXXjzWdj6w+R2ZQB0Ou0gnisIKQCtJ00OXjkucnzooQDS7+fOfqT
 4qvg==
X-Gm-Message-State: AOAM533aol9cInrC0CvSulG7ygK+wdA4A1KuRd5iSA+riqdGKhgAgmt3
 3UPGf1wStxFvDaFsP7fzMji977FW/T4=
X-Google-Smtp-Source: ABdhPJxiv50poMVcfcQwCQ70qhl8pFa3+Cpzwy4PRgWXYL23h9SIUkdUK5WS9jJG/okvcMe5DV53xg==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr8609200lfa.20.1589830935744; 
 Mon, 18 May 2020 12:42:15 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:15 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/22] target/mips: fpu: Remove now unused macro FLOAT_BINOP
Date: Mon, 18 May 2020 21:41:33 +0200
Message-Id: <20200518194149.16281-7-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x144.google.com
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

After demacroing <ADD|SUB|MUL|DIV>.<D|S|PS>, this macro is not
needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 2759c9989d..a3a39681f8 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1170,45 +1170,6 @@ FLOAT_CLASS(class_d, 64)
 #undef FLOAT_CLASS
 
 /* binary operations */
-#define FLOAT_BINOP(name)                                          \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
-                                     uint64_t fdt0, uint64_t fdt1) \
-{                                                                  \
-    uint64_t dt2;                                                  \
-                                                                   \
-    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return dt2;                                                    \
-}                                                                  \
-                                                                   \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
-                                     uint32_t fst0, uint32_t fst1) \
-{                                                                  \
-    uint32_t wt2;                                                  \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return wt2;                                                    \
-}                                                                  \
-                                                                   \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
-                                      uint64_t fdt0,               \
-                                      uint64_t fdt1)               \
-{                                                                  \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                             \
-    uint32_t fsth0 = fdt0 >> 32;                                   \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                             \
-    uint32_t fsth1 = fdt1 >> 32;                                   \
-    uint32_t wt2;                                                  \
-    uint32_t wth2;                                                 \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
-    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
-    update_fcr31(env, GETPC());                                    \
-    return ((uint64_t)wth2 << 32) | wt2;                           \
-}
-
-#undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
                             uint64_t fdt0, uint64_t fdt1)
-- 
2.20.1


