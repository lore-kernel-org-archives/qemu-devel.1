Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6CC55ABD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40CC20684
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiGWM7BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40CC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4Lr-0007RB-Ri
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc4L4-0006zi-Dg; Mon, 09 Nov 2020 05:23:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc4L2-0007yW-LG; Mon, 09 Nov 2020 05:23:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id s8so977015wrw.10;
 Mon, 09 Nov 2020 02:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4K3U1NewmUjwvna+a3l1Z82sMILfAkInSo7TJ3mQ3Sw=;
 b=RiGWM7BTatbZ8IPS/bcB80pRu5PeB+W4jdrchp266WXB5XObBXkcxrBSk5x6EDRhMQ
 ffD1JdgckHQe6oXl1aDWSUPpDw0MaTlDwZ761DRiJJCWaUidOPwh9Cvl3sXWWF7DVRnk
 p2vnoEVueciMF4/7BMSHcAa7Qdv20akL/d0IHyNmWbhmeWNwP1jX5Ky8jqA1rz6/aKfv
 /R5dP+6cXMrsLX+YBCH4/BQ0l6/yayNF4kdzhHnbwZ0yhJVTW2++9723g5DurGewCPKx
 CrViPHfgRc+OzDaGfiJwhgHVgonvOKBnxE4qe481NYvO8CnqXXMOksuxEJMRVv5QusrB
 Uyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4K3U1NewmUjwvna+a3l1Z82sMILfAkInSo7TJ3mQ3Sw=;
 b=oN/XIc1g41T4T84sD8vKSbogfbs46kgzASxEsEkMB93tFDKQqo7y/p97j7fVGQmtAF
 q10V5gY+oIP8lSd1DmVmDWkYXu958bXsPnOe5noWSXO4XoJ0p3LBh0jKqFmdlu1eeX1G
 nRyGIbj5GlO+Z5YFWocaWmfd2tlmdmlgVoQdtQk3YDy6xxWl292UeCiIy3w9T5j4tDMb
 7BCyjpSUbe6+M/Vg1yNVm23d6Kulst0Q46xxrO9/pkcNpKpU99ops/z3QURVW90lCj/d
 9a+N9f/Z9nxAWc0CFm08tSpNMKcmwbfCSsN1T8vcM/9gryfRHQMTcq1ngl6/ShGf2fSA
 fWCA==
X-Gm-Message-State: AOAM533m7IqEqidiG1/Vs8ZnNvtA4w3w0815OdYTKsArXUo65UObnf66
 6eJqIjohFvmqM1/yNsRgpGXZvhT5btKVgw==
X-Google-Smtp-Source: ABdhPJxeltd9fMeObORBlD+8VXf70g1IsISgpnDBSJ75eCfLQ6JtkBVqzXip9/hGf6lrpRa3XewVuA==
X-Received: by 2002:adf:e351:: with SMTP id n17mr17531931wrj.308.1604917430084; 
 Mon, 09 Nov 2020 02:23:50 -0800 (PST)
Received: from localhost.localdomain ([151.33.227.77])
 by smtp.gmail.com with ESMTPSA id a9sm8344483wrp.21.2020.11.09.02.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 02:23:49 -0800 (PST)
From: LemonBoy <thatlemon@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ppc/translate: Fix unordered f64/f128 comparisons
Date: Mon,  9 Nov 2020 11:21:47 +0100
Message-Id: <20201109102147.31747-1-thatlemon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=thatlemon@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the PowerISA v3.1 reference, Table 68 "Actions for xscmpudp
- Part 1: Compare Unordered", whenever one of the two operands is a NaN
the SO bit is set while the other three bits are cleared.

Apply the same change to xscmpuqp.

The respective ordered counterparts are unaffected.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 target/ppc/fpu_helper.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9b8c8b70b6..b07ff66375 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2479,13 +2479,11 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                      \
     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||        \
         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {        \
         vxsnan_flag = true;                                              \
-        cc = CRF_SO;                                                     \
         if (fpscr_ve == 0 && ordered) {                                  \
             vxvc_flag = true;                                            \
         }                                                                \
     } else if (float64_is_quiet_nan(xa->VsrD(0), &env->fp_status) ||     \
                float64_is_quiet_nan(xb->VsrD(0), &env->fp_status)) {     \
-        cc = CRF_SO;                                                     \
         if (ordered) {                                                   \
             vxvc_flag = true;                                            \
         }                                                                \
@@ -2497,12 +2495,19 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                      \
         float_invalid_op_vxvc(env, 0, GETPC());                          \
     }                                                                    \
                                                                          \
-    if (float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {         \
+    switch (float64_compare(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {\
+    case float_relation_less:                                            \
         cc |= CRF_LT;                                                    \
-    } else if (!float64_le(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) { \
-        cc |= CRF_GT;                                                    \
-    } else {                                                             \
+        break;                                                           \
+    case float_relation_equal:                                           \
         cc |= CRF_EQ;                                                    \
+        break;                                                           \
+    case float_relation_greater:                                         \
+        cc |= CRF_GT;                                                    \
+        break;                                                           \
+    case float_relation_unordered:                                       \
+        cc |= CRF_SO;                                                    \
+        break;                                                           \
     }                                                                    \
                                                                          \
     env->fpscr &= ~FP_FPCC;                                              \
@@ -2545,12 +2550,19 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
         float_invalid_op_vxvc(env, 0, GETPC());                         \
     }                                                                   \
                                                                         \
-    if (float128_lt(xa->f128, xb->f128, &env->fp_status)) {             \
+    switch (float128_compare(xa->f128, xb->f128, &env->fp_status)) {    \
+    case float_relation_less:                                           \
         cc |= CRF_LT;                                                   \
-    } else if (!float128_le(xa->f128, xb->f128, &env->fp_status)) {     \
-        cc |= CRF_GT;                                                   \
-    } else {                                                            \
+        break;                                                          \
+    case float_relation_equal:                                          \
         cc |= CRF_EQ;                                                   \
+        break;                                                          \
+    case float_relation_greater:                                        \
+        cc |= CRF_GT;                                                   \
+        break;                                                          \
+    case float_relation_unordered:                                      \
+        cc |= CRF_SO;                                                   \
+        break;                                                          \
     }                                                                   \
                                                                         \
     env->fpscr &= ~FP_FPCC;                                             \
-- 
2.27.0


