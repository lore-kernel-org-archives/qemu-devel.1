Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6BDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112FB2065C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXNPMctA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112FB2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJey-0004HQ-U6
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ9-0007P5-QW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ5-0007O1-MS
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:28 -0400
Received: by mail-lj1-x244.google.com with SMTP id l19so4772721lje.10
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=kXNPMctAQcKLQ3583WtPo8i0cET5yyO52cowUejsrgljQPhTZxJW1Hd/F2QO5ElKZr
 BuWRBQWqpPsm2NiJc8RSQT3DJUc46iGbJC/Hgu9Yw2eV0u2VnXl2hwjNtmeYDT6BdUnL
 vxKyTtoBU2jT/CL+bhqtBG3LudGsdukBn0wLRhDSuzUW1z6e8TNl0N6e/dspyHfNha3R
 VRBa8e8VJRzgMNvrL4zYJWdan1FoMDVyydQ3zTTV5pxHmqgKjIPHNZyiPKR5Etp5qEWS
 2A9LEbu8LCggtHx77scwYZygt9/eKUc7IFoUqnzf+mK60jIQn1mtLC4xRu46isiyqW9O
 SwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=IWJk4gP6HBVDkoYimWTDccDbv/a4DnOYy+S6pTCFL9eVwex3T4KeDkNo5+nfGmXu+I
 ulvb2JUhl/sVN+C7QhY4A0jsHTPVXLo1TXblZRZSszB7zQLcQM3QaPbb6NmcI+D2MoXy
 v++C4J5ed1x44EYQcRrJmHexSmH2Q75lQuWxOSyOkZr7fJsWM5B+bX9K5zehAcUynkpW
 oRzC6pbVjZmiciSD2w5793srV2pYkaapYqZ8Pag1SHV6jYHD3Gp6E2zbvB38QnwI6HVX
 iNIAuApzvmPwvAlO+LpdB5kyluIUQiVZ83TRB9skarVHj6qmzHZdoG+aH2mPTLQkIEWw
 oHjw==
X-Gm-Message-State: AOAM530qhy0RMNR9nB1n/71tPNUCLtp0qht/+ZEkyHDakG3hdJ1s+wFl
 QHSP9mV+srsBTMDIj49T+9NCdFBVCbU=
X-Google-Smtp-Source: ABdhPJw1out4JIbd89oLqAqKbuL0MR0BHvxM7PjyRYWQolb/1EG9h2hnQkNipgUGraTNsLe5WFuGIQ==
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr3859606ljc.292.1589484083975; 
 Thu, 14 May 2020 12:21:23 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:23 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/17] target/mips: fpu: Remove now unused FLOAT_CLASS macro
Date: Thu, 14 May 2020 21:20:42 +0200
Message-Id: <20200514192047.5297-13-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x244.google.com
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


