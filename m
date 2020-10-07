Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA6C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B8020760
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhtb3k0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B8020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQGCx-0001fa-B1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBq-0000L7-FA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kQGBo-0000fU-Md
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 16:37:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so4035587wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EKtvPHZiQ6oYWEIEFjZg8EoMRM75qY1XkqdS1cjxQJA=;
 b=Xhtb3k0utshMnCq3uWDI6Ke5JrKy6Mjwl0uzU6QNaXPz9GrDNdZRVU+OElqlClgqBF
 Vi5hdmGK3IqPiTNR3KVVrDm6DrZP4tS0vJyv8l6Q5Qfo5Ts3o6EsVXK3cabwo8DqKEhJ
 Gzsm5Wn3dq9aQAJoAq7zXTvhp9yLhfne2oWJAbQULPKGhrjMNvAmfZZZaO6BAYqtkiIo
 S0wCb6DB1JT6yZ/7ZivOC0daYCuTICu+yUK9OfJ7YRacMHXgyhOiscHqqD0wqXyS7qtq
 zEUd2gGVTx1G5JGn6z2ZkqN6KnHM/diImQblLwGT9ApUpF6/JZSae5Gspln9Bi8tGH12
 ZiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EKtvPHZiQ6oYWEIEFjZg8EoMRM75qY1XkqdS1cjxQJA=;
 b=k69blzYBryNpmMYezMHJzFBIADf4vqSZUTTjG5SEkjbCElYCjuflUFgEDqNzWV3+/w
 PFpEIyRQtogoJgL4a8hFwayaby8ssieEDpNeiqRAAXfnJcMsxB8HEGkGQP9bDfpgsz9N
 WeJTl7eBNCGYfHTfXGlbcqRJoX9aMiZpTmun1NzbAgYIZK73hPUCgikAP7ytTq8363wN
 V6D7n8txx1Pput9l/CEd3AU1BIR1XuJKDLAwk1xNuM+iKgnu7qylW4J+tfxM+4iIDaeu
 gJdMmsfeo90rokuATp+1FzmFDmLUquk9WnnNyQef/JT0GKpzjoQacs5V/wZg75uYJ9ga
 0Z9A==
X-Gm-Message-State: AOAM5319bAbLXELt4mTykSsOJZeWmsFviJ42Kgk5RnhqYw08bfhTFzq1
 cI1mXFg36K8hTOD2Rdjp09znM+gw4aA=
X-Google-Smtp-Source: ABdhPJyLTzyA5/TNTgdo1eEhawPxOxeBq0VB4ORkxFqOv54rPvCAEsGkDCxkKW13hBV2vxHy982Hww==
X-Received: by 2002:a1c:4904:: with SMTP id w4mr4774432wma.99.1602103051267;
 Wed, 07 Oct 2020 13:37:31 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id d2sm4359083wro.34.2020.10.07.13.37.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 13:37:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] target/mips: Refactor helpers for fp comparison
 instructions
Date: Wed,  7 Oct 2020 22:37:20 +0200
Message-Id: <1602103041-32017-5-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com, f4bug@amsat.org,
 jiaxun.yang@flygoat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change causes slighlty better performance of emulation of fp
comparison instructions via better compiler optimization of refactored
code. The functionality is otherwise unchanged.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 56 +++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 6cc956c..8d48a5b 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1780,11 +1780,12 @@ void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
 {                                                              \
     int c;                                                     \
     c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
+    if (c) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
+    } else {                                                   \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
+    }                                                          \
+    update_fcr31(env, GETPC());                                \
 }                                                              \
 void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
                             uint64_t fdt1, int cc)             \
@@ -1793,11 +1794,12 @@ void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
     fdt0 = float64_abs(fdt0);                                  \
     fdt1 = float64_abs(fdt1);                                  \
     c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
+    if (c) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
+    } else {                                                   \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
+    }                                                          \
+    update_fcr31(env, GETPC());                                \
 }
 
 /*
@@ -1859,11 +1861,12 @@ void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
 {                                                              \
     int c;                                                     \
     c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
+    if (c) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
+    } else {                                                   \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
+    }                                                          \
+    update_fcr31(env, GETPC());                                \
 }                                                              \
 void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
                             uint32_t fst1, int cc)             \
@@ -1872,11 +1875,12 @@ void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
     fst0 = float32_abs(fst0);                                  \
     fst1 = float32_abs(fst1);                                  \
     c = cond;                                                  \
-    update_fcr31(env, GETPC());                                \
-    if (c)                                                     \
+    if (c) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                      \
-    else                                                       \
+    } else {                                                   \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
+    }                                                          \
+    update_fcr31(env, GETPC());                                \
 }
 
 /*
@@ -1944,15 +1948,17 @@ void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
     fsth1 = fdt1 >> 32;                                         \
     cl = condl;                                                 \
     ch = condh;                                                 \
-    update_fcr31(env, GETPC());                                 \
-    if (cl)                                                     \
+    if (cl) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                       \
-    else                                                        \
+    } else {                                                    \
         CLEAR_FP_COND(cc, env->active_fpu);                     \
-    if (ch)                                                     \
+    }                                                           \
+    if (ch) {                                                   \
         SET_FP_COND(cc + 1, env->active_fpu);                   \
-    else                                                        \
+    } else {                                                    \
         CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
+    }                                                           \
+    update_fcr31(env, GETPC());                                 \
 }                                                               \
 void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
                              uint64_t fdt1, int cc)             \
@@ -1965,15 +1971,17 @@ void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
     fsth1 = float32_abs(fdt1 >> 32);                            \
     cl = condl;                                                 \
     ch = condh;                                                 \
-    update_fcr31(env, GETPC());                                 \
-    if (cl)                                                     \
+    if (cl) {                                                   \
         SET_FP_COND(cc, env->active_fpu);                       \
-    else                                                        \
+    } else {                                                    \
         CLEAR_FP_COND(cc, env->active_fpu);                     \
-    if (ch)                                                     \
+    }                                                           \
+    if (ch) {                                                   \
         SET_FP_COND(cc + 1, env->active_fpu);                   \
-    else                                                        \
+    } else {                                                    \
         CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
+    }                                                           \
+    update_fcr31(env, GETPC());                                 \
 }
 
 /*
@@ -2080,12 +2088,12 @@ uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
 {                                                                   \
     uint64_t c;                                                     \
     c = cond;                                                       \
-    update_fcr31(env, GETPC());                                     \
     if (c) {                                                        \
         return -1;                                                  \
     } else {                                                        \
         return 0;                                                   \
     }                                                               \
+    update_fcr31(env, GETPC());                                     \
 }
 
 /*
@@ -2175,12 +2183,12 @@ uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
 {                                                                   \
     uint64_t c;                                                     \
     c = cond;                                                       \
-    update_fcr31(env, GETPC());                                     \
     if (c) {                                                        \
         return -1;                                                  \
     } else {                                                        \
         return 0;                                                   \
     }                                                               \
+    update_fcr31(env, GETPC());                                     \
 }
 
 /*
-- 
2.7.4


