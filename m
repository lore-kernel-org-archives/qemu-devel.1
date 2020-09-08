Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2180C2BBD0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9007C21D81
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAemnoxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9007C21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFd0K-0003PG-Kd
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczG-00023N-Km
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:38 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczD-0001L5-Ij
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:38 -0400
Received: by mail-ed1-x541.google.com with SMTP id c10so15830395edk.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=59FKQ7FjWGaMx6p/hgj1RpZbTEenTpc0lYB9ZMhjTO0=;
 b=KAemnoxfBQ+nO1USzzfug3TssaL5EeZCvlxT0pYckJdeP2ZXgrfoqQrK/2A4naz2ZK
 2fghgpZu13p/ud7Kc9XPd+Pilkl1ZW2FYFBd4BYQp5z1vGGoiWkxJV3e9H88k53cYXVn
 Q3kwwnKvLDNKo+8wdjdXSy7TZ99dq/oSiuf+EjkISlE6pHh/9B/o0rum/lN6uSQXKA+k
 R+wXs1y+dWHqgDCEctZnPsYClo3qzMGKOglh6mS8RJrBoLo8nTouK4CwFOwA2moO5W2f
 AuJJ5ZOREBWjp2PbTe2Gx9t6ILYrL/jIK/51ce9IccRf7JEW4zFmBh36m1V3Jx2EToGK
 AkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=59FKQ7FjWGaMx6p/hgj1RpZbTEenTpc0lYB9ZMhjTO0=;
 b=XUtg5wiWH+/jThJ64XY4LHZjcNP7qKByHZa6ffU/8tzLRy2/kzz0ObS/oLkeG2qYpC
 CNg/XyXzVbFQ3t1GWw9eSi51pb5AG0gzdtkFuR/IeQ3Z5CoLzygO7blHOZsvNI1fUH7k
 UeQdPwKwoBacTeqi9GAfyWu3HzkuxhdzGf+Vbirw9KR3b8ym8hOe1X1oW2EBnH791Gp+
 u6aGL4tQr7pL1eGAY9O9Brb+upmBEO+rIGgXi1zgLPHOHdBpvrERzjnN16ZhiHdVS4Lg
 aG/BYDrI9qFXfh3ZBSGW+2oAtVZ8cvK0WIz7GNXP7hOI/Nbjjnkr1pAJ5Ryx3mXyarQM
 SGrw==
X-Gm-Message-State: AOAM5310vturKgmKQye5OGz3oAlWb28rRvbnWr+VEzq2Nmf6fj4gXwLQ
 DG6ANJ5KqtJBY9+h6+H7d3LsGzsLv0Q=
X-Google-Smtp-Source: ABdhPJyfNV9WzZ+GFjTXkjCziWt4HcwmFxK552NnSGtfbY1sNN0QwVboMD9CjXuMr8Gm1xM7yU4Qxw==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr26094683edi.273.1599569073489; 
 Tue, 08 Sep 2020 05:44:33 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u23sm4396604ejc.108.2020.09.08.05.44.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:44:33 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>
Date: Tue,  8 Sep 2020 14:44:27 +0200
Message-Id: <1599569068-9855-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x541.google.com
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

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 104 ++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 23 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 98313951cb..f480c7296e 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1475,29 +1475,87 @@ uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-#define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _ ## minmaxfunc(fs, ft,                    \
-                                           &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
-}
-
-FLOAT_MINMAX(max_s, 32, maxnum)
-FLOAT_MINMAX(max_d, 64, maxnum)
-FLOAT_MINMAX(maxa_s, 32, maxnummag)
-FLOAT_MINMAX(maxa_d, 64, maxnummag)
-
-FLOAT_MINMAX(min_s, 32, minnum)
-FLOAT_MINMAX(min_d, 64, minnum)
-FLOAT_MINMAX(mina_s, 32, minnummag)
-FLOAT_MINMAX(mina_d, 64, minnummag)
-#undef FLOAT_MINMAX
+
+uint32_t helper_float_max_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_max_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_maxa_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_maxa_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_min_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_min_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_mina_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_mina_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
 
 /* ternary operations */
 
-- 
2.20.1


