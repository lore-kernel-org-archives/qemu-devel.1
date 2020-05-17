Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1206C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7504B206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD17Uy9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7504B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFfx-0003hs-N2
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX6-0004OD-3l
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:33 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX4-0001oK-V8
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:31 -0400
Received: by mail-lf1-x144.google.com with SMTP id a9so5383452lfb.8
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=VD17Uy9ZWVaZFYv5cwkEaHAZTWA5FTM9Tr3U0nTmlZeqT2lNG+9NfqNmXZ/vTuVna2
 ru+FcYLg5pWIPE8JubglpOPnkgwfXHf39KYeiFSx+fHAjwwRe4KNZIOEAsGKMwUsYUXX
 VvS2bVuNlLCz73DNc7l5g8g+FRpZNDV2X9r0dv79zJCC5nhgmMgWf6uMKRwvavFW31qz
 t2vQzG7PXSpzPrq7d3IT/Ov6kyW6z0pBlb/gbua3q1JCWU/PaAUfJEmLpJwwNcxeGWq+
 XiBxbZACBfO4OF8YVR1pj9ZCNm3k390QJTVlCIO/kvIH3oMwTK4NhKoVFGoUA73KnkF0
 bYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=NAgL+DfehnLJuTVOzDE+516B487t9RcN9tIuRWW/JLhQne2lihnvjMcZJkDkocYjeU
 P9Vg8ZdbPZP8OiB52KPWessjtwhX0nHjyss+Kf2XeBpQC7RR19dTHUj1E/cy5mzwqOaI
 /6Oyz6imgQ0k+9z6+q4DACpXHUV/CtwojDd9zPA3A3MoXO/3Hnx4mBlaauTCH+1apAZp
 3G8k0wtCeX5ejKab50sLR5mqSZMB+cKhLOrNRazJWe9k7RyReZllq2r59aInNIk5RlNC
 UVC5lQrIUNKDSK26xk1qiV9olIj9JwzyIo0OYLNHu8LvaX6P8cGChCJ7nRypdkDyOHl9
 qhQQ==
X-Gm-Message-State: AOAM533Lq/mK/n9GpQo8tcACYN9/OKR8D1Vj8LiV5kRGxaL2BlkGQCIw
 VI0Wdr/bJCyT9trOPtyPtfgRIIpuv8Y=
X-Google-Smtp-Source: ABdhPJzij94TNUGLRM8rBTaNzIxAqbuBxN6pIuvIb+2RwGRTKoU2lQRRalhpmx+pMaukizpzggaCUA==
X-Received: by 2002:ac2:4113:: with SMTP id b19mr7960982lfi.143.1589707468659; 
 Sun, 17 May 2020 02:24:28 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/19] target/mips: fpu: Remove now unused FLOAT_CLASS macro
Date: Sun, 17 May 2020 11:23:50 +0200
Message-Id: <20200517092357.1469-13-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing CLASS.<D|S>, this macro is not needed anymore.

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


