Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D2C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8B622225
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUBcHA1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8B622225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFd1j-0005YK-52
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczF-00022n-Er
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:37 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczD-0001LC-LV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:37 -0400
Received: by mail-ed1-x543.google.com with SMTP id l63so15814899edl.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lCrIb5WUVl3SkQdV+w3xyR/zikAcpGVj/acDDdcJ41k=;
 b=GUBcHA1wqnvxU9PRbwyJncSD8jwDS7+xXWNt6Sul3RQdFjWCvW2cI4uQ2lCKY2Wcdm
 vOeDHM9OeTcojR1WsvqzaolMGC/2ysfgG1yZBHrGwuhEAAjZHvcqYnTyaxrRvWB0XxLN
 W6lC5sZQaNCKr3Q13uypLX2aXHojXro+a7ZIqAhHjMbXloctrhu7ZSD/w87rVnZOWZRr
 VrI/oHRtRzKmPKBi5LbYL8e4+ux270Bhq2L+beO8Pp35e+SC7dp1GyefQ4sYqogE9oo7
 lXoaHtI8yVpzHTywkj/jWwLFkZNSB5tSjung+utPvH4TKUevFM5xUNq8ItRDDNonZ3nk
 l8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lCrIb5WUVl3SkQdV+w3xyR/zikAcpGVj/acDDdcJ41k=;
 b=rNFQ6tGM2J719osnefqqMNi3TTwoUoNQpnXNQLhBQIAmXGvJ/jQAlM9YheN4LSSRYW
 +05SDAFHyG61Whk1W+u5SJw2B8KTfkxbD19KRy0wDk5ih81rPUEklzPBTP8Vqa4+6HcB
 5diWtw/JaoLxVTv/smtlH+FiFH/JIS8IpU7flRxhWuvlQOn6iOttrQzTFMzDaTG3uTgE
 R/n1sQWNxc8T+THzEmZ316QA40VWTybDbCfu/BCLTiMZg/FT7zDnuDP1fOhHi5E/6n4T
 IoYrLqZsXJhou7UO0YMB+utfksY50AqF8fmYGWvoWnE21f20ti3vFKXpXCU6Ryju5iXB
 M71A==
X-Gm-Message-State: AOAM532RYSS2rux6+HV2K8GtKTU8ecgWGDGU5SHzTrz/QIW6U6jfsv0t
 71rPbGPn13RqjEuuHOUJ0PXYO68bxqo=
X-Google-Smtp-Source: ABdhPJx7/2ArYX2RyR9jknaODlJ/BLuBavNs2ZRrHyHFmkmV5t3Y2YxeTF8xV+c2PMLSdY9VfiDodw==
X-Received: by 2002:a50:84a2:: with SMTP id 31mr27602764edq.138.1599569074200; 
 Tue, 08 Sep 2020 05:44:34 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u23sm4396604ejc.108.2020.09.08.05.44.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:44:33 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/mips: Refactor helpers for fp comparison
 instructions
Date: Tue,  8 Sep 2020 14:44:28 +0200
Message-Id: <1599569068-9855-5-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change causes slighlty better performance of emulation of fp
comparison instructions via better compiler optimization of refactored
code. The functionality is otherwise unchanged.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 56 +++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index f480c7296e..22d533322b 100644
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
2.20.1


