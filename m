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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52797C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC4120758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmqaJPvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamDU-0000dk-A8
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5v-0006at-1O
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:39 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5u-0002Ko-7s
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:38 -0400
Received: by mail-lj1-x243.google.com with SMTP id k5so4664491lji.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HYRUeAwktwnZJjXPTxlxiB/3mxTEsXooJ/Wo/+9Cf9s=;
 b=RmqaJPvOb8UqVZiUFtnm18r0Tt+efIXuq2mwJ1/He0g3Da/3PH/sYkCWWsK6czPaM0
 Vjpl8CYVWBZAGCVRklsebYkFFN83gkAKCrZxeI/ohpnD9inJiTQFRxYqn+h47+ly0wIO
 4cQCscVOJoq8AqDGsMCYm0tYkSBwEz5siiFEV2UjysfxbDXjuozsaRYEXd0LiC965kz1
 Uwr2xjLAlYcrNmKaFQM+IajMGGmAGgI04QAIjGfQmrmQ4rzCjLzsOsFfnIA+WFyqcU3l
 IusgIm7Ep9N63Bc1OD7WboNEQPNl5rDFGCF3WPKXs789zId9BVv5Xwjo2McY2jW4APuw
 NMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HYRUeAwktwnZJjXPTxlxiB/3mxTEsXooJ/Wo/+9Cf9s=;
 b=HA8v9bhv9hHINC1JRLYzDwQ0QbtU4Oks72h6lsHOL9vpMpKj2wqvn+LEWUgkL8ANR/
 q3Dpql/4c3lWw6Jk2Duo8FGbAdVBIk0ndQXmkWbArxdRX8orkHbBidd87eAV8EkVjO+V
 x5dg9oPkFSklfsI0pOvkTS0tRWFACJyxL3ZIkYjZnTApqqLC09XTqM6lVOhy2AT79GqO
 w1arRh4e/zlFO2c5JJQqakSqtkT3bV8FYLXvGdsYjF3RoNI1NbeKNPa9affMaycn31Xy
 ukbeOS6sfGAH/lq/pecRxKcVLFMmw74YCfTtCYZRT0ofu/QzCjn5AGCSiHLNGyOBmcPC
 WyJw==
X-Gm-Message-State: AOAM533xvL9Rp6gikSVf0Wg9HbS8kBcCDEiYX5TOGYfjPhcjdFVRwgGm
 r4ZIbw/goCS+et97RyNd1oK0enagUr8=
X-Google-Smtp-Source: ABdhPJwUiNIs00Jc9pCt6LNCM2fnV0ejx4DhkaTKieEOJi33dBvUfPq9DE98a48ZLqULS+2hCzMLlA==
X-Received: by 2002:a2e:9e97:: with SMTP id f23mr11242989ljk.228.1589832636427; 
 Mon, 18 May 2020 13:10:36 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:36 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/21] target/mips: fpu: Remove now unused FLOAT_CLASS macro
Date: Mon, 18 May 2020 22:09:11 +0200
Message-Id: <20200518200920.17344-13-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x243.google.com
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

After demacroing CLASS.<D|S>, this macro is not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index b3903f5357..e227e53f70 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1128,45 +1128,6 @@ FLOAT_RINT(rint_d, 64)
 #define FLOAT_CLASS_POSITIVE_SUBNORMAL 0x100
 #define FLOAT_CLASS_POSITIVE_ZERO      0x200
 
-#define FLOAT_CLASS(name, bits)                                      \
-uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,            \
-                                  float_status *status)              \
-{                                                                    \
-    if (float ## bits ## _is_signaling_nan(arg, status)) {           \
-        return FLOAT_CLASS_SIGNALING_NAN;                            \
-    } else if (float ## bits ## _is_quiet_nan(arg, status)) {        \
-        return FLOAT_CLASS_QUIET_NAN;                                \
-    } else if (float ## bits ## _is_neg(arg)) {                      \
-        if (float ## bits ## _is_infinity(arg)) {                    \
-            return FLOAT_CLASS_NEGATIVE_INFINITY;                    \
-        } else if (float ## bits ## _is_zero(arg)) {                 \
-            return FLOAT_CLASS_NEGATIVE_ZERO;                        \
-        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
-            return FLOAT_CLASS_NEGATIVE_SUBNORMAL;                   \
-        } else {                                                     \
-            return FLOAT_CLASS_NEGATIVE_NORMAL;                      \
-        }                                                            \
-    } else {                                                         \
-        if (float ## bits ## _is_infinity(arg)) {                    \
-            return FLOAT_CLASS_POSITIVE_INFINITY;                    \
-        } else if (float ## bits ## _is_zero(arg)) {                 \
-            return FLOAT_CLASS_POSITIVE_ZERO;                        \
-        } else if (float ## bits ## _is_zero_or_denormal(arg)) {     \
-            return FLOAT_CLASS_POSITIVE_SUBNORMAL;                   \
-        } else {                                                     \
-            return FLOAT_CLASS_POSITIVE_NORMAL;                      \
-        }                                                            \
-    }                                                                \
-}                                                                    \
-                                                                     \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,          \
-                                         uint ## bits ## _t arg)     \
-{                                                                    \
-    return float_ ## name(arg, &env->active_fpu.fp_status);          \
-}
-
-#undef FLOAT_CLASS
-
 uint64_t float_class_d(uint64_t arg, float_status *status)
 {
     if (float64_is_signaling_nan(arg, status)) {
-- 
2.20.1


