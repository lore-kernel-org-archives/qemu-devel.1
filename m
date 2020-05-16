Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7407C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E403206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQhTeZQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E403206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja10Q-0007dM-NX
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0ta-0003PD-JY
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:46 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tZ-0008Op-QH
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:46 -0400
Received: by mail-lj1-x241.google.com with SMTP id o14so5581729ljp.4
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=UQhTeZQcRCitoxVdrs8hdiIxqJmpwNcaCJml7cMH/D/6oQ/x/1wrnJtEgHeEi14ugs
 cnOO2yMV2/JgDyHd3QyQQfhVrJ8IJrFrsO/55z5tTS5W2yygT4b9COddPC1p8MEcJHTT
 bhrpMeNdeNWTW2M7pGZFTH+Rm9lyJiSPIOVV3XyYLFFDmRLhzN7qGsqT72/UfhQiCH8q
 B1dhSFIJrPvZE7C7IyW7A2CRmamOEopB40yQTtDiw0/stx9/BbABCOp3vlaZ7NEkLJ+Z
 ztWiCo8D9+xwdb6C0iL+onNoWfYEmxYblsI7oJqRJjkbZg++6+ijZjulTOuwKhs5OnRY
 1bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YIyeyf4CRuuipu/MCNsonP1ZNqoTXUAtMHmKuATIrmc=;
 b=MEDm1Zq9Di2/KfGTPjiZ14OeXr3SSeMBpBcFQcklxm3t+xX7om+Hf21Fz8/p7t0oLE
 +mIxx0Y/YoSWcMdEpCCB4H8ic4PeBA3Fix9tqxwvDuYchlcOQkVePiXMLBtmQA05RqEJ
 O5rxKc29RctINWCUDei2NT6UYCTZScdwWSX/lfO5B5I3YjICNmToMQjWiXvEltiCn4MN
 9Kc2nuh7ID2255MNldGUIwbboeEPCTSS2WjSRnHMYS8o9uzOkpF/x0CtC6wRs6D7b1+9
 oPPYLeZh2aCiJ6wPTDm3swgfFMiLPlBFnPa5hSyp1/TTvaABmlHk0q8eIE8b/+5YoL/k
 uf4Q==
X-Gm-Message-State: AOAM531Fc9zb1NhVd1UPevOnHcUmYBxGMfWtohBl15y40HIaodSpO6gj
 2KyKZWeG4Cncmgoef+RnCZSYhBRMwpI=
X-Google-Smtp-Source: ABdhPJzW8ekxF0eDQEoVV8rb0olK0fEgnCD5fVp8G8n988so75dj2s30qf5Id5fq+Zan/iXEc/M8XA==
X-Received: by 2002:a2e:9d8c:: with SMTP id c12mr5928794ljj.67.1589651204185; 
 Sat, 16 May 2020 10:46:44 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:43 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/18] target/mips: fpu: Remove now unused FLOAT_CLASS macro
Date: Sat, 16 May 2020 19:45:42 +0200
Message-Id: <20200516174548.7631-13-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
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


