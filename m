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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8ADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E916C20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs929psf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E916C20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJd9-0001xJ-0v
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ4-0007I9-DL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ3-0007Nf-IB
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:24 -0400
Received: by mail-lj1-x242.google.com with SMTP id b6so4843004ljj.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LEEebxVW8gD5Jf3WtTY6qNXWnlQDM14seyCqM6owgfg=;
 b=cs929psf5lsZdmIw3oM/9KUHqC9g8tPW09beiZZfAiCbVL0AdHdp8nJKO/Mn/R1TtQ
 tyYJJqhVsewg5l8O02/RlsoWeGAOmZ5Oh5629v4HVWtoXa4xWSegAVPtk6WHB+wLSzZW
 fe6QtTLyCRf4BaAC8KqdzCgzvi8cAX+F/5Nxycdpqj9UQzF+i7v8ShAEEPDEzkVWCrDW
 xbveIhuo3/ZVE1+BrV5aV2JBreF5vXLlYShZuINtewEdi2ClIDGuR8UwMDX0lzG4dAMJ
 2VReXThPj8EIuesizqO95Z6PmtFle2aZInZIW+P/r3w4DQjhgtnyMcMm/XmEpOmHaEUR
 FsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LEEebxVW8gD5Jf3WtTY6qNXWnlQDM14seyCqM6owgfg=;
 b=YVvXRUrl1+pbt9o3/h12Eh7wcARDRAjoqy70ooz4RHMhNFer54dr5UqJJG6JrH3NF7
 r5qQ1fdHmLYWE+iA+B+YxH0CfEroeag71Xf8JdyzrucGFXkUS4W7NMnXYfK5hnCwwye8
 7I+QOctzjxqXd32Rd3qrYJG4ct2OVaijIEkwQkZJhduLu4UPZuSq2XV2sbmWjeFXPfLh
 G/rgIDhG4tvyYEmF3Hl5K+r1cArKzpI3qIMnLsTIVKg3IYhfiCmxwnHpOCO1S2WzUi/G
 YvyoapnnTRpAwIhIZoVJhMgnJQyuZJ2r1rHMnAM6g/1hpfzzZ9z0CLmHQMU+fBZOHtTd
 od5w==
X-Gm-Message-State: AOAM533G9iCTu4aeGp8vteZZUc28uW44uv1T5hOUtUQOqqRApPZOfMlz
 IG3rV0vyZK7JuYlEwydzUh9PqVrcojo=
X-Google-Smtp-Source: ABdhPJyZCfSr4VjQtwmASOAEmXx3YHARYQE9C55fSs6fHvtjQ26Cx6dZXE9xEfCIiBIu9YNG/wHccw==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr3928550ljm.289.1589484081298; 
 Thu, 14 May 2020 12:21:21 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:20 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] target/mips: fpu: Remove now unused UNFUSED_FMA and
 FLOAT_FMA macros
Date: Thu, 14 May 2020 21:20:40 +0200
Message-Id: <20200514192047.5297-11-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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

After demacroing <MADD|MSUB|NMADD|NMSUB>.<D|S|PS>, these macros
are not needed anymore.

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


